import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stake_fair_app/res/app_colors/app_colors.dart';
import 'package:stake_fair_app/res/responsive.dart';
import 'package:stake_fair_app/scrollable.dart';
import 'package:stake_fair_app/view/screens/authentication/help_screen.dart';
import 'package:stake_fair_app/view/screens/authentication/like_screen.dart';
import 'package:stake_fair_app/view/widgets/emial_username.dart';
import '../../../controllers/getx_controller/auth_controller.dart';
import '../../widgets/country_code_picker.dart';
import '../../widgets/custom_button.dart';

class UsernameScreen extends StatefulWidget {
  const UsernameScreen({super.key});

  @override
  State<UsernameScreen> createState() => _UsernameScreenState();
}

class _UsernameScreenState extends State<UsernameScreen> {
  final AuthController controller = Get.put(AuthController());
  final emailController = TextEditingController();
  final emailFocus = FocusNode();

  @override
  void dispose() {
    emailController.dispose();
    emailFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;

    final size = MediaQuery.of(context).size;
    return BaseResponsiveScreen(
      child: SafeArea(
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
                    'Please enter your registered email address or phone number so that we can send you a Username reminder.',
                    style: TextStyle(fontSize: 11.sp),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Obx(() {
                    return controller.selectedIcon.value == 1
                        ? EmailUsername(
                            controller: emailController,
                            focusNode: emailFocus,
                            hintText: 'Email or Phone number',
                          )
                        : Padding(
                            padding: EdgeInsets.all(4.r),
                            child: CountryCodePickerWidget(),
                          );
                  }),
                  SizedBox(height: size.height * 0.03),
                  RoundButtonWidget(
                      onPress: () {
                        if (emailController.text.isNotEmpty) {
                          Get.to(() => LikeScreen());
                        } else {
                          Get.snackbar('Error', 'Please enter your email');
                        }
                      },
                      title: 'Send reminder',
                      width: mediaQuerySize.width * 1,
                      height: mediaQuerySize.height * 0.05
                      ),
                  SizedBox(height: size.height * 0.02),
                  Center(
                    child: GestureDetector(
                      onTap: () => Get.to(() => HelpScreen()),
                      child: Text('Help',
                          style:
                              TextStyle(color: Colors.blue, fontSize: 13.sp)),
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
          title: Image.asset(
            'assets/images/stakefair.png',
            height: 20.h,
            width: 125.w,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
