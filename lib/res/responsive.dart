import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        final mq = MediaQuery.of(context);
        // Clamp OS text scale between 1.0 and 1.2 for consistent typography
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
