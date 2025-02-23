


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:stake_fair_app/controllers/utils/app_colors.dart';
import 'package:stake_fair_app/view/screens/authentication/login_screen.dart';


import '../../../controllers/getx_controller/auth_controller.dart';
import '../../../controllers/getx_controller/password_controller.dart';
import '../../widgets/country_code_picker.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_field_widget.dart';
import '../../widgets/icon_selection_widget.dart';
import '../../widgets/language_dropdown.dart';
import '../../widgets/social_mediaicons.dart';
import 'forgot_password_screen.dart';



class GenderController extends GetxController {
  var selectedIndex = (-1).obs; // Initially, no option is selected

  void selectIndex(int index) {
    selectedIndex.value = index;
  }
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _LoginScreenState();
}

//GlobalKey<FormState> formKey = GlobalKey();
PasswordController passwordController = Get.put(PasswordController());
  final GenderController genderController = Get.put(GenderController());
   final AuthController controller = Get.put(AuthController());



class _LoginScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
    Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios)),
       // title: Text('StakeFair'),
       actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
                GestureDetector(
                  onTap: (){
                    Get.to(()=>LoginScreen());
                  },
                  child: Text('Login',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)),
                  SizedBox(width: mediaQuerySize.width*0.03,),
       LanguageDropdown(),
              
              

            ],
          ),
        )
       ],
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Form(
         // key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
            child: Column(
              children: [
                 SizedBox(
                  height: mediaQuerySize.height * 0.01.h,
                ),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                    Text('Account Details',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    Text('Step 1 of 2')
                                   ],
                                  ),
                 ),
              //   Container(width: mediaQuerySize.width,
              //   height: mediaQuerySize.height*0.08,
              //   decoration: BoxDecoration(
              //     color: Colors.black.withOpacity(0.07),
              //     borderRadius: BorderRadius.circular(10)
              //   ),
              //  child:
              //   ),
               
                SizedBox(
                  height: mediaQuerySize.height * 0.05.h,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Gender',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),)),
                ),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Row(
                      
                       children: [
                         GestureDetector(
                               onTap: () {
                               genderController.selectIndex(0); // Toggle state on tap
                               },
                               child: Obx(
                                 () => Row(
                                   children: [
                                     Icon(
                                       genderController.selectedIndex.value == 0
                                           ? Icons.check_circle 
                                           : Icons.circle_outlined, 
                                       size: 20,
                                       color: genderController.selectedIndex.value == 0 ? Colors.green : Colors.grey, 
                                     ),
                                     SizedBox(width: 5),
                                     Text(
                                       'Male',
                                       style: TextStyle(color: Colors.black, fontSize: 16),
                                     ),
                                     
                                   ],
                                 ),
                               ),
                             ),
                             SizedBox(width: mediaQuerySize.width*0.02.w,),
                              GestureDetector(
                           onTap: () {
                           genderController.selectIndex(1); // Toggle state on tap
                           },
                           child: Obx(
                             () => Row(
                               children: [
                                 Icon(
                                  genderController.selectedIndex.value == 1
                                       ? Icons.check_circle 
                                       : Icons.circle_outlined, 
                                   size: 20,
                                   color: genderController.selectedIndex.value == 1 ? Colors.green : Colors.grey, 
                                 ),
                                 SizedBox(width: 5),
                                 Text(
                                   'Female',
                                   style: TextStyle(color: Colors.black, fontSize: 16),
                                 ),
                                 
                               ],
                             ),
                           ),
                         ),
                           
                       ],
                     ),
                     Container(
                          height: mediaQuerySize.height * 0.05,
                          width: mediaQuerySize.width * 0.21,
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
                        ),
                   ],
                 ),
               ),
                                
           
                 SizedBox(
                  height: mediaQuerySize.height * 0.02.h,
                ),
            CustomField(text: 'Username',),
                SizedBox(
                  height: mediaQuerySize.height * 0.02.h,
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
                SizedBox(height: mediaQuerySize.height * 0.02),

                  Obx(() {
                    if (controller.selectedIcon.value == 1) {
                      return CustomField(text: 'Email or Username');
                    } else if (controller.selectedIcon.value == 2) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: CountryCodePickerWidget(),
                      );
                    }
                    return SizedBox();
                  }),
                SizedBox(
                  height: mediaQuerySize.height * 0.03.h,
                ),
                
               
                CustomButton(
                  name: 'Continue to step 2/2',
                  onTap: () {
                    // if (formKey.currentState!.validate() ?? false) {
                    //  // Get.to(() => BottomNavigationBarScreen());
                    // }
                    print('no');
                  },
                ),
                  SizedBox(
                  height: mediaQuerySize.height * 0.06.h,
                ),
               Container(
                    height: mediaQuerySize.height*0.08.h,
                    width: mediaQuerySize.width*0.9.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 3,
                          spreadRadius: 0,
                          offset: Offset(0, 2)
                        )
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                   child: Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Find out more abiut safe Gambling'),
                        Icon(Icons.arrow_forward)
                      ],
                     ),
                   ),
                  ),
                  SizedBox(height: mediaQuerySize.height*0.02,),
                    Container(
                    height: mediaQuerySize.height*0.08.h,
                    width: mediaQuerySize.width*0.9.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                           color: Colors.grey,
                          blurRadius: 3,
                          spreadRadius: 0,
                          offset: Offset(0, 2)
                        )
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                   child: Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Help & Contact'),
                        Icon(Icons.arrow_forward)
                      ],
                     ),
                   ),
                  ),
                  SizedBox(height: mediaQuerySize.height*0.06.h,)
              ],
            ),
          ),
        )),
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
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.buttonColor),
                ),
              Icon(icon, color: Colors.black),
            ],
          ),
        ));
  }
}


