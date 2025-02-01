import 'package:flutter/material.dart';
import 'package:prompypay_qr_test/Content/result_screen.dart';
import 'package:prompypay_qr_test/data/data_type.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<StatefulWidget> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String phoneNumber = "";
  String nationalID = "";

  DataType selectedType = DataType.phoneNumber;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                  const SizedBox(height: 16),
                  const Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec hendrerit tellus in faucibus elementum. Integer sed mauris eu elit rutrum condimentum. Nulla ex urna, semper sed felis ut, bibendum volutpat enim. Pellentesque at elementum turpis. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Nunc augue eros, pharetra id viverra ut, sollicitudin a nisl. Etiam ut leo non augue tristique laoreet eu ut dolor. Suspendisse potenti. Aliquam scelerisque erat eget orci lobortis, in condimentum tortor faucibus. Fusce eget facilisis magna. Proin sit amet mauris vel ex rutrum finibus. Curabitur vestibulum odio ac orci tempor vehicula. Aenean congue quam eu neque suscipit, eget vulputate eros varius.s",
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _displayInput() {
    if (selectedType == DataType.phoneNumber) {
      return TextField(
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
