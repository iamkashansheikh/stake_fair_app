import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stake_fair_app/res/responsive.dart';

class DateOfBirthField extends StatefulWidget {
  final FocusNode focusNode;
  final TextEditingController? controller;
  final Color? color;
  final String? hintText;

  const DateOfBirthField({
    Key? key,
    required this.focusNode,
    this.controller,
    this.color,
    this.hintText,
  }) : super(key: key);

  @override
  State<DateOfBirthField> createState() => _DateOfBirthFieldState();
}

class _DateOfBirthFieldState extends State<DateOfBirthField> {
  final Rx<Color> borderColor = Colors.transparent.obs;
  final RxString errorText = ''.obs;
  final RxBool isTextEntered = false.obs;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    borderColor.value = widget.focusNode.hasFocus
        ? const Color(0xffffb80c)
        : isTextEntered.value
            ? Colors.green
            : Colors.transparent;
  }

  Future<void> _pickDate() async {
    FocusScope.of(context).unfocus();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      final age = _calculateAge(pickedDate);
      if (age < 18) {
        errorText.value = "You must be at least 18 years old.";
        borderColor.value = Colors.red;
        isTextEntered.value = false;
      } else {
        errorText.value = '';
        isTextEntered.value = true;
        widget.controller?.text = DateFormat('yyyy-MM-dd').format(pickedDate);
        _handleFocusChange();
      }
    }
  }

  int _calculateAge(DateTime birthDate) {
    final today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return BaseResponsiveScreen(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: _pickDate,
              child: Container(
                height: 42.h,
                padding: EdgeInsets.symmetric(horizontal: 9.0.w, vertical: 1.h),
                decoration: BoxDecoration(
                    color: widget.color ?? Colors.black.withOpacity(0.07),
                    borderRadius: BorderRadius.circular(4.r),
                    border: Border(
                        bottom:
                            BorderSide(color: borderColor.value, width: 0.5))),
                child: AbsorbPointer(
                  child: TextField(
                    controller: widget.controller,
                    focusNode: widget.focusNode,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      labelText: widget.hintText ?? 'Date of Birth',
                      labelStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      border: InputBorder.none,
                      suffixIcon: Icon(Icons.calendar_today,
                          size: 18.sp, color: Colors.grey),
                    ),
                  ),
                ),
              ),
            ),
            if (errorText.value.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 5),
                child: Text(
                  errorText.value,
                  style: TextStyle(color: Colors.red, fontSize: 10.sp),
                ),
              ),
          ],
        ),
      );
    });
  }
}
