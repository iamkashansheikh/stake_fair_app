import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stake_fair_app/res/responsive.dart';

class CustomField extends StatefulWidget {
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
  final String? Function(String?)? validator;
  final void Function(String value)? onChanged;

  CustomField({
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
    this.validator,
    this.onChanged,
  });

  @override
  _CustomFieldState createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  String? _errorText;
  bool _isFocused = false;
  bool _isValid = false;

  void _validate() {
    final error = widget.validator?.call(widget.controller?.text ?? "");
    setState(() {
      _errorText = error;
      _isValid = error == null && widget.controller?.text.isNotEmpty == true;
    });
  }

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(() {
      setState(() {
        _isFocused = widget.focusNode.hasFocus;
      });
      if (!widget.focusNode.hasFocus) {
        _validate();
      }
    });
  }

  Color get _borderColor {
    if (_errorText != null && _errorText!.isNotEmpty) {
      return const Color(0xffD65151); // red
    } else if (_isValid || _isFocused) {
      return const Color(0xffffb80c); // orange
    } else {
      return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseResponsiveScreen(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 1.9.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 42.h,
              decoration: BoxDecoration(
                color: widget.color ?? Colors.black.withOpacity(0.07),
                borderRadius: BorderRadius.circular(3.r),
                border: Border(
                  bottom: BorderSide(
                    color: _borderColor,
                    width: 0.5,
                  ),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 9.0.w),
              alignment: Alignment.center,
              child: TextField(
                
                 cursorColor: Colors.black,
                  cursorWidth: 1.w,
                  cursorHeight: 18.h,
                controller: widget.controller,
                focusNode: widget.focusNode,
                obscureText: widget.obscureText,
                keyboardType: TextInputType.emailAddress,
                maxLength: widget.maxLength,
                inputFormatters: widget.inputFormatters,
                maxLines: 1,
                textAlignVertical: TextAlignVertical.center,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  
                  prefixIcon: widget.isPrefixIcon ? widget.prefixIcon : null,
                  suffixIcon: widget.isSuffixIcon ? widget.suffixIcon : null,
                  labelText: widget.hintText,
                  labelStyle:  TextStyle(color: Colors.grey,fontSize: 11.sp),
                  hintStyle: const TextStyle(color: Colors.grey),
                  counterText: "",
                   contentPadding:  EdgeInsets.symmetric(vertical: 1.h),
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  _validate();
                  widget.onChanged?.call(value);
                },
              ),
            ),
            if (_errorText != null && _errorText!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                  children: [
                     Icon(Icons.cancel_outlined, color: Colors.red, size: 16.sp),
                     SizedBox(width: 5.w),
                    Expanded(
                      child: Text(
                        _errorText!,
                        style:  TextStyle(fontSize: 10.sp),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
