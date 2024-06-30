import 'package:flutter/material.dart';
import 'package:flutter_template/app/theme/theme_extensions.dart';

class ShadowOutlineView extends StatelessWidget {
  final Widget? child;
  final Color? backgroundColor;
  final double borderRadius;

  const ShadowOutlineView({
    super.key,
    required this.child,
    this.borderRadius = 30,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? context.colorScheme().surface,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme().scrim.withOpacity(0.2),
            offset: const Offset(0, 4),
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: child,
      ),
    );
  }
}
