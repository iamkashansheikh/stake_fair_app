import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:stake_fair_app/controllers/getx_controller/auth_controller.dart';
import 'package:stake_fair_app/res/responsive.dart';
import 'package:stake_fair_app/view/widgets/phone_number.dart';

class CountryCodePickerWidget extends StatefulWidget {
  CountryCodePickerWidget({Key? key}) : super(key: key);

  @override
  State<CountryCodePickerWidget> createState() =>
      _CountryCodePickerWidgetState();
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
      phoneError.value =
          "Please enter a contact number with at least 6 digits \nand no more than 11 digits.".tr;
    } else if (!RegExp(r'^\d{11}$').hasMatch(value)) {
      phoneError.value =
          "Please enter a contact number with at least 6 digits \nand no more than 11 digits.".tr;
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

    return BaseResponsiveScreen(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Country Picker
                Stack(
                  children: [
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 2.w),
                      child: Container(
                        height: screenHeight * 0.064,
                        width: MediaQuery.of(context).size.width * 0.35,
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.07),
                          borderRadius: BorderRadius.circular(7.r),
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.green,
                              width: 0.5
                            ),
                          ),
                        ),
                        child: Obx(
                          () => BaseResponsiveScreen(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                isExpanded: true,
                                alignment: Alignment.bottomLeft,
                                icon: Icon(Icons.keyboard_arrow_down),
                                value: controller.selectedCountryName.value,
                                onChanged: (value) {
                                  if (value != null) {
                                    var selectedCountry = countries.firstWhere(
                                        (country) => country.name == value);
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
                                        Text(controller.selectedCountryFlag.value,
                                            style: TextStyle(fontSize: 14.sp)),
                                        SizedBox(width: 5.w),
                                        Text(
                                          controller.selectedCountryCode.value,
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              ),
                                        ),
                                      ],
                                    );
                                  }).toList();
                                },
                                items: countries.map((country) {
                                  bool isSelected = country.name ==
                                      controller.selectedCountryName.value;
                                  return DropdownMenuItem<String>(
                                    value: country.name,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w, vertical: 10.h),
                                          child: Row(
                                            children: [
                                              if (isSelected)
                                                Icon(Icons.check,
                                                    color: Colors.black, size: 16.sp),
                                              SizedBox(width: isSelected ? 8 : 0),
                                              Expanded(
                                                child: Text(
                                                  country.name,
                                                  style: TextStyle(
                                                      fontSize: 13.sp,
                                                      fontWeight: FontWeight.w500),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 0.8.h,
                                          color: Colors.grey.shade300,
                                          margin: EdgeInsets.symmetric(horizontal: 4.w),
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
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 10.w),
               // Phone Number Field
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PhoneNumber(
                        controller: phoneController,
                        focusNode: phoneFocusNode,
                        keyboardType: TextInputType.phone,
                        maxLength: 12,
                        onChanged: validatePhoneNumber,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
     //     Phone Number Validation Message
          Obx(
            () => phoneError.value != null
                ? Padding(
                    padding: const EdgeInsets.only(top: 0, left: 8, bottom: 0),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 0, left: 0, bottom: 16),
                          child: Icon(Icons.cancel, color: Colors.red, size: 16.sp),
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          phoneError.value!.tr,
                          style: TextStyle(color: Colors.black, fontSize: 10.sp),
                        ),
                      ],
                    ),
                  )
                : SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}












