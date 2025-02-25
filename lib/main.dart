import 'package:flutter/material.dart';
import 'package:prompypay_qr_test/components/screen_navigate_item.dart';
import 'package:prompypay_qr_test/models/navigation_item_model.dart';
import 'package:prompypay_qr_test/screens/generate_promptpay_screen.dart';
import 'package:prompypay_qr_test/screens/read_promptpay_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<StatefulWidget> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  List<NavigationItemModel> navigationItems = [
    NavigationItemModel(
      title: "Generate QR Code",
      description: "Test Generate QR Code PromptPay",
      screen: const GeneratePromptpayScreen(),
    ),
    NavigationItemModel(
      title: "Read EMV Tag",
      description: "Extract Tags in QR Code",
      screen: const ReadPromptpayScreen(),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue), textTheme: TextTheme()),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Promptpay Test"),
        ),
        body: ListView.builder(
          itemCount: navigationItems.length,
          itemBuilder: (context, index) {
            return ScreenNavigateItem(
              title: navigationItems[index].title,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => navigationItems[index].screen),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
