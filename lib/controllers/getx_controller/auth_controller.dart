import 'package:get/get.dart';

class AuthController extends GetxController{
 var selectedIcon = 1.obs;
var selectedCountryCode = '+92'.obs; // Pakistan Code
var selectedCountryFlag = '🇵🇰'.obs; // Pakistan Flag
var selectedCountryName = 'Pakistan'.obs;


  void updateCountry(String code, String flag, String name) {
    selectedCountryCode.value = code;
    selectedCountryFlag.value = flag;
    selectedCountryName.value = name;

     var selectedGender = ''.obs;

  void selectGender(String gender) {
    selectedGender.value = gender;
  }
  }
}