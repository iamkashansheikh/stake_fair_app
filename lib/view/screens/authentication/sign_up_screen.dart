


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stake_fair_app/controllers/utils/app_colors.dart';


import '../../../controllers/getx_controller/password_controller.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_field_widget.dart';
import '../../widgets/icon_selection_widget.dart';




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

GlobalKey<FormState> formKey = GlobalKey();
PasswordController passwordController = Get.put(PasswordController());
  final GenderController genderController = Get.put(GenderController());



class _LoginScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
       // title: Text('StakeFair'),
       actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text('Already a member?',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),
                Text('Login here',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
            ],
          ),
        )
       ],
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
                  height: mediaQuerySize.height * 0.03.h,
                ),
                GestureDetector(
                  onTap: (){
                   _showBottomSheet(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('betfair logo',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                  ),
                ),
                SizedBox(
                  height: mediaQuerySize.height * 0.05.h,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Gender',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),)),
                ),
               Stack(
                children: [
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Row(
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
                              SizedBox(width: 10),
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
                   ),
                 
                   // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Text('Welcome Back!',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  // ),
               Align(
                 alignment: Alignment.centerRight,
                 child: IconSelectionWidget()),
                ],
                
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
                SizedBox(
                  height: mediaQuerySize.height * 0.03.h,
                ),
                
               
                CustomButton(
                  name: 'Continue to step 2/2',
                  onTap: () {
                    if (formKey.currentState!.validate() ?? false) {
                     // Get.to(() => BottomNavigationBarScreen());
                    }
                    print('no');
                  },
                ),
                  SizedBox(
                  height: mediaQuerySize.height * 0.06.h,
                ),
               Row(
                children: [
                  Container(
                    height: mediaQuerySize.height*0.08.h,
                    width: mediaQuerySize.width*0.4.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 3,
                          spreadRadius: 0,
                          offset: Offset(0, 2)
                        )
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                   child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Help & Contact'),
                      Icon(Icons.arrow_forward)
                    ],
                   ),
                  ),
                  SizedBox(width: mediaQuerySize.width*0.09.w,),
                    Container(
                    height: mediaQuerySize.height*0.08.h,
                    width: mediaQuerySize.width*0.4.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 3,
                          spreadRadius: 0,
                          offset: Offset(0, 2)
                        )
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                   child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Find out more'),
                      Icon(Icons.arrow_forward)
                    ],
                   ),
                  )
                ],
               )
              ],
            ),
          ),
        )),
      ),
    );
  }
   void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          height: 250, // Adjust height as needed
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'StackFair Registeration',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Here you can add more details about Betfair Logo or any content you want to display.',
                textAlign: TextAlign.center,
              ),
             
            ],
          ),
        );
      },
    );
  }
}


