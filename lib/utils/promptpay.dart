import 'dart:convert';
import 'package:crclib/catalog.dart';
import 'package:prompypay_qr_test/data/data_type.dart';
import 'package:prompypay_qr_test/models/emv_tag_model.dart';

class Promptpay {
  String _generateTag(String tagData, String value) {
    final valueLength = value.length.toString().padLeft(2, '0');
    return "$tagData$valueLength$value";
  }

  String _checkSum(String content) {
    final crc = Crc16CcittFalse().convert(utf8.encode(content));
    return crc.toRadixString(16);
  }

  String _generateTag29(DataType type, String data) {
    final presentedTag = _generateTag("00", "A000000677010111");
    final phoneNumberTag = _generateTag("01", data.padLeft(13, "0"));
    final nationalIDTag = _generateTag("02", data.padLeft(13, "0"));

    return "$presentedTag${type == DataType.phoneNumber ? phoneNumberTag : nationalIDTag}";
  }

  String _generateTag30(String billerID, String ref1, String ref2) {
    final presentedTag = _generateTag("00", "A000000677010112");
    final billerIDTag = _generateTag("01", billerID);
    final ref1Tag = _generateTag("02", ref1);
    final ref2Tag = _generateTag("03", ref2);

    return "$presentedTag$billerIDTag$ref1Tag$ref2Tag";
  }

  String generatePersonalQR(DataType type, String data) {
    final versionTag = _generateTag("00", "01");
    final point = _generateTag("01", "11");
    final personalQRTag = _generateTag("29", _generateTag29(type, data));

    final currencyTag = _generateTag("53", "764");
    final countryTag = _generateTag("58", "TH");

    final dataContent = "$versionTag$point$personalQRTag$currencyTag${countryTag}6304";
    final crcTag = _checkSum(dataContent);

    final finalContent = "$dataContent$crcTag";

    return finalContent;
  }

  String generateMerchantQR(String billerID, String ref1, String ref2) {
    final versionTag = _generateTag("00", "01");
    final point = _generateTag("01", "11");
    final merchantTag = _generateTag("30", _generateTag30(billerID, ref1, ref2));

    final currencyTag = _generateTag("53", "764");
    final countryTag = _generateTag("58", "TH");

    final dataContent = "$versionTag$point$merchantTag$currencyTag${countryTag}6304";
    final crcTag = _checkSum(dataContent);

    final finalContent = "$dataContent$crcTag";

    return finalContent;
  }

  List<EmvTagModel> readEmvTags(String str) {
    List<EmvTagModel> tags = [];

    String remainStr = str;

    while (remainStr.isNotEmpty) {
      if (remainStr.length > 4) {
        final tag = remainStr.substring(0, 2);
        final len = remainStr.substring(2, 4);
        final lenInt = int.parse(len);
        if (remainStr.substring(4).length >= lenInt) {
          int startDataPosition = 4;
          int endDataPosition = startDataPosition + lenInt;
          final data = remainStr.substring(startDataPosition, endDataPosition);

          final cutStr = remainStr.substring(endDataPosition);

          print("TAG = $tag | LEN = $len | DATA = $data");
          print("-" * 60);

          remainStr = cutStr;

          tags.add(EmvTagModel(tag: tag, strLength: len, data: data));
        } else {
          break;
        }
      } else {
        break;
      }
    }

    return tags;
  }

  bool isCheckSumCorrect(String dataStr) {
    final rawDataStr = dataStr.substring(0, dataStr.length - 4);
    final crcData = dataStr.substring(dataStr.length - 4);
    final checkSumData = _checkSum(rawDataStr).toUpperCase();

    return crcData == checkSumData;
  }
}
