import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
  _DateOfBirthFieldState createState() => _DateOfBirthFieldState();
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
    if (widget.focusNode.hasFocus) {
      borderColor.value = Color(0xffffb80c); // Orange when focused
    } else if (isTextEntered.value) {
      borderColor.value = Colors.green; // Green if valid
    } else {
      borderColor.value = Colors.transparent; // Default
    }
  }

  void _pickDate() async {
    FocusScope.of(context).unfocus(); // Close keyboard
    final DateTime? pickedDate = await showDatePicker(
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: _pickDate,
            child: AbsorbPointer(
              child: Container(
                decoration: BoxDecoration(
                  color: widget.color ?? Colors.black.withOpacity(0.07),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2),
                  child: TextField(
                    controller: widget.controller,
                    focusNode: widget.focusNode,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      labelText: widget.hintText ?? 'Date of Birth',
                      labelStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      hintStyle: const TextStyle(color: Colors.grey),
                      counterText: "",
                      contentPadding: const EdgeInsets.symmetric(vertical: 2),
                      border: InputBorder.none,
                      suffixIcon: const Icon(Icons.calendar_today, size: 20, color: Colors.grey),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Obx(
              () => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 1,
                width: double.infinity,
                color: borderColor.value,
              ),
            ),
          ),
          Obx(() => errorText.value.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(top: 4, left: 5),
                  child: Text(
                    errorText.value,
                    style: const TextStyle(color: Colors.red, fontSize: 11),
                  ),
                )
              : SizedBox.shrink()),
        ],
      ),
    );
  }
}
