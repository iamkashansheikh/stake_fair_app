import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stake_fair_app/res/app_colors/app_colors.dart';
import 'package:stake_fair_app/view/widgets/custom_button.dart';
import 'package:stake_fair_app/view/widgets/password_validation_screen.dart';
import 'package:stake_fair_app/view/widgets/username_field_widget.dart';
import '../../../controllers/getx_controller/auth_controller.dart';
import '../../../controllers/getx_controller/password_controller.dart';
import '../../widgets/country_code_picker.dart';
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
  String? validateUsername(String value) {
    if (value.isEmpty) {
      return "Username cannot be empty";
    } else if (value.length < 3 || value.length > 20) {
      return "Username must be 3-20 characters long";
    } else if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
      return "Only letters, numbers, and underscores are allowed";
    }
    return null; // ✅ No error
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a valid email";
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return "Please enter a valid email";
    }
    return null; // ✅ Valid input
  }

  // String? validateEmail(String? value) {
  //   if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value!)) {
  //     return "Enter a valid email".tr;
  //   }
  //   return null; // ✅ Valid input
  // }

  final PasswordController passwordController = Get.put(PasswordController());
  final GenderController genderController = Get.put(GenderController());
  final AuthController controller = Get.put(AuthController());
  TextEditingController passwordfieldController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailCOntroller = TextEditingController();
  FocusNode phoneFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode usernameFocus = FocusNode();

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordfieldController.dispose();
    emailCOntroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Form(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: mediaQuerySize.width * 0.01.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    Column(
                      children: [
                        SizedBox(height: mediaQuerySize.height * 0.04),
                        _buildGenderSelection(),
                        SizedBox(height: mediaQuerySize.height * 0.02),

                        UsernameFieldWidget(controller: usernameController),

                        // CustomField(
                        //   focusNode: passwordFocus,
                        //   controller: usernameController,
                        //   hintText: "username".tr,
                        // ),

                        SizedBox(height: mediaQuerySize.height * 0.02),
                        PasswordFieldWidget(
                          controller: passwordfieldController,
                          lableText: 'password'.tr,
                        ),

                        SizedBox(height: mediaQuerySize.height * 0.02),
                        Obx(() {
                          if (controller.selectedIcon.value == 1) {
                            //               return  CustomField(
                            //   hintText: "Email",
                            //   controller: emailController,
                            //   focusNode: emailFocusNode,
                            //   validator: validateEmail,
                            //   keyboardType: TextInputType.emailAddress,
                            // ),
                            return CustomField(
                              validator: validateEmail,
                              focusNode: emailFocus,
                              controller: emailCOntroller,
                              hintText: "email".tr,
                            );
                          } else if (controller.selectedIcon.value == 2) {
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: CountryCodePickerWidget(),
                            );
                          }
                          return const SizedBox();
                        }),
                        SizedBox(height: mediaQuerySize.height * 0.01),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: RoundButtonWidget(
                              title: 'continue to step 2/2'.tr,
                              width: mediaQuerySize.width * 1,
                              height: mediaQuerySize.height * 0.06),
                        ),

                        SizedBox(height: mediaQuerySize.height * 0.06),

                        _buildInfoCard('safe_gambling'.tr),
                        SizedBox(height: mediaQuerySize.height * 0.02),
                        _buildInfoCard('help_contact'.tr),
                        SizedBox(height: mediaQuerySize.height * 0.06),
                      ],
                    ),

                    // PasswordValidationScreen(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 47,
      width: 415,
      decoration: BoxDecoration(
        color: const Color(0xffF0F0F1),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.5), offset: const Offset(0, 0)),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('account_details'.tr,
              style:
                  const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          Text(
            'step1'.tr,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildGenderSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'gender'.tr,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
        ),
        //SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                _genderOption(0, 'male'.tr),
                SizedBox(width: 30),
                _genderOption(1, 'female'.tr),
              ],
            ),
            _buildIconSelection(),
          ],
        ),
      ],
    );
  }

  Widget _genderOption(int index, String text) {
    return GestureDetector(
      onTap: () => genderController.selectIndex(index),
      child: Row(
        children: [
          Obx(() => Icon(
                genderController.selectedIndex.value == index
                    ? Icons.check_circle
                    : Icons.circle_outlined,
                size: 28,
                color: genderController.selectedIndex.value == index
                    ? Colors.green
                    : Colors.grey,
              )),
          const SizedBox(width: 10),
          Text(
            text,
            style: const TextStyle(color: Colors.black, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildIconSelection() {
    return Container(
      height: 45,
      width: 80,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.07),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildIcon(Icons.mobile_screen_share_rounded, 2),
          _buildIcon(Icons.person, 1),
        ],
      ),
    );
  }

  Widget _buildIcon(IconData icon, int value) {
    return GestureDetector(
      onTap: () => controller.selectedIcon.value = value,
      child: Obx(
        () => Stack(
          alignment: Alignment.center,
          children: [
            if (controller.selectedIcon.value == value)
              AnimatedContainer(
                duration: Duration(milliseconds: 150), // Smooth Transition
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
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 3, // Blur ko thoda increase kiya
              spreadRadius: 0.1, // Spread diya taake charo taraf shadow dikhe
              offset: Offset(0, 0), // Shadow center me hogi
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            Icon(Icons.arrow_forward),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
        preferredSize: const Size.fromHeight(48),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xffFFB300),
                Color(0xffFF8801),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: AppBar(
            toolbarHeight: 48,
            backgroundColor: Colors.transparent,
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
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
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
          ),
        ));
  }
}
