import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stake_fair_app/res/app_colors/app_colors.dart';

import '../../../controllers/getx_controller/auth_controller.dart';
import '../../../controllers/getx_controller/password_controller.dart';
import '../../widgets/custom_button.dart';

class LikeScreen extends StatefulWidget {
  const LikeScreen({super.key});

  @override
  State<LikeScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LikeScreen> {
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
        body: SingleChildScrollView(
          child: SafeArea(
            child: Form(
              //  key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: mediaQuerySize.height * 0.2),
                    Center(
                      child: Container(height: mediaQuerySize.height*0.1,
                      width: mediaQuerySize.width*0.2,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(40)
                      ),
                      
                      child: Icon(Icons.linked_camera,size: 30,),
                      ),
                    ),
                    SizedBox(height: mediaQuerySize.height*0.02,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Center(
                        child: Text('Thanks!',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w500)),
                      ),
                    ),
                  //  SizedBox(height: mediaQuerySize.height * 0.02),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        textAlign: TextAlign.start,
                        'Please enter your StakeFair username or email or phone number and DOB so you can resest your password.',style: TextStyle(fontSize: 11,fontWeight: FontWeight.w500),),
                    ),
                    SizedBox(height: mediaQuerySize.height * 0.02),

            


                    

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: RoundButtonWidget(
                        title: 'Go to Login',
                        width: mediaQuerySize.width * 1,
                        height: mediaQuerySize.height * 0.06,
                      ),
                    ),

                    SizedBox(height: mediaQuerySize.height * 0.02),
                    Center(
                      child: GestureDetector(
                       onTap: (){
                        
                       },
                        child: Text('Help',
                            style:
                                TextStyle(color: Colors.blue, fontSize: 16)),
                      ),
                    ),

                  

                 

                    SizedBox(
                      height: mediaQuerySize.height * 0.3,
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 100,
                          height: 50,
                          child: Image.asset(
                            'assets/images/mga.webp',
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(width: mediaQuerySize.width * 0.1),
                        Container(
                          width: 100,
                          height: 50,
                          child: Image.asset(
                            'assets/images/commission.png',
                            fit: BoxFit.contain,
                          ),
                        )
                      ],
                    )
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
