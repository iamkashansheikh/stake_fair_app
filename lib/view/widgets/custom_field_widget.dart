import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomField extends StatelessWidget {
  final bool isPrefixIcon;
  final bool isSuffixIcon;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? color;
  final String? hintText;
  final TextEditingController? controller;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;
  final TextInputType keyboardType;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;

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
    this.nextFocusNode,
    this.keyboardType = TextInputType.text,
    this.maxLength,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50, // Fixed height
            decoration: BoxDecoration(
              color: color ?? Colors.black.withOpacity(0.07),
              borderRadius: BorderRadius.circular(4),
            ),
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                obscureText: obscureText,
                keyboardType: keyboardType,
                maxLength: maxLength, // Limits input length
                inputFormatters: [
                  if (keyboardType == TextInputType.number || keyboardType == TextInputType.phone)
                    FilteringTextInputFormatter.digitsOnly, // Only allows numbers
                  LengthLimitingTextInputFormatter(maxLength), // Stops input beyond limit
                  ...?inputFormatters,
                ],
                maxLines: 1, // Ensures text stays in one line
                textAlignVertical: TextAlignVertical.center,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  prefixIcon: isPrefixIcon ? prefixIcon : null,
                  suffixIcon: isSuffixIcon ? suffixIcon : null,
                  labelText: hintText,
                  labelStyle: const TextStyle(color: Colors.grey),
                  hintStyle: const TextStyle(color: Colors.grey),
                  counterText: "", // Hides character count
                  border: InputBorder.none,
                ),
                onEditingComplete: () {
                  if (nextFocusNode != null) {
                    FocusScope.of(context).requestFocus(nextFocusNode);
                  } else {
                    focusNode.unfocus();
                  }
                },
              ),
            ),
          ),
          AnimatedBuilder(
            animation: focusNode,
            builder: (context, child) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Container(
                  height: 1,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: focusNode.hasFocus ? Colors.orange : Colors.transparent,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter/services.dart';

// class CustomField extends StatelessWidget {
//   final bool isPrefixIcon;
//   final bool isSuffixIcon;
//   final bool obscureText;
//   final Widget? prefixIcon;
//   final Widget? suffixIcon;
//   final Color? color;
//   final String? hintText;
//   final TextEditingController? controller;
//   final FocusNode focusNode; // Accepts external focusNode
//   final FocusNode? nextFocusNode; // FocusNode for next field
//   final TextInputType keyboardType;
//   final int? maxLength;
//   final List<TextInputFormatter>? inputFormatters;

//   CustomField({
//     super.key,
//     this.hintText,
//     this.suffixIcon,
//     this.isPrefixIcon = false,
//     this.isSuffixIcon = false,
//     this.obscureText = false,
//     this.prefixIcon,
//     this.color,
//     this.controller,
//     required this.focusNode, // Require focusNode to manage focus properly
//     this.nextFocusNode, // FocusNode of the next field
//     this.keyboardType = TextInputType.text,
//     this.maxLength,
//     this.inputFormatters,
//   });

//   @override
//   Widget build(BuildContext context) {
//     Size mediaQuerySize = MediaQuery.of(context).size;
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 3),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             height: mediaQuerySize.height * 0.05.h,
//             width: mediaQuerySize.width.w,
//             decoration: BoxDecoration(
//               color: color ?? Colors.black.withOpacity(0.07),
//               borderRadius: BorderRadius.circular(4),
//             ),
//             alignment: Alignment.center,
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 8.0),
//               child: TextField(
//                 controller: controller,
//                 focusNode: focusNode,
//                 obscureText: obscureText,
//                 keyboardType: keyboardType,
//                 maxLength: maxLength,
//                 inputFormatters: inputFormatters,
//                 decoration: InputDecoration(
//                   prefixIcon: isPrefixIcon ? prefixIcon : null,
//                   suffixIcon: isSuffixIcon ? suffixIcon : null,
//                   labelText: hintText,
//                   labelStyle: TextStyle(color: Colors.grey),
//                   hintStyle: const TextStyle(color: Colors.grey),
//                   counterText: "",
//                   border: InputBorder.none,
//                 ),
//                 style: const TextStyle(color: Colors.black),
//                 onEditingComplete: () {
//                   // Move to next field if available
//                   if (nextFocusNode != null) {
//                     FocusScope.of(context).requestFocus(nextFocusNode);
//                   } else {
//                     focusNode.unfocus(); // Close keyboard if no next field
//                   }
//                 },
//               ),
//             ),
//           ),
//           AnimatedBuilder(
//             animation: focusNode,
//             builder: (context, child) {
//               return Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 2),
//                 child: Container(
//                   height: 1,
//                   width: double.infinity,
//                  decoration: BoxDecoration(
//                   color: focusNode.hasFocus ? Colors.orange : Colors.transparent,
                  
//                    ),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
