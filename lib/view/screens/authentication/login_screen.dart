


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stake_fair_app/controllers/utils/app_colors.dart';


import '../../../controllers/getx_controller/password_controller.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_field_widget.dart';
import '../../widgets/icon_selection_widget.dart';
import '../../widgets/social_mediaicons.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

GlobalKey<FormState> formKey = GlobalKey();
PasswordController passwordController = Get.put(PasswordController());


class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('StakeFair'),
        backgroundColor: AppColors.buttonColor,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 0),
            child: Column(
              children: [
                SizedBox(
                  height: mediaQuerySize.height * 0.08.h,
                ),
               Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Welcome Back!',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  ),
               Align(
                 alignment: Alignment.centerRight,
                 child: IconSelectionWidget()),
                ],
                
               ),

                SizedBox(
                  height: mediaQuerySize.height * 0.02.h,
                ),
               
              GestureDetector(
      onTap: () {
       passwordController.isChecked.toggle(); // Toggle state on tap
      },
      child: Obx(
        () => Row(
          children: [
            Icon(
              passwordController.isChecked.value
                  ? Icons.check_circle 
                  : Icons.circle_outlined, 
              size: 30,
              color: passwordController.isChecked.value ? Colors.green : Colors.grey, // Color changes on tap
            ),
            SizedBox(width: 5),
            Text(
              'Remember me',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ],
        ),
      ),
    ),
                SizedBox(
                  height: mediaQuerySize.height * 0.03.h,
                ),
                CustomField(
                  text: 'Password',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please enter your password';
                    }
                    return null;
                  },
                  isSuffixIcon: true,
                  suffixIcon: Obx(
                    () => IconButton(
                      icon: Icon(
                        passwordController.isPasswordVisible.value ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: passwordController.togglePasswordVisibility,
                    ),
                  ),
                ),
                SizedBox(
                  height: mediaQuerySize.height * 0.03.h,
                ),
                Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   
                    // TextButton(
                    //     onPressed: () {
                    //      // Get.to(() => ForgotPasswordScreen());
                    //     },
                    //     child: Text('Forget', style: TextStyle(color: Colors.grey, fontSize: 13))),
                    Text('Forgot your'),
                    SizedBox(width: mediaQuerySize.width*0.01,),
                        Text('username',style: TextStyle(color: Colors.blue),),
                        SizedBox(width: mediaQuerySize.width*0.01,),
                         Text('or',style: TextStyle(color: Colors.black),),
                         SizedBox(width: mediaQuerySize.width*0.01,),
                          Text('password',style: TextStyle(color: Colors.blue),),
                          Text('?',style: TextStyle(color: Colors.black),),
                  ],
                ),
                SizedBox(
                  height: mediaQuerySize.height * 0.03.h,
                ),
                CustomButton(
                  name: 'Login',
                  onTap: () {
                    if (formKey.currentState!.validate() ?? false) {
                     // Get.to(() => BottomNavigationBarScreen());
                    }
                    print('no');
                  },
                ),
                  SizedBox(
                  height: mediaQuerySize.height * 0.02.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
               Text('New to StakeFair?'),
                    SizedBox(width: mediaQuerySize.width*0.01,),
                        Text('Sign Up',style: TextStyle(color: Colors.blue),),
                ],),
                SizedBox(
                  height: mediaQuerySize.height * 0.03.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'OR',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: mediaQuerySize.height * 0.02.h,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/google3.png',height: 60,width: 60,),
                      // SocialMediaIconsRow(
                      //   imgUrl: 'assets/images/google3.png',
                      // ),
                      SizedBox(
                        width: 5,
                      ),
                      Image.asset('assets/images/fb.png',height: 60,width: 60,),
                      // SocialMediaIconsRow(
                      //   imgUrl: 'assets/images/fb.png',
                      // ),
                      SizedBox(
                        width: 5,
                      ),
                      Image.asset('assets/images/appl_img.png',height: 60,width: 60,),
                      // SocialMediaIconsRow(
                      //   imgUrl: 'assets/images/appl_img.png',
                      // ),
                    ],
                  ),
                ),
               
              ],
            ),
          ),
        )),
      ),
    );
  }
}

