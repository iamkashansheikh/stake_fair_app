import 'package:get/get.dart';

class PasswordValidationController extends GetxController {
  RxBool hasMinLength = false.obs;
  RxBool hasLetter = false.obs;
  RxBool hasNumber = false.obs;
  RxBool hasSpecialChar = false.obs; // Add this line

  void validatePassword(String password) {
    hasMinLength.value = password.length >= 8 && password.length <= 20;
    hasLetter.value = RegExp(r'[a-zA-Z]').hasMatch(password);
    hasNumber.value = RegExp(r'\d').hasMatch(password);
    hasSpecialChar.value = RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(password); // Update this

    update(); // Update the controller (Optional, for debugging)
  }
}
