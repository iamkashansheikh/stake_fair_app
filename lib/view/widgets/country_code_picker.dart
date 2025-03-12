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
  FocusNode phoneFocusNode = FocusNode();

  // Observables for validation errors
  var phoneError = RxnString();
  var countryError = RxnString();

  /// ✅ Phone Number Validator
  void validatePhoneNumber(String value) {
    if (value.isEmpty) {
      phoneError.value = "Please enter a valid phone number";
    } else if (!RegExp(r'^\d{10}\$').hasMatch(value)) {
      phoneError.value = "Phone number must be exactly 10 digits";
    } else {
      phoneError.value = null;
    }
    setState(() {});
  }

  void validateCountrySelection() {
    if (controller.selectedCountryName.value.isEmpty) {
      countryError.value = "Please select a country";
    } else {
      countryError.value = null;
    }
  }

  @override
  void dispose() {
    phoneController.dispose();
    phoneFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Country Picker
              Stack(
                children: [
                  Container(
                    height: screenHeight * 0.065,
                    width: MediaQuery.of(context).size.width * 0.35,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.07),
                      borderRadius: BorderRadius.circular(6),
                      border: Border(bottom: BorderSide(color: Colors.green, width: 1)),
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
                              validateCountrySelection();
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
                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                    child: Row(
                                      children: [
                                        if (isSelected) Icon(Icons.check, color: Colors.black, size: 16),
                                        SizedBox(width: isSelected ? 8 : 0),
                                        Expanded(
                                          child: Text(
                                            country.name,
                                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 0.8, 
                                    color: Colors.grey.shade300,
                                    margin: EdgeInsets.symmetric(horizontal: 4),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          dropdownColor: Colors.white,
                          elevation: 3,
                          menuWidth: screenWidth * 0.75,
                          menuMaxHeight: screenHeight * 0.95,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 10),
              // Phone Number Field
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomField(
                      hintText: "Mobile Number".tr,
                      controller: phoneController,
                      focusNode: phoneFocusNode,
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      onChanged: validatePhoneNumber,
                    ),
                    Obx(
                      () => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: Container(
                          height: 1,
                          width: double.infinity,
                          color: phoneError.value == null ? Colors.transparent : Colors.transparent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Phone Number Validation Message
        Obx(
          () => phoneError.value != null
              ? Padding(
                  padding: const EdgeInsets.only(top: 4, left: 8),
                  child: Row(
                    children: [
                      Icon(Icons.cancel, color: Colors.red, size: 14),
                      SizedBox(width: 4),
                      Text(
                        phoneError.value!,
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                    ],
                  ),
                )
              : SizedBox.shrink(),
        ),
      ],
    );
  }
}






// import 'package:flutter/material.dart';
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

//   var phoneError = RxnString();
//   var countryError = RxnString();
//   var phoneBorderColor = Rx<Color>(Colors.grey); // Default border color

//   void validatePhoneNumber(String value) {
//     if (value.length < 6 || value.length > 11) {
//       phoneError.value = "Please enter a contact number with 6-11 digits";
//       phoneBorderColor.value = Colors.red; // Invalid - Red
//     } else {
//       phoneError.value = null;
//       phoneBorderColor.value = Colors.green; // Valid - Green
//     }
//   }

//   void validateCountrySelection() {
//     if (controller.selectedCountryName.value.isEmpty) {
//       countryError.value = "Please select a country";
//     } else {
//       countryError.value = null;
//     }
//   }

//   @override
//   void dispose() {
//     phoneController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;
//     double screenWidth = MediaQuery.of(context).size.width;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         IntrinsicHeight(
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Country Picker (Unchanged)
//               Container(
//                 height: screenHeight * 0.065,
//                 width: MediaQuery.of(context).size.width * 0.35,
//                 padding: EdgeInsets.symmetric(horizontal: 8),
//                 decoration: BoxDecoration(
//                   color: Colors.black.withOpacity(0.07),
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//                 child: Obx(
//                   () => DropdownButtonHideUnderline(
//                     child: DropdownButton<String>(
//                       isExpanded: true,
//                       alignment: Alignment.bottomLeft,
//                       icon: Icon(Icons.keyboard_arrow_down),
//                       value: controller.selectedCountryName.value,
//                       onChanged: (value) {
//                         if (value != null) {
//                           var selectedCountry =
//                               countries.firstWhere((country) => country.name == value);
//                           controller.updateCountry(
//                             "+${selectedCountry.dialCode}",
//                             selectedCountry.flag,
//                             selectedCountry.name,
//                           );
//                           validateCountrySelection();
//                         }
//                       },
//                       selectedItemBuilder: (BuildContext context) {
//                         return countries.map((country) {
//                           return Row(
//                             children: [
//                               Text(controller.selectedCountryFlag.value, style: TextStyle(fontSize: 18)),
//                               SizedBox(width: 10),
//                               Text(
//                                 controller.selectedCountryCode.value,
//                                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//                               ),
//                             ],
//                           );
//                         }).toList();
//                       },
//                       items: countries.map((country) {
//                         bool isSelected = country.name == controller.selectedCountryName.value;
//                         return DropdownMenuItem<String>(
//                           value: country.name,
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Padding(
//                                 padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                                 child: Row(
//                                   children: [
//                                     if (isSelected) Icon(Icons.check, color: Colors.black, size: 16),
//                                     SizedBox(width: isSelected ? 8 : 0),
//                                     Expanded(
//                                       child: Text(
//                                         country.name,
//                                         style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 height: 0.8, 
//                                 color: Colors.grey.shade300,
//                                 margin: EdgeInsets.symmetric(horizontal: 4),
//                               ),
//                             ],
//                           ),
//                         );
//                       }).toList(),
//                       dropdownColor: Colors.white,
//                       elevation: 3,
//                       menuWidth: screenWidth * 0.75,
//                       menuMaxHeight: screenHeight * 0.95,
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(width: 10),

//               // Phone Number Field with Dynamic Bottom Border
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Obx(
//                       () => Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           CustomField(
//                             hintText: "Mobile Number".tr,
//                             controller: phoneController,
//                             focusNode: phoneFocus,
//                             keyboardType: TextInputType.phone,
//                             maxLength: 11,
//                             onChanged: validatePhoneNumber,
//                           ),
//                           // Bottom Border for Phone Field
//                           Container(
//                             height: 2,
//                             width: double.infinity,
//                             color: phoneBorderColor.value, // Dynamic Border Color
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         // Country Picker Validation Message
//         Obx(
//           () => countryError.value != null
//               ? Padding(
//                   padding: const EdgeInsets.only(top: 4, left: 8),
//                   child: Row(
//                     children: [
//                       Icon(Icons.cancel, color: Colors.red, size: 14),
//                       SizedBox(width: 4),
//                       Text(
//                         countryError.value!,
//                         style: TextStyle(color: Colors.black, fontSize: 12),
//                       ),
//                     ],
//                   ),
//                 )
//               : SizedBox.shrink(),
//         ),
//         // Phone Number Validation Message
//         Obx(
//           () => phoneError.value != null
//               ? Padding(
//                   padding: const EdgeInsets.only(top: 4, left: 8),
//                   child: Row(
//                     children: [
//                       Icon(Icons.cancel, color: Colors.red, size: 14),
//                       SizedBox(width: 4),
//                       Text(
//                         phoneError.value!,
//                         style: TextStyle(color: Colors.black, fontSize: 12),
//                       ),
//                     ],
//                   ),
//                 )
//               : SizedBox.shrink(),
//         ),
//       ],
//     );
//   }
// }




