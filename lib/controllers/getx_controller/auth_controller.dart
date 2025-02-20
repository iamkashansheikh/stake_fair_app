import 'package:get/get.dart';

class AuthController extends GetxController{
 var selectedIcon = 0.obs;

   var selectedCountryCode = '+1'.obs; // Default USA
  var selectedCountryFlag = '🇺🇸'.obs; // Default flag

  void updateCountry(String code, String flag) {
    selectedCountryCode.value = code;
    selectedCountryFlag.value = flag;

     var selectedGender = ''.obs;

  void selectGender(String gender) {
    selectedGender.value = gender;
  }
  }
}