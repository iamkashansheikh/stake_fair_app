import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stake_fair_app/controllers/getx_controller/country_picker_controller.dart';
import 'package:stake_fair_app/firebase_options.dart';
import 'package:stake_fair_app/res/routs/app_routs.dart';
import 'package:stake_fair_app/res/routs/app_routs_name.dart';
import 'package:stake_fair_app/view/screens/app_Loacalization/app_local.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final CountryPickerController controller = Get.put(CountryPickerController());

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690), // ✅ Fix screen size for responsiveness
      minTextAdapt: true,
      splitScreenMode: true,
      child: GetMaterialApp(
        translations: AppTranslations(), // ✅ Added translations
        locale: Locale('en', 'US'), // ✅ Default language
        fallbackLocale: Locale('en', 'US'), // ✅ Fallback in case of an error
        debugShowCheckedModeBanner: false,
        initialRoute: RoutsName.homeScreen,
        getPages: AppRouts.pages,
      ),
    );
  }
}
