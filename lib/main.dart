import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stake_fair_app/view/screens/home_screen.dart';
import 'package:stake_fair_app/view/screens/webview_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen()
    );
  }
}


