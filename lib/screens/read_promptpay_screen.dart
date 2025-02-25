import 'package:flutter/material.dart';
import 'package:prompypay_qr_test/components/extract_result_item.dart';
import 'package:prompypay_qr_test/models/emv_tag_model.dart';
import 'package:prompypay_qr_test/utils/promptpay.dart';

class ReadPromptpayScreen extends StatefulWidget {
  const ReadPromptpayScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ReadPromptpayScreenState();
}

class _ReadPromptpayScreenState extends State<ReadPromptpayScreen> {
  String readData = "";
  List<EmvTagModel> extractTags = [];
  bool isCheckSumPassed = false;

  void _readEmv() {
    final pp = Promptpay();
    final tagList = pp.readEmvTags(readData);

    final crcTag = tagList.firstWhere((element) {
      return element.tag == "63" || element.tag == "91";
    }, orElse: () => EmvTagModel(tag: "00", strLength: "00", data: ""));

    setState(() {
      extractTags = tagList;
      isCheckSumPassed = false;
    });

    if (crcTag.tag != "00") {
      final isCheckPassed = pp.isCheckSumCorrect(readData);
      setState(() {
        isCheckSumPassed = isCheckPassed;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Read Prompypay",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Text("ตรวจสอบ QR Code พร้อมเพย์ว่ามีอะไรบ้างพร้อมตรวจสอบ Checksum"),
              _renderInput(),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () {
                        _readEmv();
                      },
                      child: const Text("Read"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Row(
                children: [
                  Text(
                    "Tags Extract Results",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: _extractResultList(),
              ),
              const SizedBox(height: 16),
              const Row(
                children: [
                  Text(
                    "String Checksum Result",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              _checkSumResult(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderInput() {
    return TextField(
      decoration: const InputDecoration(hintText: "ข้อมูลจาก QR Code"),
      onChanged: (value) {
        setState(() {
          readData = value;
        });
      },
    );
  }

  Widget _extractResultList() {
    if (extractTags.isNotEmpty) {
      return ListView.separated(
        itemBuilder: (context, index) {
          final item = extractTags[index];
          return ExtractResultItem(tag: item.tag, length: item.strLength, data: item.data);
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemCount: extractTags.length,
      );
    } else {
      return const Text("Read Emv Tag to see tag detail");
    }
  }

  Widget _checkSumResult() {
    if (isCheckSumPassed) {
      return const Row(
        children: [
          Icon(
            Icons.check_circle,
            color: Colors.green,
          ),
          SizedBox(width: 8),
          Text(
            "Check Sum Passed!",
            style: TextStyle(color: Colors.green, fontSize: 16),
          ),
        ],
      );
    } else {
      return const Row(
        children: [
          Icon(Icons.remove_circle_outlined, color: Colors.red),
          SizedBox(width: 8),
          Text(
            "Not found CRC Tag or Incorrect!",
            style: TextStyle(color: Colors.red, fontSize: 16),
          )
        ],
      );
    }
  }
}
