import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/getx_controller/country_picker_controller.dart';

class LanguageDropdown extends StatelessWidget {
  final CountryPickerController controller = Get.put(CountryPickerController());

  final List<Map<String, dynamic>> countries = [
    {"dialCode": "+1", "flag": "🇺🇸", "language": "English (US)", "locale": Locale('en', 'US')},
    {"dialCode": "+44", "flag": "🇬🇧", "language": "English (UK)", "locale": Locale('en', 'GB')},
    {"dialCode": "+91", "flag": "🇮🇳", "language": "हिन्दी (India)", "locale": Locale('hi', 'IN')},
    {"dialCode": "+33", "flag": "🇫🇷", "language": "Français (France)", "locale": Locale('fr', 'FR')},
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          icon: Icon(Icons.arrow_drop_down, color: Colors.blue),
          value: "${controller.selectedCountryCode.value},${controller.selectedCountryFlag.value}",
          onChanged: (value) {
            if (value != null) {
              var parts = value.split(',');
              var selectedCountry = countries.firstWhere((c) => c["dialCode"] == parts[0]);

              controller.updateCountry(
                parts[0], // Country Code
                parts[1], // Flag
                selectedCountry["language"], // Language
                selectedCountry["locale"], // Locale
              );
            }
          },
          selectedItemBuilder: (BuildContext context) {
            return countries.map((country) {
              return CircleAvatar(
                radius: 20,
                child: Text(controller.selectedCountryFlag.value, style: TextStyle(fontSize: 18)),
                backgroundColor: Colors.transparent,
              );
            }).toList();
          },
          items: countries.map((country) {
            return DropdownMenuItem<String>(
              value: "${country["dialCode"]},${country["flag"]}",
              child: Text("${country["language"]}"),
            );
          }).toList(),
        ),
      ),
    );
  }
}
