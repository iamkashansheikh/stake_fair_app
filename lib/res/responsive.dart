/// Make sure to add this to your pubspec.yaml:
///
/// dependencies:
///   flutter_screenutil: ^5.9.3

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A base widget for mobile-only responsive sizing,
/// clamping text scale, and initializing ScreenUtil.
class BaseResponsiveScreen extends StatelessWidget {
  final Widget child;
  const BaseResponsiveScreen({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, childWidget) {
        // Clamp OS font scaling between 1.0 and 1.2
        final mq = MediaQuery.of(context);
        final double textScale = mq.textScaleFactor.clamp(1.0, 1.2);

        return MediaQuery(
          data: mq.copyWith(textScaler: TextScaler.linear(textScale)),
          child: childWidget!,
        );
      },
      child: child,
    );
  }
}
