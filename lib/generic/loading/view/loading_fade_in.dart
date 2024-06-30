import 'package:flutter/material.dart';

import 'loading_in.dart';

/// A widget to animate a child widget fading in.
class LoadingFadeIn extends LoadingIn {
  const LoadingFadeIn({
    super.key,
    required super.shouldAnimate,
    required super.child,
  });

  @override
  LoadingFadeInState createState() => LoadingFadeInState();
}

class LoadingFadeInState extends LoadingInState {
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isVisible ? 1 : 0,
      duration: LoadingIn.animationDuration,
      child: widget.child,
    );
  }
}
