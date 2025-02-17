
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SocialMediaIconsRow extends StatelessWidget {

  final String imgUrl;
  SocialMediaIconsRow({required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize  = MediaQuery.of(context).size;
    return Container(
      height: mediaQuerySize.height*0.07.h,
      //width: mediaQuerySize.width*0.2.w,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(10),
         color: Colors.black.withOpacity(0.07),
        // image: DecorationImage(image: AssetImage('assets/images/gogle.png'))
      ),
      child: Image.asset(imgUrl,fit: BoxFit.cover,)
    );
  }
}


//  Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           IconButton(
//             icon: FaIcon(FontAwesomeIcons.google, color: Colors.red),
//             onPressed: () {
//               // Handle Google action
//             },
//           ),
//           IconButton(
//             icon: FaIcon(FontAwesomeIcons.facebook, color: Colors.blue),
//             onPressed: () {
//               // Handle Facebook action
//             },
//           ),
//           IconButton(
//             icon: FaIcon(FontAwesomeIcons.apple, color: Colors.black),
//             onPressed: () {
//               // Handle Apple action
//             },
//           ),
//         ],
//       ),
