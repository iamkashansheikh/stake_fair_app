import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stake_fair_app/res/responsive.dart';

class UsernameFieldWidget extends StatefulWidget {
  final TextEditingController controller;

  const UsernameFieldWidget({Key? key, required this.controller})
      : super(key: key);

  @override
  State<UsernameFieldWidget> createState() => _UsernameFieldWidgetState();
}

class _UsernameFieldWidgetState extends State<UsernameFieldWidget> {
  FocusNode usernameFocus = FocusNode();
  RxBool showError = false.obs;
  RxBool isValid = false.obs;
  bool isFocused = false;

  @override
  void initState() {
    super.initState();
    usernameFocus.addListener(() {
      setState(() {
        isFocused = usernameFocus.hasFocus || widget.controller.text.isNotEmpty;
      });
    });
  }

  void validateUsername(String value) {
    if (value.isEmpty ||
        value.length < 3 ||
        value.length > 15 ||
        !RegExp(r"^[a-zA-Z0-9_]+$").hasMatch(value)) {
      showError.value = true;
      isValid.value = false;
    } else {
      showError.value = false;
      isValid.value = true;
    }
  }

  @override
  void dispose() {
    usernameFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseResponsiveScreen(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 1.9.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => Container(
                height: 42.h,
                padding: EdgeInsets.symmetric(horizontal: 9.0.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.07),
                  borderRadius: BorderRadius.circular(3.r),
                  border: Border(
                    bottom: BorderSide(
                      color: showError.value
                          ? Color(0xffD65151)
                          : isValid.value
                              ? Color(0xffffb80c)
                              : (isFocused
                                  ? Color(0xffffb80c)
                                  : Colors.transparent),
                      width: 0.5
                    ),
                  ),
                ),
                child: TextField(
                  cursorColor: Colors.black,
                  cursorWidth: 1.w,
                  cursorHeight: 18.h,
                  controller: widget.controller,
                  focusNode: usernameFocus,
                  showCursor: isFocused,
                  textAlignVertical:
                      TextAlignVertical.center, // ✅ Keeps text centered
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    labelText: "username".tr,
                    labelStyle: TextStyle(
                      fontSize: isFocused ? 10.sp : 11.sp,
                      color: Colors.grey,
                    ),
                    counterText: "", // ✅ Hides default character counter
                    border: InputBorder.none,
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    contentPadding: EdgeInsets.symmetric(vertical: 1.h),
                  ),
                  onChanged: validateUsername,
                ),
              ),
            ),
            Obx(
              () => showError.value
                  ? Padding(
                      padding: const EdgeInsets.only(top: 3, left: 2),
                      child: Row(
                        children: [
                          Icon(Icons.cancel_outlined,
                              color: Colors.red, size: 16.sp),
                          SizedBox(width: 5.w),
                          Text(
                            "Please enter a valid username".tr,
                            style:
                                TextStyle(color: Colors.black, fontSize: 10.sp),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
