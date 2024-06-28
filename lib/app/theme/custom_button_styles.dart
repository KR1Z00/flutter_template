import 'package:flutter/material.dart';
import 'package:flutter_template/app/theme/theme_extensions.dart';

extension ButtonStyles on ButtonStyle {
  static ButtonStyle primaryFilled(BuildContext context) {
    return ButtonStyle(
      backgroundColor: WidgetStateProperty.all(
        context.colorScheme().primary,
      ),
      foregroundColor: WidgetStateProperty.all(
        context.colorScheme().onPrimary,
      ),
      padding: WidgetStateProperty.all(
        const EdgeInsets.all(0),
      ),
      textStyle: WidgetStateProperty.all(
        context.textTheme().labelMedium,
      ),
      overlayColor: WidgetStateProperty.all(
        context.colorScheme().surfaceContainer.withOpacity(0.25),
      ),
    );
  }

  static ButtonStyle primaryText(BuildContext context) {
    return ButtonStyle(
      backgroundColor: WidgetStateProperty.all(
        Colors.transparent,
      ),
      foregroundColor: WidgetStateProperty.all(
        context.colorScheme().primary,
      ),
      textStyle: WidgetStateProperty.all(
        context.textTheme().labelMedium,
      ),
      padding: WidgetStateProperty.all(
        const EdgeInsets.all(0),
      ),
      overlayColor: WidgetStateProperty.all(
        context.colorScheme().surfaceContainer.withOpacity(0.25),
      ),
    );
  }

  static ButtonStyle secondaryFilled(BuildContext context) {
    return ButtonStyle(
      backgroundColor: WidgetStateProperty.all(
        context.colorScheme().secondary,
      ),
      foregroundColor: WidgetStateProperty.all(
        context.colorScheme().onSecondary,
      ),
      textStyle: WidgetStateProperty.all(
        context.textTheme().labelMedium,
      ),
      padding: WidgetStateProperty.all(
        const EdgeInsets.all(0),
      ),
      overlayColor: WidgetStateProperty.all(
        context.colorScheme().surfaceContainer.withOpacity(0.25),
      ),
    );
  }

  static ButtonStyle secondaryText(BuildContext context) {
    return ButtonStyle(
      backgroundColor: WidgetStateProperty.all(
        Colors.transparent,
      ),
      foregroundColor: WidgetStateProperty.all(
        context.colorScheme().secondary,
      ),
      textStyle: WidgetStateProperty.all(
        context.textTheme().labelMedium,
      ),
      padding: WidgetStateProperty.all(
        const EdgeInsets.all(0),
      ),
      overlayColor: WidgetStateProperty.all(
        context.colorScheme().surfaceContainer.withOpacity(0.25),
      ),
    );
  }

  static ButtonStyle primaryIcon(BuildContext context) {
    return ButtonStyle(
      backgroundColor: WidgetStateProperty.all(
        Colors.transparent,
      ),
      foregroundColor: WidgetStateProperty.all(
        Colors.white,
      ),
      padding: WidgetStateProperty.all(
        const EdgeInsets.all(0),
      ),
      overlayColor: WidgetStateProperty.all(
        context.colorScheme().primary.withOpacity(0.5),
      ),
    );
  }

  static ButtonStyle secondaryIcon(BuildContext context) {
    return ButtonStyle(
      backgroundColor: WidgetStateProperty.all(
        Colors.transparent,
      ),
      foregroundColor: WidgetStateProperty.all(
        Colors.white,
      ),
      padding: WidgetStateProperty.all(
        const EdgeInsets.all(0),
      ),
      overlayColor: WidgetStateProperty.all(
        context.colorScheme().secondary.withOpacity(0.5),
      ),
    );
  }
}
