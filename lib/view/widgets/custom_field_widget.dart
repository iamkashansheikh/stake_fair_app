
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomField extends StatelessWidget {
  final bool isPrefixIcon;
  final bool isSuffixIcon;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? color;
  final String? hintText;
  final TextEditingController? controller;
  final FocusNode focusNode = FocusNode(); // Manages focus effect

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
  });

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3), // Better spacing
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height:mediaQuerySize.height*0.07.h,     
                  width: mediaQuerySize.width.w,
            decoration: BoxDecoration(
              color: color ?? Colors.black.withOpacity(0.07), // Background color
              borderRadius: BorderRadius.circular(8), // Slightly rounded corners
            ),
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                
                obscureText: obscureText,
                decoration: InputDecoration(
                  prefixIcon: isPrefixIcon ? prefixIcon : null,
                  suffixIcon: isSuffixIcon ? suffixIcon : null,
                 // contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                  labelText: hintText,
                  labelStyle: TextStyle(color: Colors.grey),
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: InputBorder.none, // No visible border
                ),
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ),
          // Orange underline effect when focused
          AnimatedBuilder(
            animation: focusNode,
            builder: (context, child) {
              return Container(
                height: 2,
                width: double.infinity,
                color: focusNode.hasFocus ? Colors.orange : Colors.transparent,
              );
            },
          ),
        ],
      ),
    );
  }
}

