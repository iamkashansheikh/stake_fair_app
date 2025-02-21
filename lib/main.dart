import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'view/screens/authentication/login_screen.dart';
import 'view/screens/authentication/sign_up_screen.dart';
import 'view/screens/home_screen.dart';
import 'view/widgets/country_code_picker.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;

    return ScreenUtilInit(
      designSize: Size(mediaQuerySize.width, mediaQuerySize.height),
      minTextAdapt: true,
      splitScreenMode: true,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
         home: LoginScreen()),
    );
  }
}

