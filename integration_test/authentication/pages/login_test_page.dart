import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/app/extensions/functional_extensions.dart';
import 'package:flutter_template/app/localization/generated/locale_keys.g.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../integration_test_page.dart';

class LoginTestPage extends IntegrationTestPage {
  ////////////////////////////////
  // MARK: - Locators
  ////////////////////////////////

  // The login heading
  static Finder get loginHeader => find.byElementPredicate((element) {
        final text = element.widget.castOrNull<Text>();
        if (text == null) return false;
        return text.data == LocaleKeys.login.tr() &&
            (text.style?.fontSize ?? 0) >= 24;
      });

  // The email text field
  static Finder get emailTextField => find.byKey(const Key("loginPage_email"));

  // The password text field
  static Finder get passwordTextField =>
      find.byKey(const Key("loginPage_password"));

  // The login button
  static Finder get loginButton => find.byKey(const Key("loginPage_login"));

  // The register button
  static Finder get registerButton =>
      find.byKey(const Key("loginPage_register"));

  // The forgot password button
  static Finder get forgotPasswordButton =>
      find.byKey(const Key("loginPage_forgotPassword"));

  ////////////////////////////////
  // MARK: - Test Methods
  ////////////////////////////////

  // Asserts that the current page is the login page
  @override
  Future<void> assertIsActive(WidgetTester widgetTester) async {
    for (Finder element in [
      loginHeader,
      emailTextField,
      loginButton,
      forgotPasswordButton
    ]) {
      assertElementIsVisible(
        widgetTester,
        element: element,
      );
    }
  }

  // Enters the email and password into the text fields
  Future<void> enterEmailAndPassword(
    WidgetTester widgetTester, {
    required String email,
    required String password,
  }) async {
    await widgetTester.enterText(emailTextField, email);
    await widgetTester.pumpAndSettle();

    await widgetTester.enterText(passwordTextField, password);
    await widgetTester.pumpAndSettle();
  }

// Taps the login button
  Future<void> tapLogin(WidgetTester widgetTester) async {
    await widgetTester.tap(loginButton);
    await widgetTester.pumpAndSettle();
  }

  // Taps the register button
  Future<void> tapRegister(WidgetTester widgetTester) async {
    await widgetTester.tap(registerButton);
    await widgetTester.pumpAndSettle();
  }

  // Taps the forgot password button
  Future<void> tapForgotPassword(WidgetTester widgetTester) async {
    await widgetTester.tap(forgotPasswordButton);
    await widgetTester.pumpAndSettle();
  }
}
