import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EmailUsername extends StatefulWidget {
  final bool isPrefixIcon;
  final bool isSuffixIcon;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? color;
  final String? hintText;
  final TextEditingController? controller;
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String value)? onChanged;

  EmailUsername({
    super.key,
    this.hintText,
    this.suffixIcon,
    this.isPrefixIcon = false,
    this.isSuffixIcon = false,
    this.obscureText = false,
    this.prefixIcon,
    this.color,
    this.controller,
    required this.focusNode,
    this.keyboardType = TextInputType.text,
    this.maxLength,
    this.inputFormatters,
    this.onChanged,
  });

  @override
  _EmailUsernameState createState() => _EmailUsernameState();
}

class _EmailUsernameState extends State<EmailUsername> {
  final Rx<Color> borderColor = Colors.transparent.obs;
  final RxBool isTextEntered = false.obs;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    if (widget.focusNode.hasFocus) {
      borderColor.value = const Color(0xffffb80c); // Orange on focus
    } else if (isTextEntered.value) {
      borderColor.value = Colors.green; // Green when text entered
    } else {
      borderColor.value = Colors.transparent; // Default
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  color: widget.color ?? Colors.black.withOpacity(0.07),
                  borderRadius: BorderRadius.circular(5.r),
                  border: Border(
                    bottom: BorderSide(
                      color: borderColor.value,
                      width: 0.5,
                    ),
                  ),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 9.0.w, vertical: 1.h),
                  child: TextField(
                     cursorColor: Colors.black,
                  cursorWidth: 1.w,
                  cursorHeight: 18.h,
                    controller: widget.controller,
                    focusNode: widget.focusNode,
                    obscureText: widget.obscureText,
                    keyboardType: widget.keyboardType,
                    maxLength: widget.maxLength,
                    inputFormatters: widget.inputFormatters,
                    maxLines: 1,
                    textAlignVertical: TextAlignVertical.center,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      prefixIcon:
                          widget.isPrefixIcon ? widget.prefixIcon : null,
                      suffixIcon:
                          widget.isSuffixIcon ? widget.suffixIcon : null,
                      labelText: widget.hintText,
                      labelStyle:
                          TextStyle(color: Colors.grey, fontSize: 11.sp),
                      hintStyle: const TextStyle(color: Colors.grey),
                      counterText: "",
                      contentPadding: EdgeInsets.symmetric(vertical: 1.h),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      isTextEntered.value = value.isNotEmpty;
                      widget.onChanged?.call(value);
                      _handleFocusChange();
                    },
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
