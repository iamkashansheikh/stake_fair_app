import 'package:get/get.dart';
import 'package:stake_fair_app/res/routs/app_routs_name.dart';
import 'package:stake_fair_app/view/screens/authentication/forgotten_password.dart';
import 'package:stake_fair_app/view/screens/authentication/login_screen.dart';
import 'package:stake_fair_app/view/screens/authentication/sign_up_screen.dart';
import 'package:stake_fair_app/view/screens/home_screen.dart';
import 'package:stake_fair_app/view/screens/inplay_screen.dart';
import 'package:stake_fair_app/virsionCheck/virsion_check.dart';

class AppRouts {
  static final List<GetPage> pages = [
    GetPage(name: RoutsName.login, page: () =>  LoginScreen()),
    GetPage(name: RoutsName.signup, page: () =>  SignUpScreen()),
    GetPage(name: RoutsName.forgotpass, page: () =>  ForgottenPassword()),
    GetPage(name: RoutsName.homeScreen, page: () =>  HomeScreen()),
    GetPage(name: RoutsName.virsion, page: () => const VersionCheck()),
    GetPage(name: RoutsName.inplay, page: () =>  InplayScreen()),
   // GetPage(name: RoutsName.common, page: () => const CommonScreen(categoryId: categoryId, eventName: eventName, eventIcon: eventIcon))
  ];
  
}