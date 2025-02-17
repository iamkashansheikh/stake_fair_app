import 'package:get/get.dart';

class PasswordController extends GetxController {
  var isPasswordVisible = false.obs;

   var isChecked = false.obs;

  void toggleChecked() {
    isChecked.value = !isChecked.value;
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
}