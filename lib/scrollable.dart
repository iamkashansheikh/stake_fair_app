
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

/// Custom ScrollBehavior that clamps at edges and removes the glow/bounce.
class _NoBounceScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    // Simply return the child; no glow, no bounce.
    return child;
  }

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    // ClampingScrollPhysics prevents any stretch or bounce.
    return const ClampingScrollPhysics();
  }
}
