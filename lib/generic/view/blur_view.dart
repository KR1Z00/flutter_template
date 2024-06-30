import 'dart:ui';

import 'package:flutter/material.dart';

class BlurView extends StatelessWidget {
  final Widget? child;
  final BorderRadiusGeometry borderRadius;

  const BlurView({
    super.key,
    this.child,
    this.borderRadius = BorderRadius.zero,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: child,
      ),
    );
  }
}
