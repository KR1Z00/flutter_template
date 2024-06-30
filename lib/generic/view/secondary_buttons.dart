import 'package:flutter/material.dart';
import 'package:flutter_template/app/theme/custom_button_styles.dart';
import 'package:flutter_template/app/theme/theme_extensions.dart';

class SecondaryButton extends StatelessWidget {
  final String title;
  final void Function() onPressed;

  final Color? color;
  final Color? splashColor;
  final Color? textColor;
  final double? splashOpacity;

  const SecondaryButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.color,
    this.splashColor,
    this.textColor,
    this.splashOpacity,
  });

  @override
  Widget build(BuildContext context) {
    final color = this.color ?? context.colorScheme().secondary;
    final textColor = this.textColor ?? context.colorScheme().onSecondary;
    final splashColor = this.splashColor ?? context.colorScheme().onSecondary;
    final splashOpacity = this.splashOpacity ?? 0.2;

    return Material(
      borderRadius: BorderRadius.circular(10),
      color: color,
      child: InkWell(
        onTap: onPressed,
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        splashColor: splashColor.withOpacity(splashOpacity),
        highlightColor: splashColor.withOpacity(splashOpacity),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: context.textTheme().labelSmall?.copyWith(color: textColor),
          ),
        ),
      ),
    );
  }
}

class SecondaryTextButton extends StatelessWidget {
  final String title;
  final void Function() onPressed;

  final Color? textColor;

  const SecondaryTextButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyles.secondaryText(context),
      child: Text(title),
    );
  }
}
