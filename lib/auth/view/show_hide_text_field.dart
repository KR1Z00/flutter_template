import 'package:flutter/material.dart';
import 'package:flutter_template/app/theme/theme_extensions.dart';

class ShowHideTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;

  const ShowHideTextField({
    super.key,
    this.controller,
    this.hintText,
  });

  @override
  State<ShowHideTextField> createState() => _ShowHideTextFieldState();
}

class _ShowHideTextFieldState extends State<ShowHideTextField> {
  bool hidden = true;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints.tightFor(height: 50),
      child: Stack(
        children: [
          Positioned.fill(
            child: TextField(
              controller: widget.controller,
              autocorrect: false,
              obscureText: hidden,
              decoration: InputDecoration(
                hintText: widget.hintText,
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: IconButton(
                  icon: Image.asset(
                    hidden
                        ? "assets/images/eye_closed_icon.png"
                        : "assets/images/eye_open_icon.png",
                    color: context.colorScheme().primary.withOpacity(0.5),
                  ),
                  onPressed: () => setState(() {
                    hidden = !hidden;
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
