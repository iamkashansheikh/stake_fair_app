import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:stake_fair_app/res/app_colors/app_colors.dart';

class TitleInfoContainer extends StatelessWidget {
  final String title;
  final ImageProvider img;
  final IconData icon;
  final Color backgroundColor;

  const TitleInfoContainer(
      {Key? key,
      required this.title,
      required this.img,
      required this.icon,
      this.backgroundColor = AppColors.blackthemeColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      height: screenWidth * 0.09,
      color: backgroundColor,
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.03,
        vertical: screenWidth * 0.015,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: AutoSizeText(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: screenWidth * 0.035,
                color: Colors.white,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Image(
                image: img,
                width: screenWidth * 0.05,
                height: screenWidth * 0.05,
                fit: BoxFit.contain,
              ),
            ],
          ),
          SizedBox(width: screenWidth * 0.02),
          Icon(
            icon,
            color: Colors.white,
            size: screenWidth * 0.06,
          ),
        ],
      ),
    );
  }
}
