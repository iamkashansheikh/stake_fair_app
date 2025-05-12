import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stake_fair_app/res/routs/app_routs.dart';
import 'package:stake_fair_app/res/routs/app_routs_name.dart';
import 'package:stake_fair_app/view/screens/Menu/My_Markets/my_market.dart';
import 'package:stake_fair_app/view/screens/app_Loacalization/app_local.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FlutterDownloader.initialize(debug: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
            title: 'Stake Fair App',
            debugShowCheckedModeBanner: false,
            translations: AppTranslations(),
            locale: Locale('en', 'US'),
            fallbackLocale: Locale('en', 'US'),
            initialRoute: RoutsName.virsion,
            getPages: AppRouts.pages,
            //  home:MyMarketScreen()
            );

      },
    );
  }
}



