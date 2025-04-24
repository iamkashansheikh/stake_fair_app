
import 'package:flutter/material.dart';

class NoBounceScrollWrapper extends StatelessWidget {
  final Widget child;
  const NoBounceScrollWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: _NoBounceScrollBehavior(),
      child: child,
    );
  }
}

class _NoBounceScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const ClampingScrollPhysics();
  }
}
