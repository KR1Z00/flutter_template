import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// An integration testing interface for a page of the app
abstract class IntegrationTestPage {
  /// Asserts that the page is active
  Future<void> assertIsActive(WidgetTester widgetTester);

  /// Asserts that the view is visible
  ///
  /// The view is visible if the finder is found and the view is contained within
  /// the screen
  Future<void> assertElementIsVisible(
    WidgetTester widgetTester, {
    required Finder element,
  }) async {
    expect(element, findsOneWidget);

    final widgetRect = widgetTester.getRect(element);
    final screenRect = Rect.fromLTWH(
      0,
      0,
      widgetTester.view.physicalSize.width,
      widgetTester.view.physicalSize.height,
    );

    expect(widgetRect.overlaps(screenRect), isTrue);
  }
}
