import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/app/extensions/functional_extensions.dart';
import 'package:flutter_template/app/localization/generated/locale_keys.g.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../integration_test_page.dart';

class ForgotPasswordPage extends IntegrationTestPage {
  ////////////////////////////////
  // MARK: - Locators
  ////////////////////////////////

  // The login heading
  static Finder get forgotPasswordHeader => find.byElementPredicate((element) {
        final text = element.widget.castOrNull<Text>();
        if (text == null) return false;
        return text.data == LocaleKeys.forgotPassword.tr() &&
            (text.style?.fontSize ?? 0) >= 24;
      });

  // The email text field
  static Finder get emailTextField =>
      find.byKey(const Key("forgotPassword_email"));

  // The reset password button
  static Finder get resetPasswordButton =>
      find.byKey(const Key("forgotPassword_resetPassword"));

  // The done button
  static Finder get doneButton => find.byKey(const Key("forgotPassword_done"));

  ////////////////////////////////
  // MARK: - Test Methods
  ////////////////////////////////

  // Asserts that the current page is the login page
  @override
  Future<void> assertIsActive(WidgetTester widgetTester) async {
    for (Finder element in [
      forgotPasswordHeader,
      emailTextField,
      resetPasswordButton,
      doneButton
    ]) {
      assertElementIsVisible(
        widgetTester,
        element: element,
      );
    }
  }

  // Enters the email into the text field
  Future<void> enterEmail(
    WidgetTester widgetTester, {
    required String email,
  }) async {
    await widgetTester.enterText(emailTextField, email);
    await widgetTester.pumpAndSettle();
  }

  // Taps the reset password button
  Future<void> tapResetPassword(WidgetTester widgetTester) async {
    await widgetTester.tap(resetPasswordButton);
    await widgetTester.pumpAndSettle();
  }

  // Taps the done button
  Future<void> tapDone(WidgetTester widgetTester) async {
    await widgetTester.tap(doneButton);
    await widgetTester.pumpAndSettle();
  }
}
