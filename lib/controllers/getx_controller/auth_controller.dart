import 'package:get/get.dart';

class AuthController extends GetxController{
 var selectedIcon = 1.obs;
var selectedCountryCode = '+92'.obs; // Pakistan Code
var selectedCountryFlag = '🇵🇰'.obs; // Pakistan Flag


  void updateCountry(String code, String flag) {
    selectedCountryCode.value = code;
    selectedCountryFlag.value = flag;

     var selectedGender = ''.obs;

  void selectGender(String gender) {
    selectedGender.value = gender;
  }
  }
}