
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UsernameFieldWidget extends StatefulWidget {
  final TextEditingController controller;

  const UsernameFieldWidget({Key? key, required this.controller}) : super(key: key);

  @override
  State<UsernameFieldWidget> createState() => _UsernameFieldWidgetState();
}

class _UsernameFieldWidgetState extends State<UsernameFieldWidget> {
  FocusNode usernameFocus = FocusNode();
  RxBool showError = false.obs; // Observable to track error visibility
  RxBool isValid = false.obs; // Observable to track valid username
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
    if (value.isEmpty || value.length < 3 || value.length > 15 || !RegExp(r"^[a-zA-Z0-9_]+$").hasMatch(value)) {
      showError.value = true;
      isValid.value = false; // Invalid username
    } else {
      showError.value = false;
      isValid.value = true; // Valid username
    }
  }

  @override
  void dispose() {
    usernameFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: mediaQuerySize.width * 0.01.w),
          child: Obx(
            () => Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.07),
                borderRadius: BorderRadius.circular(6),
                border: Border(
                  bottom: BorderSide(
                    color: showError.value
                        ? Colors.red // Red border when username is invalid
                        : isValid.value
                            ? Colors.orange // Orange border when username is valid
                            : (isFocused ? Colors.orange : Colors.transparent), // Default behavior
                    width: 1,
                  ),
                ),
              ),
              child: TextField(
                controller: widget.controller,
                focusNode: usernameFocus,
                showCursor: isFocused,
                decoration: InputDecoration(
                  labelText: "username".tr,
                  labelStyle: TextStyle(
                    fontSize: isFocused ? 12 : 16,
                    color: isFocused ? Colors.grey : Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                  border: InputBorder.none,
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onChanged: validateUsername,
              ),
            ),
          ),
        ),
        // Show only one validation message
        Obx(
          () => showError.value
              ? Padding(
                  padding: const EdgeInsets.only(top: 4, left: 8),
                  child: Row(
                    children: [
                      const Icon(Icons.cancel, color: Colors.red, size: 14), // ❌ Icon
                      const SizedBox(width: 4),
                      const Text(
                        "Please enter a valid username",
                        style: TextStyle(color: Colors.black, fontSize: 12), // Black text
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// class UsernameFieldWidget extends StatefulWidget {
//   final TextEditingController controller;

//   const UsernameFieldWidget({Key? key, required this.controller}) : super(key: key);

//   @override
//   State<UsernameFieldWidget> createState() => _UsernameFieldWidgetState();
// }

// class _UsernameFieldWidgetState extends State<UsernameFieldWidget> {
//   FocusNode usernameFocus = FocusNode();
//   RxBool showError = false.obs; // Observable to track error visibility
//   bool isFocused = false;

//   @override
//   void initState() {
//     super.initState();
//     usernameFocus.addListener(() {
//       setState(() {
//         isFocused = usernameFocus.hasFocus || widget.controller.text.isNotEmpty;
//       });
//     });
//   }

//   void validateUsername(String value) {
//     if (value.isEmpty) {
//       showError.value = true;
//     } else {
//       showError.value = false;
//     }
//   }

//   @override
//   void dispose() {
//     usernameFocus.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size mediaQuerySize = MediaQuery.of(context).size;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: mediaQuerySize.width * 0.01.w),
//           child: Container(
//             height: 50,
//             padding: const EdgeInsets.symmetric(horizontal: 12),
//             decoration: BoxDecoration(
//               color: Colors.black.withOpacity(0.07),
//               borderRadius: BorderRadius.circular(6),
//               border: Border(
//                 bottom: BorderSide(
//                   color: isFocused ? Colors.orange : Colors.transparent, // Visible only when focused
//                   width: 1.0,
//                 ),
//               ),
//             ),
//             child: TextField(
//               controller: widget.controller,
//               focusNode: usernameFocus,
//               showCursor: isFocused, // Hide cursor when not focused
//               decoration: InputDecoration(
//                 labelText: "Username",
//                 labelStyle: TextStyle(
//                   fontSize: isFocused ? 12 : 16,
//                   color: isFocused ? Colors.grey : Colors.grey,
//                   fontWeight: FontWeight.w500,
//                 ),
//                 border: InputBorder.none, // Remove default border
//                 floatingLabelBehavior: FloatingLabelBehavior.auto,
//                 contentPadding: const EdgeInsets.symmetric(vertical: 12), // Adjust padding
//               ),
//               onChanged: validateUsername,
//             ),
//           ),
//         ),
//         // Show only one validation message
//         Obx(
//           () => showError.value
//               ? Padding(
//                   padding: const EdgeInsets.only(top: 4, left: 8),
//                   child: Row(
//                     children: [
//                       const Icon(Icons.cancel, color: Colors.red, size: 14), // ❌ Icon
//                       const SizedBox(width: 4),
//                       const Text(
//                         "Please enter a valid username",
//                         style: TextStyle(color: Colors.black, fontSize: 12), // Black text
//                       ),
//                     ],
//                   ),
//                 )
//               : const SizedBox.shrink(),
//         ),
//       ],
//     );
//   }
// }
