import 'dart:ui';

import 'package:get/get.dart';

class CountryPickerController extends GetxController {
  var selectedCountryCode = "+44".obs; // Default UK
  var selectedCountryFlag = "🇬🇧".obs; // Default UK flag
  var selectedLanguage = "English (UK)".obs;

  void updateCountry(String countryCode, String flag, String language, Locale locale) {
    selectedCountryCode.value = countryCode;
    selectedCountryFlag.value = flag;
    selectedLanguage.value = language;
    Get.updateLocale(locale); // Update app language
  }
}