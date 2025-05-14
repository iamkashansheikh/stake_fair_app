import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stake_fair_app/controllers/getx_controller/password_validation_controller.dart';
import 'package:stake_fair_app/res/responsive.dart';

class PasswordFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;

  const PasswordFieldWidget({
    Key? key,
    required this.controller,
    required this.labelText,
  }) : super(key: key);

  @override
  State<PasswordFieldWidget> createState() => _PasswordFieldWidgetState();
}

class _PasswordFieldWidgetState extends State<PasswordFieldWidget> {
  final validationController = Get.put(PasswordValidationController());

  final isPasswordVisible = false.obs;
  final isFieldFocused = false.obs;
  final isTyping = false.obs;

  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode()
      ..addListener(() {
        isFieldFocused.value = focusNode.hasFocus;
        if (!focusNode.hasFocus) {
          isTyping.value = false;
        }
      });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  Widget _buildValidationItem(String text, bool isValid) {
    return Row(
      children: [
        Icon(
          isValid ? Icons.check_circle : Icons.cancel,
          color: isValid ? Colors.green : Colors.red,
          size: 16.sp,
        ),
        SizedBox(width: 5.w),
        Text(
          text.tr,
          style: TextStyle(fontSize: 10.sp, color: Colors.grey),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseResponsiveScreen(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 1.9.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              final isPasswordValid =
                  validationController.isPasswordStrong.value;
              return Container(
                height: 42.h,
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.07),
                  borderRadius: BorderRadius.circular(3.r),
                  border: Border(
                    bottom: BorderSide(
                      color: isPasswordValid
                          ? const Color(0xffffb80c)
                          : isTyping.value
                              ? const Color(0xffD65151)
                              : isFieldFocused.value
                                  ? const Color(0xffffb80c)
                                  : Colors.transparent,
                      width: 1,
                    ),
                  ),
                ),
                child: TextField(
                  controller: widget.controller,
                  focusNode: focusNode,
                  obscureText: !isPasswordVisible.value,
                  decoration: InputDecoration(
                    labelText: widget.labelText.tr,
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 11.sp),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 1.h),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        isPasswordVisible.toggle();
                      },
                    ),
                  ),
                  onChanged: (value) {
                    isTyping.value = value.isNotEmpty;
                    validationController.validatePassword(value);
                  },
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () => FocusScope.of(context).nextFocus(),
                ),
              );
            }),
            SizedBox(height: 6.h),
            Obx(() {
              if (validationController.isPasswordStrong.value) {
                return Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green, size: 16.sp),
                    SizedBox(width: 5.w),
                    Text(
                      "Strong. Well done!",
                      style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ],
                );
              } else if (isFieldFocused.value) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildValidationItem("8-20 characters",
                        validationController.hasMinLength.value),
                    _buildValidationItem("At least one letter",
                        validationController.hasLetter.value),
                    _buildValidationItem("At least one number",
                        validationController.hasNumber.value),
                    _buildValidationItem("At least one special character",
                        validationController.hasSpecialChar.value),
                  ],
                );
              }
              return const SizedBox();
            }),
          ],
        ),
      ),
    );
  }
}
