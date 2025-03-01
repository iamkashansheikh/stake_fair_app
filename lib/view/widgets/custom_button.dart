import 'package:flutter/material.dart';

import '../../controllers/utils/app_colors.dart';

class RoundButtonWidget extends StatelessWidget {
  const RoundButtonWidget(
      {super.key,
      this.loading = false,
      required this.title,
      this.height = 50,
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
          height: height,
          width: width,
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
                      .copyWith(color: textColor, fontSize: 20),
                ))),
    );
  }
}


class CustomButton extends StatelessWidget {
  final String name;
  Color color;
  Function()? onTap;
  final double width;
  final bool isEnabled;

  CustomButton(
      {super.key,
      required this.name,
      this.color = AppColors.buttonColor,
      this.onTap, this.width = 20,this.isEnabled=false});

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;
    return Container(
      height: mediaQuerySize.height * 0.07,
      width: mediaQuerySize.width * 0.9,
      decoration: BoxDecoration(border: Border.all(color: AppColors.buttonColor), color: color, borderRadius: BorderRadius.circular(5)),
      child: TextButton(
          onPressed: onTap,
          child: Text(
            name,
            
          )),
    );
  }
}