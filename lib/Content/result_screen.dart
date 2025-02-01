import 'package:flutter/material.dart';
import 'package:prompypay_qr_test/data/data_type.dart';
import 'package:prompypay_qr_test/utils/promptpay.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    super.key,
    required this.dataType,
    required this.data,
  });

  final DataType dataType;
  final String data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 64,
              color: const Color.fromARGB(255, 0, 66, 122),
              child: Image.asset("assets/thai_qr_banner.jpg"),
            ),
            _qrContent(),
          ],
        ),
      ),
    );
  }

  Widget _qrContent() {
    final qrCode = Promptpay();

    final qrData = qrCode.generatePersonalQR(dataType, data);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          QrImageView(
            data: qrData,
            version: QrVersions.auto,
            size: 200.0,
          ),
          Text(
            qrData,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text("ID : $data"),
        ],
      ),
    );
  }
}
