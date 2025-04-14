import 'package:flutter/material.dart';
import 'package:stake_fair_app/res/app_colors/app_colors.dart';

class CustomActionTile extends StatelessWidget {
  final String title;
  final Widget leading; // Can be an Icon or Image or any widget
  final IconData trailingIcon;
  final VoidCallback onTap;
  final Size mediaQuerySize;

  const CustomActionTile({
    super.key,
    required this.title,
    required this.leading,
    required this.trailingIcon,
    required this.onTap,
    required this.mediaQuerySize,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: mediaQuerySize.height * 0.06,
        width: mediaQuerySize.width * 0.9,
        decoration: BoxDecoration(
          color: AppColors.helpScrenColor,
         // color: Color(0xff2A2A2C),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: mediaQuerySize.height * 0.05,
                width: mediaQuerySize.width * 0.08,
                decoration: BoxDecoration(
                  color: const Color(0xff1c1b1a),
                  borderRadius: BorderRadius.circular(2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.7),
                      //color:  Color(0xff1c1b1a), // Example shadow
                      blurRadius: 3,
                      spreadRadius: 0,
                      offset: const Offset(0, 0),
                    )
                  ],
                ),
                child: Center(child: leading),
              ),
            ),
            SizedBox(width: mediaQuerySize.width * 0.02),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Icon(trailingIcon, color: Colors.grey.withOpacity(0.7),size: 20,),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
