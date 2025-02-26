import 'package:get/get.dart';
import 'package:stake_fair_app/res/routs/app_routs_name.dart';
import 'package:stake_fair_app/view/Check_file.dart';
import 'package:stake_fair_app/view/screens/authentication/forgot_password_screen.dart';
import 'package:stake_fair_app/view/screens/authentication/login_screen.dart';
import 'package:stake_fair_app/view/screens/authentication/sign_up_screen.dart';
import 'package:stake_fair_app/view/screens/home_screen.dart';
import 'package:stake_fair_app/virsionCheck/virsion_check.dart';

class AppRouts {
  static final List<GetPage> pages = [
    GetPage(name: RoutsName.login, page: () =>  LoginScreen()),
    GetPage(name: RoutsName.signup, page: () =>  SignUpScreen()),
    GetPage(name: RoutsName.forgotpass, page: () =>  ForgotPasswordScreen()),
    GetPage(name: RoutsName.homeScreen, page: () =>  HomeScreen()),
    GetPage(name: RoutsName.virsion, page: () => const VersionCheck()),
     GetPage(name: RoutsName.check, page: () => const CheckFile())
  ];
  
}