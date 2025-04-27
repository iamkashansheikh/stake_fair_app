import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BaseResponsiveScreen extends StatelessWidget {
  final Widget child;

  const BaseResponsiveScreen({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil for responsive UI
    return ScreenUtilInit(
      designSize: const Size(360, 690), // tumhare design ka base size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) => MediaQuery(
        // Lock text scaling to 1.0
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Responsive Layout Builder
            return child;
          },
        ),
      ),
    );
  }
}
