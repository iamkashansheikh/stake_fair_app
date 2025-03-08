import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:stake_fair_app/controllers/getx_controller/auth_controller.dart';
import 'package:stake_fair_app/view/widgets/custom_field_widget.dart';

class CountryCodePickerWidget extends StatefulWidget {
  CountryCodePickerWidget({Key? key}) : super(key: key);

  @override
  State<CountryCodePickerWidget> createState() => _CountryCodePickerWidgetState();
}

class _CountryCodePickerWidgetState extends State<CountryCodePickerWidget> {
  final AuthController controller = Get.put(AuthController());
  final TextEditingController phoneController = TextEditingController();
  FocusNode phoneFocus = FocusNode();

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return IntrinsicHeight( // ✅ Prevents layout shrink
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // ✅ Aligns dropdown properly
        children: [
          Container(
            height: screenHeight * 0.07,
            width: MediaQuery.of(context).size.width * 0.35,
            padding: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.07),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Obx(
              () => DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  alignment: Alignment.bottomLeft,
                  icon: Icon(Icons.keyboard_arrow_down),
                  value: controller.selectedCountryName.value,
                  onChanged: (value) {
                    if (value != null) {
                      var selectedCountry =
                          countries.firstWhere((country) => country.name == value);
                      controller.updateCountry(
                        "+${selectedCountry.dialCode}",
                        selectedCountry.flag,
                        selectedCountry.name,
                      );
                    }
                  },
                  selectedItemBuilder: (BuildContext context) {
                    return countries.map((country) {
                      return Row(
                        children: [
                          Text(controller.selectedCountryFlag.value, style: TextStyle(fontSize: 18)),
                          SizedBox(width: 10),
                          Text(
                            controller.selectedCountryCode.value,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ],
                      );
                    }).toList();
                  },
                  items: countries.map((country) {
                    bool isSelected = country.name == controller.selectedCountryName.value;
                    return DropdownMenuItem<String>(
                      value: country.name,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10), // ✅ Added padding for better spacing
                            child: Row(
                              children: [
                                if (isSelected) Icon(Icons.check, color: Colors.black, size: 20),
                                SizedBox(width: isSelected ? 8 : 0),
                                Expanded(
                                  child: Text(
                                    country.name,
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500), // ✅ Reduced font size
                                    overflow: TextOverflow.ellipsis, // ✅ Prevents text overflow
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container( // ✅ Better looking divider
                            height: 0.8, 
                            color: Colors.grey.shade300,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  dropdownColor: Colors.white,
                  elevation: 3,
                  menuMaxHeight: screenHeight * 0.95, // ✅ Increased dropdown height to 95% of screen
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: CustomField(
              hintText: "Mobile Number".tr,
              controller: phoneController,
              focusNode: phoneFocus,
              keyboardType: TextInputType.phone,
              maxLength: 10,
            ),
          ),
        ],
      ),
    );
  }
}







// import 'package:get/get.dart';
// import 'package:intl_phone_field/countries.dart';
// import 'package:stake_fair_app/controllers/getx_controller/auth_controller.dart';
// import 'package:stake_fair_app/view/widgets/custom_field_widget.dart';

// class CountryCodePickerWidget extends StatefulWidget {
//   CountryCodePickerWidget({Key? key}) : super(key: key);

//   @override
//   State<CountryCodePickerWidget> createState() => _CountryCodePickerWidgetState();
// }

// class _CountryCodePickerWidgetState extends State<CountryCodePickerWidget> {
//   final AuthController controller = Get.put(AuthController());
//   final TextEditingController phoneController = TextEditingController();
//   FocusNode phoneFocus = FocusNode();

//   @override
//   void dispose() {
//     phoneController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size mediaQuerySize = MediaQuery.of(context).size;

//     return Row(
//       children: [
//         Container(
//           height: mediaQuerySize.height * 0.06,
//           width: mediaQuerySize.width * 0.3.w,
//           padding: EdgeInsets.symmetric(horizontal: 8),
//           decoration: BoxDecoration(
//             color: Colors.black.withOpacity(0.07),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Obx(
//             () => DropdownButtonHideUnderline(
//               child: DropdownButton<String>(
//                 isExpanded: true,
//                 alignment: Alignment.bottomLeft, // Ensures dropdown appears below
//                 icon: Icon(Icons.keyboard_arrow_down),
//                 value: controller.selectedCountryName.value, // Selected country name
//                 onChanged: (value) {
//                   if (value != null) {
//                     var selectedCountry =
//                         countries.firstWhere((country) => country.name == value);
//                     controller.updateCountry(
//                       "+${selectedCountry.dialCode}",
//                       selectedCountry.flag,
//                       selectedCountry.name,
//                     );
//                   }
//                 },
//                 selectedItemBuilder: (BuildContext context) {
//                   return countries.map((country) {
//                     return Align(
//                       alignment: Alignment.centerLeft,
//                       child: Row(
//                         children: [
//                           Text(controller.selectedCountryFlag.value), // Show flag
//                           SizedBox(width: 5),
//                           Text(controller.selectedCountryCode.value), // Show code
//                         ],
//                       ),
//                     );
//                   }).toList();
//                 },
//                 items: countries.map((country) {
//                   bool isSelected = country.name == controller.selectedCountryName.value;

//                   return DropdownMenuItem<String>(
//                     value: country.name, // Dropdown shows only country names
//                     child: Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 6.0),
//                           child: Row(
//                             children: [
//                               if (isSelected)
//                                 Icon(Icons.check, color: Colors.black, size: 20), // ✔ Left Tick Mark
//                               SizedBox(width: isSelected ? 8 : 0), // Space if tick exists
//                               Expanded(
//                                 child: Text(
//                                   country.name,
//                                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//                                   overflow: TextOverflow.ellipsis, // Prevents overflow
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Divider(color: Colors.grey.shade300, height: 1), // Horizontal divider
//                       ],
//                     ),
//                   );
//                 }).toList(),
//                 dropdownColor: Colors.white,
//                 elevation: 3, // Add slight shadow for better UI
//                 menuMaxHeight: 300, // Prevent overflow by limiting dropdown height
//                 borderRadius: BorderRadius.circular(8), // Rounded dropdown
//               ),
//             ),
//           ),
//         ),
//         SizedBox(width: 10),
//         Expanded(
//           child: CustomField(
//             hintText: "Mobile Number".tr,
//             controller: phoneController,
//             focusNode: phoneFocus,
//             keyboardType: TextInputType.phone,
//             maxLength: 10, // Stops at 10 digits
//           ),
//         ),
//       ],
//     );
//   }
// }


// // import 'package:flutter/material.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:get/get.dart';
// // import 'package:intl_phone_field/countries.dart';
// // import 'package:stake_fair_app/controllers/getx_controller/auth_controller.dart';
// // import 'package:stake_fair_app/view/widgets/custom_field_widget.dart';

// // class CountryCodePickerWidget extends StatefulWidget {
// //   CountryCodePickerWidget({Key? key}) : super(key: key);

// //   @override
// //   State<CountryCodePickerWidget> createState() => _CountryCodePickerWidgetState();
// // }

// // class _CountryCodePickerWidgetState extends State<CountryCodePickerWidget> {
// //   final AuthController controller = Get.put(AuthController());
// //   final TextEditingController phoneController = TextEditingController();
// //   FocusNode phoneFocus = FocusNode();

// //   @override
// //   void dispose() {
// //     super.dispose();
// //     phoneController.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     Size mediaQuerySize = MediaQuery.of(context).size;

// //     return Row(
// //       children: [
// //         Container(
// //           height: mediaQuerySize.height * 0.06,
// //           width: mediaQuerySize.width * 0.3.w,
// //           padding: EdgeInsets.symmetric(horizontal: 8),
// //           decoration: BoxDecoration(
// //             color: Colors.black.withOpacity(0.07),
// //             borderRadius: BorderRadius.circular(8),
// //           ),
// //           child: Obx(
// //             () => DropdownButtonHideUnderline(
// //               child: DropdownButton<String>(
// //                 isExpanded: true,
// //                 icon: Icon(Icons.keyboard_arrow_down),
// //                 value: controller.selectedCountryName.value, // Store selected country name
// //                 onChanged: (value) {
// //                   if (value != null) {
// //                     var selectedCountry =
// //                         countries.firstWhere((country) => country.name == value);
// //                     controller.updateCountry(
// //                       "+${selectedCountry.dialCode}",
// //                       selectedCountry.flag,
// //                       selectedCountry.name,
// //                     );
// //                   }
// //                 },
// //                 selectedItemBuilder: (BuildContext context) {
// //                   return countries.map((country) {
// //                     return Align(
// //                       alignment: Alignment.centerLeft,
// //                       child: Row(
// //                         children: [
// //                           Text(controller.selectedCountryFlag.value), // Show flag
// //                           SizedBox(width: 5),
// //                           Text(controller.selectedCountryCode.value), // Show code
// //                         ],
// //                       ),
// //                     );
// //                   }).toList();
// //                 },
// //                 items: countries.map((country) {
// //                   return DropdownMenuItem<String>(
// //                     value: country.name, // Dropdown shows only country names
// //                     child: Text(country.name),
// //                   );
// //                 }).toList(),
// //                 dropdownColor: Colors.white,
// //               ),
// //             ),
// //           ),
// //         ),
// //         SizedBox(width: 10),
// //         Expanded(
// //           child: CustomField(
// //   hintText: "Mobile Number".tr,
// //   controller: phoneController,
// //   focusNode: phoneFocus,
// //   keyboardType: TextInputType.phone,
// //   maxLength: 10, // Stops at 10 digits
// // )/

// //         ),
// //       ],
// //     );
// //   }
// // }
