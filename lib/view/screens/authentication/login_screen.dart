import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stake_fair_app/res/app_colors/app_colors.dart';
import 'package:stake_fair_app/res/responsive.dart';
import 'package:stake_fair_app/scrollable.dart';
import 'package:stake_fair_app/services/auth_service.dart';
import 'package:stake_fair_app/services/whatsapp_service.dart';
import 'package:stake_fair_app/view/screens/authentication/forgotten_password.dart';
import 'package:stake_fair_app/view/screens/authentication/sign_up_screen.dart';
import 'package:stake_fair_app/view/screens/authentication/username_screen.dart';
import 'package:stake_fair_app/view/widgets/emial_username.dart';
import 'package:stake_fair_app/view/widgets/password_validation_screen.dart'
    show PasswordFieldWidget;
import '../../../controllers/getx_controller/auth_controller.dart';
import '../../../controllers/getx_controller/password_controller.dart';
import '../../widgets/country_code_picker.dart';
import '../../widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController controller = Get.put(AuthController());
  final PasswordController passwordController = Get.put(PasswordController());
  final TextEditingController passwordFieldController = TextEditingController();
  final AuthService authService = AuthService();
  final String whatsappNumber = "923047494839";

  final FocusNode emailFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BaseResponsiveScreen(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: _buildAppBar(),
          body: NoBounceScrollWrapper(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: size.height * 0.02),
                    _buildHeader(size),
                    SizedBox(height: size.height * 0.02),
                    _buildInputFields(),
                    SizedBox(height: 5.h),
                    _buildRememberMe(),
                    SizedBox(height: 5.h),
                    PasswordFieldWidget(
                      controller: passwordFieldController,
                      labelText: 'Password',
                    ),
                    _buildForgotSection(size),
                    SizedBox(height: size.height * 0.03),
                    Center(
                      child: RoundButtonWidget(
                          title: 'Login', width: 300.w, height: 35.h),
                    ),
                    SizedBox(height: size.height * 0.02),
                    _buildSignUpSection(size),
                    SizedBox(height: size.height * 0.03),
                    _buildDividerWithText(),
                    SizedBox(height: size.height * 0.02),
                    _buildSocialIconsRow(),
                    SizedBox(height: size.height * 0.26),
                    Divider(
                      thickness: 0.3,
                    ),
                    _buildBottomLogos(size),
                  ],
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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 125.w,
                    height: 20.h,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/stakefair.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Welcome Back!',
            style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold)),
        Container(
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
        ),
      ],
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

  Widget _buildInputFields() {
    return Obx(() {
      return controller.selectedIcon.value == 1
          ? EmailUsername(focusNode: emailFocus, hintText: 'Email or Username')
          : CountryCodePickerWidget();
    });
  }

  Widget _buildRememberMe() {
    return GestureDetector(
      onTap: passwordController.isChecked.toggle,
      child: Obx(() => Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.w),
            child: Row(
              children: [
                Icon(
                  passwordController.isChecked.value
                      ? Icons.check_box
                      : Icons.check_box_outline_blank,
                  color: passwordController.isChecked.value
                      ? Colors.green
                      : Colors.grey,
                ),
                SizedBox(width: 8.w),
                Text('Remember me', style: TextStyle(fontSize: 11.sp)),
              ],
            ),
          )),
    );
  }

  Widget _buildForgotSection(Size size) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Forgot your', style: TextStyle(fontSize: 12.sp)),
          SizedBox(width: size.width * 0.01),
          GestureDetector(
            onTap: () => Get.to(() => UsernameScreen()),
            child: Text('username',
                style: TextStyle(color: Colors.blue, fontSize: 12.sp)),
          ),
          SizedBox(width: size.width * 0.01),
          Text('or', style: TextStyle(fontSize: 12.sp)),
          SizedBox(width: size.width * 0.01),
          GestureDetector(
            onTap: () => Get.to(() => ForgottenPassword()),
            child: Text('password',
                style: TextStyle(color: Colors.blue, fontSize: 12.sp)),
          ),
          Text('?', style: TextStyle(fontSize: 12.sp)),
        ],
      ),
    );
  }

  Widget _buildSignUpSection(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('New to StakeFair?', style: TextStyle(fontSize: 12.sp)),
        SizedBox(width: size.width * 0.01),
        GestureDetector(
          onTap: () => Get.to(() => SignUpScreen()),
          child: Text('Sign Up',
              style: TextStyle(color: Colors.blue, fontSize: 12.sp)),
        ),
      ],
    );
  }

  Widget _buildDividerWithText() {
    return Row(
      children: [
        Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text('OR',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12.sp)),
        ),
        Expanded(child: Divider()),
      ],
    );
  }

  Widget _buildSocialIconsRow() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 35.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _socialIcon('assets/images/google.png', authService.signInWithGoogle),
          _socialIcon('assets/images/fb.png', authService.signInWithFacebook),
          _socialIcon(
            'assets/images/wa.png',
            () async => await WhatsAppService.openWhatsApp(
              whatsappNumber,
              message: "Hello from Stake Fair App!",
            ),
          ),
          _socialIcon('assets/images/apple.png', () {}),
        ],
      ),
    );
  }

  Widget _socialIcon(String assetPath, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        assetPath,
        width: 40,
        height: 40,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildBottomLogos(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/mga.webp', width: 100, height: 50),
        SizedBox(width: size.width * 0.1),
        Image.asset('assets/images/commission.png', width: 100, height: 50),
      ],
    );
  }
}
