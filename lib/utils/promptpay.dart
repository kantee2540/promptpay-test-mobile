import 'dart:convert';
import 'package:crclib/catalog.dart';
import 'package:prompypay_qr_test/data/data_type.dart';

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

  String generateMerchantQR() {
    final versionTag = _generateTag("00", "01");
    final point = _generateTag("01", "11");

    return "";
  }
}
