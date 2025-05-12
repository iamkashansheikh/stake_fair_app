import 'package:get/get.dart';
import 'package:stake_fair_app/res/routs/app_routs_name.dart';
import 'package:stake_fair_app/view/screens/Menu/My_Markets/my_market.dart';
import 'package:stake_fair_app/view/screens/Menu/Settings/select_language.dart';
import 'package:stake_fair_app/view/screens/Menu/Settings/setting.dart';
import 'package:stake_fair_app/view/screens/Menu/menu_screen.dart';
import 'package:stake_fair_app/view/screens/authentication/forgotten_password.dart';
import 'package:stake_fair_app/view/screens/authentication/login_screen.dart';
import 'package:stake_fair_app/view/screens/authentication/sign_up_screen.dart';
import 'package:stake_fair_app/view/screens/cash_out/cashout_screen.dart';
import 'package:stake_fair_app/view/screens/home_screen.dart';
import 'package:stake_fair_app/view/screens/inplay_screen.dart';
import 'package:stake_fair_app/view/screens/markets/rules.dart';
import 'package:stake_fair_app/view/screens/mybets.dart';
import 'package:stake_fair_app/virsionCheck/virsion_check.dart';

class AppRouts {
  static final List<GetPage> pages = [
    GetPage(name: RoutsName.login, page: () =>  LoginScreen()),
    GetPage(name: RoutsName.signup, page: () =>  SignUpScreen()),
    GetPage(name: RoutsName.forgotpass, page: () =>  ForgottenPassword()),
    GetPage(name: RoutsName.homeScreen, page: () =>  HomeScreen()),
    GetPage(name: RoutsName.virsion, page: () =>  VersionCheck()),
    GetPage(name: RoutsName.inplay, page: () =>  InplayScreen()),
    GetPage(name: RoutsName.ruleScreen, page: () =>  RulesScreen()),
    GetPage(name: RoutsName.menuScreen, page: () =>  MenuScreen()),
    GetPage(name: RoutsName.CashoutScreen, page: () =>  CashoutScreen()),
    GetPage(name: RoutsName.MyBetsScreen, page: () =>  MyBetsScreen()),
    GetPage(name: RoutsName.myMarket, page: () =>  MyMarketScreen()),
    GetPage(name: RoutsName.setting, page: () =>  SettingScreen()),
    GetPage(name: RoutsName.selectLanguage, page: () =>  SelectLanguageScreen()),
  ];
  
}