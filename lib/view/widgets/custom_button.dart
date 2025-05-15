import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stake_fair_app/res/app_colors/app_colors.dart';


class RoundButtonWidget extends StatelessWidget {
  const RoundButtonWidget(
      {super.key,
      this.loading = false,
      required this.title,
      this.height = 40,
      this.width = 50,
      this.onPress,
      this.textColor = AppColors.greyColor,
      this.buttonColor = AppColors.buttonColor});

  final bool loading;
  final String title;
  final double height, width;
  final VoidCallback? onPress;
  final Color textColor, buttonColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
          height: height.h,
          width: width.w,
          decoration: BoxDecoration(
              color: buttonColor, borderRadius: BorderRadius.circular(5)),
          child: loading
              ? const Center(
                  child: CircularProgressIndicator(
                  color: AppColors.whiteColor,
                ))
              : Center(
                  child: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: textColor, fontSize: 12.sp,),
                ))),
    );
  }
}

