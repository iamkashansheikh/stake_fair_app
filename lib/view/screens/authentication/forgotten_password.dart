import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stake_fair_app/res/app_colors/app_colors.dart';
import 'package:stake_fair_app/res/responsive.dart';
import 'package:stake_fair_app/scrollable.dart';
import 'package:stake_fair_app/view/screens/authentication/help_screen.dart';
import 'package:stake_fair_app/view/screens/authentication/username_screen.dart';
import 'package:stake_fair_app/view/widgets/date_of_birth.dart';
import 'package:stake_fair_app/view/widgets/emial_username.dart';
import '../../../controllers/getx_controller/auth_controller.dart';
import '../../../controllers/getx_controller/password_controller.dart';
import '../../widgets/custom_button.dart';

class ForgottenPassword extends StatelessWidget {
  ForgottenPassword({super.key});

  final AuthController controller = Get.put(AuthController());
  final PasswordController passwordController = Get.put(PasswordController());
  final TextEditingController dobController = TextEditingController();
  final FocusNode emailFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: BaseResponsiveScreen(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: _buildAppBar(),
          body: NoBounceScrollWrapper(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height * 0.04),
                  Text('Forgotten username?',
                      style: TextStyle(
                          fontSize: 21.sp, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8.h),
                  Text(
                    'Please enter your StakeFair username or email or phone number and DOB so you can reset your password.',
                    style: TextStyle(fontSize: 11.sp),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Obx(() {
                    return controller.selectedIcon.value == 1
                        ? EmailUsername(
                            focusNode: emailFocus,
                            hintText: 'Email or Phone number',
                          )
                        : Padding(
                            padding: EdgeInsets.all(4.r),
                          );
                  }),
                  SizedBox(height: 10.w),
                  Center(
                    child: GestureDetector(
                      onTap: () => Get.to(() => UsernameScreen()),
                      child: Text(
                        'Forgot your username?',
                        style: TextStyle(color: Colors.blue, fontSize: 13.sp),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  DateOfBirthField(
                    focusNode: FocusNode(),
                    controller: dobController,
                    hintText: "Enter Date of Birth",
                  ),
                  SizedBox(height: 25.h),
                  RoundButtonWidget(
                      title: 'Send reminder', width: 300.w, height: 35.h),
                  const SizedBox(height: 25),
                  Center(
                    child: GestureDetector(
                      onTap: () => Get.to(() => HelpScreen()),
                      child: Text(
                        'Help',
                        style: TextStyle(color: Colors.blue, fontSize: 13.sp),
                      ),
                    ),
                  ),
                ],
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
}
