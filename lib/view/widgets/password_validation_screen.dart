
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stake_fair_app/controllers/getx_controller/password_validation_controller.dart';

class PasswordFieldWidget extends StatefulWidget {
  final TextEditingController controller;

  const PasswordFieldWidget({Key? key, required this.controller}) : super(key: key);

  @override
  _PasswordFieldWidgetState createState() => _PasswordFieldWidgetState();
}

class _PasswordFieldWidgetState extends State<PasswordFieldWidget> {
  final PasswordValidationController validationController = Get.put(PasswordValidationController());

  final RxBool isPasswordVisible = false.obs;
  final RxBool isFieldFocused = false.obs;
  final RxBool isTyping = false.obs;
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    focusNode.addListener(() {
      isFieldFocused.value = focusNode.hasFocus;
      if (!focusNode.hasFocus) {
        isTyping.value = false;
      }
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  Widget _buildValidationItem(String text, bool isValid) {
    return Row(
      children: [
        Icon(isValid ? Icons.check_circle : Icons.cancel, color: isValid ? Colors.green : Colors.red),
        SizedBox(width: 10),
        Text(text, style: TextStyle(fontSize: 14, color: Colors.grey)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          bool isPasswordValid = validationController.isPasswordStrong.value;

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 3),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.07),
                borderRadius: BorderRadius.circular(5),
                border: Border(
                  bottom: BorderSide(
                    color: isPasswordValid
                        ? Colors.orange // Orange when valid
                        : (isTyping.value
                            ? Colors.red // Red when typing
                            : (isFieldFocused.value ? Colors.orange : Colors.transparent)), // Orange when focused, grey otherwise
                    width: 1,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  controller: widget.controller,
                  focusNode: focusNode,
                  obscureText: !isPasswordVisible.value,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.grey),
                    labelText: "password".tr,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 2),
                    suffixIcon: IconButton(
                      icon: Icon(isPasswordVisible.value ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        isPasswordVisible.value = !isPasswordVisible.value;
                      },
                    ),
                  ),
                  onChanged: (value) {
                    isTyping.value = value.isNotEmpty;
                    validationController.validatePassword(value);
                  },
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () {
                    FocusScope.of(context).nextFocus();
                  },
                ),
              ),
            ),
          );
        }),
        SizedBox(height: 5),
        Obx(() {
          if (validationController.isPasswordStrong.value) {
            return Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green),
                SizedBox(width: 10),
                Text(
                  "Strong. Well done!",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
                ),
              ],
            );
          } else if (isFieldFocused.value) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildValidationItem("8-20 characters", validationController.hasMinLength.value),
                _buildValidationItem("At least one letter", validationController.hasLetter.value),
                _buildValidationItem("At least one number", validationController.hasNumber.value),
                _buildValidationItem("At least one special character", validationController.hasSpecialChar.value),
              ],
            );
          }
          return SizedBox();
        }),
      ],
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:stake_fair_app/controllers/getx_controller/password_validation_controller.dart';

// class PasswordFieldWidget extends StatefulWidget {
//   final TextEditingController controller;

//   const PasswordFieldWidget({Key? key, required this.controller}) : super(key: key);

//   @override
//   _PasswordFieldWidgetState createState() => _PasswordFieldWidgetState();
// }

// class _PasswordFieldWidgetState extends State<PasswordFieldWidget> {
//   final PasswordValidationController validationController = Get.put(PasswordValidationController());

//   final RxBool isPasswordVisible = false.obs;
//   final RxBool isFieldFocused = false.obs;
//   late FocusNode focusNode;

 
   
//   @override
//   void initState() {
//     super.initState();
//     focusNode = FocusNode();
//     focusNode.addListener(() {
//       isFieldFocused.value = focusNode.hasFocus;
//     });
//   }

//   @override
//   void dispose() {
//     focusNode.dispose();
//     super.dispose();
//   }

//   Widget _buildValidationItem(String text, bool isValid) {
//     return Row(
//       children: [
//         Icon(isValid ? Icons.check_circle : Icons.cancel, color: isValid ? Colors.green : Colors.red),
//         SizedBox(width: 10),
//         Text(text, style: TextStyle(fontSize: 14, color: Colors.grey)),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Obx(() {
//           bool isPasswordValid = validationController.isPasswordStrong.value;

//           return Padding(
//             padding: EdgeInsets.symmetric(horizontal: 3),
//             child: Container(
//               height: 50,
//               decoration: BoxDecoration(
//                 color: Colors.black.withOpacity(0.07),
//                 borderRadius: BorderRadius.circular(5),
//                 border: Border(
//                   bottom: BorderSide(
                    
//                     color: isPasswordValid
//                         ? Colors.orange // Orange when valid
//                         : (isFieldFocused.value ? Colors.red : Colors.transparent), // Red when focused, grey otherwise
//                     width: 1,
//                   ),
//                 ),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                 child: TextField(
//                   controller: widget.controller,
//                   focusNode: focusNode,
//                   obscureText: !isPasswordVisible.value,
//                   decoration: InputDecoration(
//                     labelStyle: TextStyle(color: Colors.grey),
//                     labelText: "password".tr,
//                     border: InputBorder.none,
//                     contentPadding:  const EdgeInsets.symmetric(vertical: 2),
//                     suffixIcon: IconButton(
//                       icon: Icon(isPasswordVisible.value ? Icons.visibility : Icons.visibility_off),
//                       onPressed: () {
//                         isPasswordVisible.value = !isPasswordVisible.value;
//                       },
//                     ),
//                   ),
//                   onChanged: (value) {
//                     validationController.validatePassword(value);
//                   },
//                   textInputAction: TextInputAction.next,
//                   onEditingComplete: () {
//                     FocusScope.of(context).nextFocus();
//                   },
//                 ),
//               ),
//             ),
//           );
//         }),
//         SizedBox(height: 5),
//         Obx(() {
//           if (validationController.isPasswordStrong.value) {
//             return Row(
//               children: [
//                 Icon(Icons.check_circle, color: Colors.green),
//                 SizedBox(width: 10),
//                 Text(
//                   "Strong. Well done!",
//                   style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
//                 ),
//               ],
//             );
//           } else if (isFieldFocused.value) {
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildValidationItem("8-20 characters", validationController.hasMinLength.value),
//                 _buildValidationItem("At least one letter", validationController.hasLetter.value),
//                 _buildValidationItem("At least one number", validationController.hasNumber.value),
//                 _buildValidationItem("At least one special character", validationController.hasSpecialChar.value),
//               ],
//             );
//           }
//           return SizedBox();
//         }),
//       ],
//     );
//   }
// }




