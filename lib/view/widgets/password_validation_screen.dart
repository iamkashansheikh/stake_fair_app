import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stake_fair_app/controllers/getx_controller/password_validation_controller.dart';

class PasswordFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final PasswordValidationController validationController = Get.put(PasswordValidationController());

  final RxBool isListVisible = false.obs;
  final RxBool isPasswordVisible = false.obs;
  final FocusNode focusNode = FocusNode(); // Track focus state

  PasswordFieldWidget({required this.controller}) {
    focusNode.addListener(() {
      isListVisible.value = focusNode.hasFocus; // Show underline when focused
    });
  }

  Widget _buildValidationItem(String text, bool isValid) {
    return Row(
      children: [
        Icon(Icons.cancel_outlined,color: Colors.grey,),
        // Icon(isValid ? Icons.check_circle : Icons.cancel,
        //     color: isValid ? Colors.green : Colors.red),
        SizedBox(width: 10),
        Text(text, style: TextStyle(fontSize: 14,color: Colors.grey)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
                height: mediaQuerySize.height * 0.07.h,
                width: mediaQuerySize.width * 0.95.w,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.07),
                  borderRadius: BorderRadius.circular(5),
                  border: Border(
                    bottom: BorderSide(
                      color: focusNode.hasFocus ? Colors.grey : Colors.transparent,
                      width: 2.0, // Underline thickness
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextField(
                    controller: controller,
                    focusNode: focusNode,
                    obscureText: !isPasswordVisible.value,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.grey),
                      labelText: "Password".tr,
          
                      border: InputBorder.none,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange, width: 2.0), // Orange underline on focus
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          isPasswordVisible.value = !isPasswordVisible.value;
                        },
                      ),
                    ),
                    onChanged: (value) {
                      validationController.validatePassword(value);
                    },
                  ),
                ),
              ),
        )),
        SizedBox(height: 5),
        Obx(() => isListVisible.value
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildValidationItem("8-20 characters", validationController.hasMinLength.value),
                  _buildValidationItem("At least one letter", validationController.hasLetter.value),
                  _buildValidationItem("At least one number", validationController.hasNumber.value),
                  _buildValidationItem("At least one special character", validationController.hasSpecialChar.value),
                ],
              )
            : SizedBox()),
      ],
    );
  }
}
