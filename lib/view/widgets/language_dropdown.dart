import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stake_fair_app/res/responsive.dart';
import '../../controllers/getx_controller/country_picker_controller.dart';

class LanguageDropdown extends StatelessWidget {
  final CountryPickerController controller = Get.put(CountryPickerController());

  final List<Map<String, dynamic>> countries = [
    {
      "dialCode": "+44",
      "flag": "🇬🇧",
      "language": "English (UK)",
      "locale": Locale('en', 'GB')
    },
    {
      "dialCode": "+91",
      "flag": "🇮🇳",
      "language": "हिन्दी (India)",
      "locale": Locale('hi', 'IN')
    },
    {
      "dialCode": "+880",
      "flag": "🇧🇩",
      "language": "বাংলা (Bengali)",
      "locale": Locale('bn', 'BD')
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BaseResponsiveScreen(
        child: GestureDetector(
          onTap: () {
            // Finding the selected item index to position it at the top
            int selectedIndex = countries.indexWhere((country) =>
                country["dialCode"] == controller.selectedCountryCode.value);

            showMenu(
              context: context,
              position: RelativeRect.fromLTRB(
                  150, 60, 10, 0), // Adjusted dropdown position
              items: [
                // Reordering the list to bring the selected item to the top
                ...[
                  if (selectedIndex != -1) countries[selectedIndex],
                  ...countries.where((c) =>
                      c["dialCode"] != controller.selectedCountryCode.value),
                ].map((country) {
                  bool isSelected = country["dialCode"] ==
                      controller.selectedCountryCode.value;
                  return PopupMenuItem<String>(
                    value: country["dialCode"],
                    padding: EdgeInsets.zero, // Removes extra padding
                    child: Container(
                      width: 80.w, // Adjust width for compact look
                      padding:
                          EdgeInsets.symmetric(vertical: 6.h, horizontal: 4.w),
                      color: isSelected
                          ? Colors.blue
                          : Colors.transparent, // Solid blue background
                      child: Text(
                        country["language"],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10.sp,
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal),
                      ),
                    ),
                    onTap: () {
                      controller.updateCountry(
                        country["dialCode"],
                        country["flag"],
                        country["language"],
                        country["locale"],
                      );
                    },
                  );
                }).toList(),
              ],
            );
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 15.r,
                backgroundColor: Colors.transparent,
                child: Text(controller.selectedCountryFlag.value,
                    style: TextStyle(fontSize: 18.sp)),
              ),
              // SizedBox(width: 8.w),
              const Icon(Icons.keyboard_arrow_down),
            ],
          ),
        ),
      ),
    );
  }
}
