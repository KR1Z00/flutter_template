import 'package:flutter/material.dart';

class TertiaryButton extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  final Color? textColor;

  const TertiaryButton({
    super.key,
    this.onPressed,
    this.title = "",
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(0),
          foregroundColor: textColor,
        ),
        child: Text(title),
      ),
    );
  }
}
