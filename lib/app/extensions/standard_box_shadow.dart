import 'package:flutter/material.dart';
import 'package:flutter_template/app/theme/theme_extensions.dart';

extension StandardBoxShadows on BoxShadow {
  static BoxShadow regular(BuildContext context) => BoxShadow(
        blurRadius: 10,
        color: context.colorScheme().onSurface.withOpacity(0.6),
        blurStyle: BlurStyle.outer,
      );

  static BoxShadow light(BuildContext context) => BoxShadow(
        blurRadius: 5,
        color: context.colorScheme().onSurface.withOpacity(0.5),
        blurStyle: BlurStyle.outer,
      );
}
