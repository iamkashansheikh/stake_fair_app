import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final bool isPrefixIcon;
  final bool isSuffixIcon;
  final bool obscureText; // <-- Add this property
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? color;
  final String? Function(String?)? validator;
  final String? text;

  const CustomField({
    super.key,
    this.text,
    this.suffixIcon,
    this.isPrefixIcon = false,
    this.isSuffixIcon = false,
    this.obscureText = false, // <-- Default: false (not hidden)
    this.prefixIcon,
    this.color,
    this.validator,
  });
  

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        height: mediaQuerySize.height*0.07,
        child: TextFormField(
          obscureText: obscureText, // <-- Apply password hiding logic
          validator: validator,
          decoration: InputDecoration(
            fillColor: color ?? Colors.black.withOpacity(0.07),
            filled: true,
            prefixIcon: isPrefixIcon ? prefixIcon : null,
            suffixIcon: isSuffixIcon ? suffixIcon : const SizedBox(),
            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
            hintText: text,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(),
            ),
            hintStyle: const TextStyle(color: Colors.grey),
          ),
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
