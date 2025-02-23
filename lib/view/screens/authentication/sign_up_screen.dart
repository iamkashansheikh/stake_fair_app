import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stake_fair_app/controllers/utils/app_colors.dart';
import '../../../controllers/getx_controller/auth_controller.dart';
import '../../../controllers/getx_controller/password_controller.dart';
import '../../widgets/country_code_picker.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_field_widget.dart';
import '../../widgets/language_dropdown.dart';
import '../authentication/login_screen.dart';

class GenderController extends GetxController {
  var selectedIndex = (-1).obs;
  void selectIndex(int index) => selectedIndex.value = index;
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final PasswordController passwordController = Get.put(PasswordController());
  final GenderController genderController = Get.put(GenderController());
  final AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
actions: [
  Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisSize: MainAxisSize.min, 
      children: [
        GestureDetector(
          onTap: () => Get.to(() => const LoginScreen()),
          child: Text(
            'login'.tr,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(width: 8),
        Flexible( 
          child: LanguageDropdown(),
        ),
      ],
    ),
  ),
],
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(  
        child: SafeArea(
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                    SizedBox(height: mediaQuerySize.height * 0.04),
                  _buildGenderSelection(),
                  SizedBox(height: mediaQuerySize.height * 0.02),
                  CustomField(text: 'username'.tr),
                  SizedBox(height: mediaQuerySize.height * 0.02),
                            
                  /// Password Field
                  Obx(() => CustomField(
                        text: 'password'.tr,
                        isSuffixIcon: true,
                        obscureText: !passwordController.isPasswordVisible.value,
                        suffixIcon: IconButton(
                          icon: Icon(
                            passwordController.isPasswordVisible.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: passwordController.togglePasswordVisibility,
                        ),
                        validator: (value) => value!.isEmpty ? 'Please enter your password' : null,
                      )),
                            
                            
                  SizedBox(height: mediaQuerySize.height * 0.02),
                  Obx(() {
                    if (controller.selectedIcon.value == 1) {
                      return CustomField(text: 'email_username'.tr);
                    } else if (controller.selectedIcon.value == 2) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: CountryCodePickerWidget(),
                      );
                    }
                    return const SizedBox();
                  }),
                  SizedBox(height: mediaQuerySize.height * 0.03),
                  CustomButton(
                    name: 'continue'.tr,
                    onTap: () => print('Proceeding to next step'),
                  ),
                  SizedBox(height: mediaQuerySize.height * 0.06),
                  
                  _buildInfoCard('safe_gambling'.tr),
                  SizedBox(height: mediaQuerySize.height * 0.02),
                  _buildInfoCard('help_contact'.tr),
                  SizedBox(height: mediaQuerySize.height * 0.06),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 60,
      width: 415,
      decoration: BoxDecoration(
        color: const Color(0xffF0F0F1),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 5, offset: const Offset(0, 0)),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('account_details'.tr, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          Text('step1'.tr),
        ],
      ),
    );
  }

   Widget _buildGenderSelection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'gender'.tr,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  _genderOption(0, 'male'.tr),
                  SizedBox(width: 15),
                  _genderOption(1, 'female'.tr),
                ],
              ),
              _buildIconSelection(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _genderOption(int index, String text) {
    return GestureDetector(
      onTap: () => genderController.selectIndex(index),
      child: Obx(
        () => Row(
          children: [
            Icon(
              genderController.selectedIndex.value == index
                  ? Icons.check_circle
                  : Icons.circle_outlined,
              size: 28,
              color: genderController.selectedIndex.value == index
                  ? Colors.green
                  : Colors.grey,
            ),
            const SizedBox(width: 5),
            Text(
              text,
              style: const TextStyle(color: Colors.black, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconSelection() {
    return Container(
      height: 50,
      width: 80,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.07),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildIcon(Icons.person, 1),
          _buildIcon(Icons.mobile_screen_share_rounded, 2),
        ],
      ),
    );
  }

  Widget _buildIcon(IconData icon, int value) {
    return Obx(
      () => GestureDetector(
        onTap: () => controller.selectedIcon.value = value,
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (controller.selectedIcon.value == value)
              Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.buttonColor,
                ),
              ),
            Icon(icon, color: Colors.black),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
