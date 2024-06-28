import 'package:flutter/material.dart';
import 'package:flutter_template/app/theme/custom_button_styles.dart';
import 'package:flutter_template/app/theme/theme_extensions.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final void Function() onPressed;

  final Color? color;
  final Color? splashColor;
  final Color? textColor;
  final double? splashOpacity;

  const PrimaryButton({
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
    final color = this.color ?? context.colorScheme().primary;
    final textColor = this.textColor ?? context.colorScheme().onPrimary;
    final splashColor = this.splashColor ?? context.colorScheme().onPrimary;
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
            style: context.textTheme().labelMedium?.copyWith(color: textColor),
          ),
        ),
      ),
    );
  }
}

class PrimaryTextButton extends StatelessWidget {
  final String title;
  final void Function() onPressed;

  final Color? textColor;

  const PrimaryTextButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyles.primaryText(context),
      child: Text(title),
    );
  }
}
