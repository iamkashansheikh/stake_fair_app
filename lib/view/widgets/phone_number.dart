import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stake_fair_app/res/responsive.dart';

class PhoneNumber extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final int? maxLength;
  final void Function(String)? onChanged;

  PhoneNumber({
    required this.controller,
    required this.focusNode,
    this.keyboardType = TextInputType.phone,
    this.maxLength,
    this.onChanged,
  });

  @override
  _PhoneNumberState createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {
  final RxBool isFocused = false.obs;
  final RxnString phoneError = RxnString();

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(() {
      isFocused.value = widget.focusNode.hasFocus;
      setState(() {}); // **For UI update when focus changes**
    });
  }

  void validatePhoneNumber(String value) {
     if (value.isEmpty) {
      phoneError.value = "";
    } else if (!RegExp(r'^\d{11}$').hasMatch(value)) {
      phoneError.value = "";
    } else {
      phoneError.value = null;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // **✅ Dynamic Border Color Logic**
      Color borderColor;
      if (phoneError.value != null) {
        borderColor = Color(0xffD65151); // **Error (Invalid Input)**
      } else if (isFocused.value) {
        borderColor = Color(0xffffb80c); // **Focus & Success**
      } else {
        borderColor = Colors.transparent; // **No Focus, No Error**
      }

      return BaseResponsiveScreen(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 45.h,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.07),
                borderRadius: BorderRadius.circular(5),
                border: Border(
                  bottom: BorderSide(
                    color: borderColor,
                    width: 0.5 // ✅ Border thickness
                  ),
                ),
              ),
              child: TextField(
                controller: widget.controller,
                focusNode: widget.focusNode,
                keyboardType: widget.keyboardType,
                maxLength: widget.maxLength,
                onChanged: (value) {
                  validatePhoneNumber(value);
                  if (widget.onChanged != null) {
                    widget.onChanged!(value);
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Mobile Number'.tr,
                  labelStyle: TextStyle(color: Colors.grey,fontSize: 11.sp),
                  contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                  border: InputBorder.none,
                  counterText: "",
                ),
              ),
            ),
            // ✅ Show Validation Error Message
            if (phoneError.value != null)
              Padding(
                padding: const EdgeInsets.only(top: 0, left: 4,bottom: 4),
                child: Text(
                  phoneError.value!,
                  style: TextStyle(color: Colors.red, fontSize: 12.sp),
                ),
              ),
          ],
        ),
      );
    });
  }
}
