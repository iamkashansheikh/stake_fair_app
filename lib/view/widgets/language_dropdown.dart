import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/getx_controller/country_picker_controller.dart';

class LanguageDropdown extends StatelessWidget {
  final CountryPickerController controller = Get.put(CountryPickerController());

  final List<Map<String, dynamic>> countries = [
    {"dialCode": "+44", "flag": "🇬🇧", "language": "English (UK)", "locale": Locale('en', 'GB')},
    {"dialCode": "+91", "flag": "🇮🇳", "language": "हिन्दी (India)", "locale": Locale('hi', 'IN')},
    {"dialCode": "+880", "flag": "🇧🇩", "language": "বাংলা (বাংলাদেশ)", "locale": Locale('bn', 'BD')},
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          icon: const Icon(Icons.keyboard_arrow_down),
          value: controller.selectedCountryCode.value,
          onChanged: (value) {
            if (value != null) {
              var selectedCountry = countries.firstWhere((c) => c["dialCode"] == value);

              controller.updateCountry(
                selectedCountry["dialCode"],
                selectedCountry["flag"],
                selectedCountry["language"],
                selectedCountry["locale"],
              );
            }
          },
          selectedItemBuilder: (BuildContext context) {
            return countries.map((country) {
              return CircleAvatar(
                radius: 20,
                backgroundColor: Colors.transparent,
                child: Text(controller.selectedCountryFlag.value, style: const TextStyle(fontSize: 18)),
              );
            }).toList();
          },
          items: countries.map((country) {
            return DropdownMenuItem<String>(
              value: country["dialCode"],
              child: Text("${country["language"]}"),
            );
          }).toList(),
        ),
      ),
    );
  }
}
