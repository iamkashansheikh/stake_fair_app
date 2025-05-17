import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stake_fair_app/res/app_colors/app_colors.dart';
import 'package:stake_fair_app/res/responsive.dart';
import 'package:stake_fair_app/scrollable.dart';
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
    Size size = MediaQuery.of(context).size;

    return BaseResponsiveScreen(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: _buildAppBar(),
          body: NoBounceScrollWrapper(
            child: SingleChildScrollView(
              child: SafeArea(
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        child: Column(
                          children: [
                            SizedBox(height: mediaQuerySize.height * 0.08),
                            _buildGenderSelection(size),
                            SizedBox(height: mediaQuerySize.height * 0.03),
                            UsernameFieldWidget(controller: usernameController),
                            SizedBox(height: mediaQuerySize.height * 0.02),
                            PasswordFieldWidget(
                              controller: passwordfieldController,
                              labelText: 'password'.tr,
                            ),
                            SizedBox(height: mediaQuerySize.height * 0.018),
                            Obx(() {
                              if (controller.selectedIcon.value == 1) {
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: RoundButtonWidget(
                                  title: 'Continue to step 2/2'.tr,
                                  width: mediaQuerySize.width * 1,
                                  height: mediaQuerySize.height * 0.05),
                            ),
                            SizedBox(height: mediaQuerySize.height * 0.04),
                            _buildInfoCard('safe_gambling'.tr),
                            SizedBox(height: mediaQuerySize.height * 0.02),
                            GestureDetector(
                              child: _buildInfoCard('help_contact'.tr),
                              onTap: () {},
                            ),
                            SizedBox(height: mediaQuerySize.height * 0.06),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(40.h),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.baryelowColor, AppColors.barorngColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: AppBar(
          leading: IconButton(
            icon: Icon(Icons.keyboard_arrow_left),
            onPressed: () => Get.back(),
          ),
          toolbarHeight: 40.h,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            Padding(
              padding: EdgeInsets.all(8.0.r),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () => Get.to(() => const LoginScreen()),
                    child: Text(
                      'login'.tr,
                      style: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Flexible(
                    child: LanguageDropdown(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 35.h,
      width: 45.sw,
      decoration: BoxDecoration(
        color: const Color(0xffF0F0F1),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.5), offset: const Offset(0, 0)),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('account_details'.tr,
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold)),
          Text(
            'step1'.tr,
            style: TextStyle(color: Colors.grey, fontSize: 10.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildGenderSelection(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Text(
            'gender'.tr,
            style: TextStyle(fontSize: 12.sp),
          ),
        ),
        SizedBox(height: 5.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                _genderOption(0, 'male'.tr),
                SizedBox(width: 25.w),
                _genderOption(1, 'female'.tr),
              ],
            ),
            _buildIconSelection(size)
          ],
        ),
      ],
    );
  }

  Widget _genderOption(int index, String text) {
    return GestureDetector(
      onTap: () => genderController.selectIndex(index),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 1.w),
        child: Row(
          children: [
            Obx(() => Icon(
                  genderController.selectedIndex.value == index
                      ? Icons.check_circle
                      : Icons.circle_outlined,
                  size: 22.sp,
                  color: genderController.selectedIndex.value == index
                      ? Colors.green
                      : Colors.grey,
                )),
            SizedBox(width: 5.w),
            Text(
              text,
              style: TextStyle(color: Colors.black, fontSize: 12.sp),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconSelection(Size size) {
    return Container(
      height: size.height * 0.05,
      width: size.width * 0.19,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.07),
        borderRadius: BorderRadius.circular(20.r),
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
    return Obx(() => GestureDetector(
          onTap: () => controller.selectedIcon.value = value,
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (controller.selectedIcon.value == value)
                Container(
                  width: 28.w,
                  height: 28.h,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: AppColors.buttonColor),
                ),
              Icon(icon, color: Colors.black),
            ],
          ),
        ));
  }

  Widget _buildInfoCard(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(3.r),
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
              style: TextStyle(fontSize: 11.sp),
              textAlign: TextAlign.center,
            ),
            Icon(
              Icons.arrow_forward,
              size: 18.sp,
            ),
          ],
        ),
      ),
    );
  }
}
