
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stake_fair_app/controllers/getx_controller/auth_controller.dart';
import 'package:stake_fair_app/controllers/utils/app_colors.dart';
import 'package:stake_fair_app/view/widgets/country_code_picker.dart';
import 'package:stake_fair_app/view/widgets/custom_field_widget.dart';

class IconSelectionWidget extends StatelessWidget {
  final AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final mediaQuerySize = MediaQuery.of(context).size;

    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            height: mediaQuerySize.height * 0.05,
            width: mediaQuerySize.width * 0.21,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.07),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
               
                Obx(() => GestureDetector(
                      onTap: () {
                        controller.selectedIcon.value = 1;
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          if (controller.selectedIcon.value == 1)
                            Container(
                            width: mediaQuerySize.width*0.12.w,
                            height: mediaQuerySize.height*0.07.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.buttonColor
                              ),
                            ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: mediaQuerySize.width*0.01.w),
                            child: Icon(
                              Icons.person,
                              color: Colors.black,
                              // color: controller.selectedIcon.value == 1
                              //     ? Colors.amber
                              //     : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    )),

               
                Obx(() => GestureDetector(
                      onTap: () {
                        controller.selectedIcon.value = 2;
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          if (controller.selectedIcon.value == 2)
                            Container(
                              width: mediaQuerySize.width*0.12.w,
                            height: mediaQuerySize.height*0.07.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.buttonColor
                              ),
                            ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: mediaQuerySize.width*0.01.w),
                            child: Icon(
                              Icons.mobile_screen_share_rounded,
                              color: Colors.black,
                             
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),

        SizedBox(height: mediaQuerySize.height * 0.03.h),

        // Display the selected field
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
      ],
    );
  }
}
