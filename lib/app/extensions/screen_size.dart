import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

extension ScreenSize on BuildContext {
  RefinedBreakpoints get refinedBreakpoints =>
      ResponsiveSizingConfig.instance.refinedBreakpoints;

  bool layoutForMobile() {
    final screenSize = MediaQuery.of(this).size;
    return screenSize.width < refinedBreakpoints.tabletNormal;
  }

  bool layoutForLargeMobile() {
    final screenSize = MediaQuery.of(this).size;
    return screenSize.width >= refinedBreakpoints.mobileLarge;
  }
}
