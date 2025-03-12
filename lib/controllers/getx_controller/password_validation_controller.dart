import 'package:get/get.dart';

class PasswordValidationController extends GetxController {
  RxBool hasMinLength = false.obs;
  RxBool hasLetter = false.obs;
  RxBool hasNumber = false.obs;
  RxBool hasSpecialChar = false.obs;
  RxBool isPasswordStrong = false.obs;

  void validatePassword(String password) {
    hasMinLength.value = password.length >= 8 && password.length <= 20;
    hasLetter.value = password.contains(RegExp(r'[A-Za-z]'));
    hasNumber.value = password.contains(RegExp(r'\d'));
    hasSpecialChar.value = password.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'));

    // Show "Strong. Well done!" only when all criteria are met
    isPasswordStrong.value = hasMinLength.value && hasLetter.value && hasNumber.value && hasSpecialChar.value;
  }
}
