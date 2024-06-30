import 'package:flutter/material.dart';
import 'package:flutter_template/app/theme/theme_extensions.dart';
import 'package:responsive_builder/responsive_builder.dart';

class TertiaryTextButton extends StatelessWidget {
  final String title;
  final void Function() onPressed;

  const TertiaryTextButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme();

    final textStyle =
        getDeviceType(MediaQuery.of(context).size) == DeviceScreenType.desktop
            ? textTheme.labelLarge
            : textTheme.labelMedium;
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: WidgetStateProperty.all(EdgeInsets.zero),
        foregroundColor: WidgetStateProperty.all(
          context.colorScheme().secondary,
        ),
      ),
      child: Text(
        title,
        style: textStyle?.copyWith(
          color: context.colorScheme().secondary,
        ),
      ),
    );
  }
}
