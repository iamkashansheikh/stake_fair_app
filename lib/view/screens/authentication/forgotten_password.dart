import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stake_fair_app/res/app_colors/app_colors.dart';
import 'package:stake_fair_app/scrollable.dart';
import 'package:stake_fair_app/view/screens/authentication/help_screen.dart';
import 'package:stake_fair_app/view/screens/authentication/username_screen.dart';
import 'package:stake_fair_app/view/widgets/date_of_birth.dart';
import 'package:stake_fair_app/view/widgets/emial_username.dart';

import '../../../controllers/getx_controller/auth_controller.dart';
import '../../../controllers/getx_controller/password_controller.dart';
import '../../widgets/custom_button.dart';

class ForgottenPassword extends StatefulWidget {
  const ForgottenPassword({super.key});

  @override
  State<ForgottenPassword> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<ForgottenPassword> {
  final AuthController controller = Get.put(AuthController());
  final PasswordController passwordController = Get.put(PasswordController());
  TextEditingController passwordfieldController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  FocusNode phoneFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  // final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(),
        body: NoBounceScrollWrapper(
          child: SingleChildScrollView(
            child: SafeArea(
              child: Form(
                //  key: formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: mediaQuerySize.height * 0.04),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Forgotten password?',
                                style: TextStyle(
                                    fontSize: 26, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      //  SizedBox(height: mediaQuerySize.height * 0.02),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          textAlign: TextAlign.start,
                          'Please enter your StakeFair username or email or phone number and DOB so you can resest your password.',
                          style: TextStyle(
                              fontSize: 11, fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(height: mediaQuerySize.height * 0.02),
          
                      EmailUsername(
                        focusNode: emailFocus,
                        hintText: 'Email or Phone number or Phone number ',
                      ),
          
                      // Obx(() {
                      //   if (controller.selectedIcon.value == 1) {
          
                      //     return EmailUsername(
                      //       focusNode: emailFocus,
                      //       hintText: 'Email or Phone number or Phone number ',
                      //     );
          
                      //   } else if (controller.selectedIcon.value == 2) {
                      //     return Padding(
                      //       padding: const EdgeInsets.all(4.0),
                      //       child: CountryCodePickerWidget(),
                      //     );
                      //   }
                      //   return SizedBox();
                      // }),
          
                      SizedBox(height: mediaQuerySize.height * 0.02),
          
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => UsernameScreen());
                          },
                          child: Text('Forgot your username?',
                              style: TextStyle(color: Colors.blue, fontSize: 16)),
                        ),
                      ),
          
                      SizedBox(height: mediaQuerySize.height * 0.02),
                      DateOfBirthField(
                        focusNode: FocusNode(),
                        controller: dobController,
                        hintText: "Enter Date of Birth",
                      ),
          
                      //  EmailUsername(
                      //             focusNode: emailFocus,
                      //             hintText: 'Date of birth ',
          
                      //           ),
                      SizedBox(height: mediaQuerySize.height * 0.02),
          
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: RoundButtonWidget(
                          title: 'Send reminder',
                          width: mediaQuerySize.width * 1,
                          height: mediaQuerySize.height * 0.06,
                        ),
                      ),
          
                      SizedBox(height: mediaQuerySize.height * 0.02),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => HelpScreen());
                          },
                          child: Text('Help',
                              style: TextStyle(color: Colors.blue, fontSize: 16)),
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
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.arrow_back_ios)),
            toolbarHeight: 48,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 133,
                        height: 20,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/stakefair.png'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
          ),
        ));
  }

  Widget _buildIcon(IconData icon, int value) {
    return Obx(() => GestureDetector(
          onTap: () => controller.selectedIcon.value = value,
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (controller.selectedIcon.value == value)
                Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: AppColors.buttonColor),
                ),
              Icon(icon, color: Colors.black),
            ],
          ),
        ));
  }

  Widget _buildSocialMediaIcon(String assetPath) {
    return Container(
      height: 40,
      width: 40,
      child: Image.asset(
        assetPath,
        fit: BoxFit.contain, // Ya BoxFit.cover, jo bhi aapko suit kare
      ),
    );
  }
}
