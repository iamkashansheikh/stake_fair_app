import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BackLayInfoBar extends StatelessWidget {
  final String matched;
  final String min;
  final String max;

  const BackLayInfoBar({Key? key, required this.matched, required this.min, required this.max}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffF0F1F5),
      padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 4.h),
      child: Row(
        children: [
          _textBlock('Matched:', matched), SizedBox(width: 30.w),
          _textBlock('Min:', min), SizedBox(width: 7.w),
          _textBlock('Max:', max), SizedBox(width: 40.w),
          Text('Back', style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold)), SizedBox(width: 36.w),
          Text('Lay', style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _textBlock(String label, String value) => Row(
        children: [
          Text(label, style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold)),
          Text(value, style: TextStyle(fontSize: 9.sp)),
        ],
      );
}
