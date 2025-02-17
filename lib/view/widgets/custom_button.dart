import 'package:flutter/material.dart';

import '../../controllers/utils/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String name;
  Color color;
  TextStyle textStyle;
  Function()? onTap;
  final double width;
  final bool isEnabled;

  CustomButton(
      {super.key,
      required this.name,
      this.color = AppColors.buttonColor,
      this.textStyle = const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      this.onTap, this.width=300,this.isEnabled=false});

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;
    return Container(
      height: mediaQuerySize.height * 0.07,
      width: mediaQuerySize.width * 0.9,
      decoration: BoxDecoration(border: Border.all(color: AppColors.buttonColor), color: color, borderRadius: BorderRadius.circular(10)),
      child: TextButton(
          onPressed: onTap,
          child: Text(
            name,
            style: textStyle,
          )),
    );
  }
}