import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      borderColor.value = Color(0xffffb80c); // Orange when focused
    } else if (isTextEntered.value) {
      borderColor.value = Colors.green; // Green if text was entered
    } else {
      borderColor.value = Colors.transparent; // Default when empty
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: widget.color ?? Colors.black.withOpacity(0.07),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2),
              child: TextField(
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
                  prefixIcon: widget.isPrefixIcon ? widget.prefixIcon : null,
                  suffixIcon: widget.isSuffixIcon ? widget.suffixIcon : null,
                  labelText: widget.hintText,
                  labelStyle: const TextStyle(color: Colors.grey,fontSize: 12,fontWeight: FontWeight.w500),
                  hintStyle: const TextStyle(color: Colors.grey),
                  counterText: "",
                  contentPadding: const EdgeInsets.symmetric(vertical: 2),
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  isTextEntered.value = value.isNotEmpty; // Track if text was entered
                  widget.onChanged?.call(value);
                  _handleFocusChange(); // Call focus change to update border color
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2),
            child: Obx(
              () => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 1,
                width: double.infinity,
                color: borderColor.value,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
