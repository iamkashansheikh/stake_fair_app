import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stake_fair_app/res/responsive.dart';

class CustomContainer extends StatelessWidget {
  final String title;
  final IconData? leftIcon;
  final IconData? rightIcon;
  final double? height;
  final double? width;
  final Color? color;
  final TextStyle? textStyle;

  const CustomContainer({
    super.key,
    required this.title,
    this.leftIcon,
    this.rightIcon,
    this.height,
    this.width,
    this.color,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return BaseResponsiveScreen(
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color ?? Colors.grey[200],
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (leftIcon != null)
                  Icon(
                    leftIcon,
                    size: 18.sp,
                  ),
                if (leftIcon != null) SizedBox(width: 8.w),
                Text(
                  title,
                  style: textStyle ??
                      TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                ),
              ],
            ),

            // Right icon (if provided)
            if (rightIcon != null)
              Icon(
                rightIcon,
                size: 18.sp,
              ),
          ],
        ),
      ),
    );
  }
}
