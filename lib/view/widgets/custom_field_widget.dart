import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  Color _borderColor = Colors.transparent;

  void _validate() {
    final error = widget.validator?.call(widget.controller?.text ?? "");
    setState(() {
      _errorText = error; // Ensure error message is set
      _borderColor = (error == null) ? Colors.orange : Color(0xffD65151);
    });
  }

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(() {
      if (!widget.focusNode.hasFocus) {
        _validate();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 48,
            decoration: BoxDecoration(
              color: widget.color ?? Colors.black.withOpacity(0.07),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2),
              child: Focus(
                onFocusChange: (hasFocus) {
                  setState(() {
                    _borderColor = hasFocus ? Color(0xffffb80c) : Colors.transparent;
                  });
                },
                child: TextField(
                  controller: widget.controller,
                  focusNode: widget.focusNode,
                  obscureText: widget.obscureText,
                  keyboardType: widget.keyboardType,
                  maxLength: widget.maxLength,
                  inputFormatters: widget.inputFormatters,
                  maxLines: 1,
                  textAlignVertical: TextAlignVertical.center,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: widget.isPrefixIcon ? widget.prefixIcon : null,
                    suffixIcon: widget.isSuffixIcon ? widget.suffixIcon : null,
                    labelText: widget.hintText,
                    labelStyle: const TextStyle(color: Colors.grey),
                    hintStyle: const TextStyle(color: Colors.grey),
                    counterText: "",
                    contentPadding: const EdgeInsets.symmetric(vertical: 2,horizontal: 4),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    _validate();
                    widget.onChanged?.call(value);
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 1,
              width: double.infinity,
              color: _borderColor,
            ),
          ),
          if (_errorText != null && _errorText!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Row(
                children: [
                  Icon(Icons.cancel, color: Colors.red, size: 14), // ❌ Icon before text
                  SizedBox(width: 5),
                  Expanded( // Ensures text does not overflow
                    child: Text(
                      _errorText!,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                      overflow: TextOverflow.ellipsis, // Prevents overflow issues
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}




