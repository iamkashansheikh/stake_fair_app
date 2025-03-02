import 'package:get/get.dart';
import 'dart:ui';

class CountryPickerController extends GetxController {
  var selectedCountryCode = "+44".obs;
  var selectedCountryFlag = "🇬🇧".obs;
  var selectedLanguage = "English - UK".obs;

  void updateCountry(String countryCode, String flag, String language, Locale locale) {
    selectedCountryCode.value = countryCode;
    selectedCountryFlag.value = flag;
    selectedLanguage.value = language;
    Get.updateLocale(locale);
  }
}