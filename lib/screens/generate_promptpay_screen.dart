import 'package:flutter/material.dart';
import 'package:prompypay_qr_test/Content/result_screen.dart';
import 'package:prompypay_qr_test/data/data_type.dart';

class GeneratePromptpayScreen extends StatefulWidget {
  const GeneratePromptpayScreen({super.key});

  @override
  State<GeneratePromptpayScreen> createState() => _GeneratePromptpayScreenState();
}

class _GeneratePromptpayScreenState extends State<GeneratePromptpayScreen> {
  String phoneNumber = "";
  String nationalID = "";

  final _phoneTextEditController = TextEditingController();
  final _nationalTextEditController = TextEditingController();

  DataType selectedType = DataType.phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("QR Code Promptpay"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ResultScreen(
                  dataType: selectedType,
                  data: selectedType == DataType.phoneNumber ? phoneNumber : nationalID,
                ),
                SizedBox(
                  width: double.infinity,
                  child: SegmentedButton<DataType>(
                    segments: const [
                      ButtonSegment(value: DataType.phoneNumber, label: Text("Phone Number")),
                      ButtonSegment(value: DataType.nationalID, label: Text("National ID"))
                    ],
                    selected: <DataType>{selectedType},
                    onSelectionChanged: (newSelection) {
                      setState(() {
                        selectedType = newSelection.first;
                      });
                    },
                  ),
                ),
                _displayInput(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _displayInput() {
    if (selectedType == DataType.phoneNumber) {
      return TextField(
        controller: _phoneTextEditController,
        decoration: const InputDecoration(hintText: "เบอร์โทรศัพท์"),
        keyboardType: TextInputType.phone,
        onChanged: (text) {
          setState(() {
            phoneNumber = text;
          });
        },
      );
    } else {
      return TextField(
        controller: _nationalTextEditController,
        decoration: const InputDecoration(hintText: "บัตรประชาชน"),
        keyboardType: TextInputType.phone,
        onChanged: (text) {
          setState(() {
            nationalID = text;
          });
        },
      );
    }
  }
}
