import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/app/extensions/functional_extensions.dart';
import 'package:flutter_template/app/localization/generated/locale_keys.g.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../integration_test_page.dart';

class RegisterPage extends IntegrationTestPage {
  ////////////////////////////////
  // MARK: - Locators
  ////////////////////////////////

  // The login heading
  static Finder get registerHeader => find.byElementPredicate((element) {
        final text = element.widget.castOrNull<Text>();
        return text != null &&
            text.data == LocaleKeys.register.tr() &&
            (text.style?.fontSize ?? 0) >= 24;
      });

  // The name text field
  static Finder get nameTextField => find.byKey(const Key("registerPage_name"));

  // The email text field
  static Finder get emailTextField =>
      find.byKey(const Key("registerPage_email"));

  // The phone number text field
  static Finder get phoneNumberTextField =>
      find.byKey(const Key("registerPage_phoneNumber"));

  // The password text field
  static Finder get passwordTextField =>
      find.byKey(const Key("registerPage_password"));

  // The register button
  static Finder get registerButton =>
      find.byKey(const Key("registerPage_register"));

  // The login button
  static Finder get loginButton => find.byKey(const Key("registerPage_login"));

  ////////////////////////////////
  // MARK: - Test Methods
  ////////////////////////////////

  // Asserts that the current page is the login page
  @override
  Future<void> assertIsActive(WidgetTester widgetTester) async {
    for (Finder element in [
      registerHeader,
      nameTextField,
      emailTextField,
      phoneNumberTextField,
      passwordTextField,
      registerButton,
      loginButton,
    ]) {
      assertElementIsVisible(
        widgetTester,
        element: element,
      );
    }
  }

  // Enters the email into the text field
  Future<void> enterCredentials(
    WidgetTester widgetTester, {
    required String email,
    required String name,
    required String phoneNumber,
    required String password,
  }) async {
    await widgetTester.enterText(emailTextField, email);
    await widgetTester.pumpAndSettle();

    await widgetTester.enterText(nameTextField, name);
    await widgetTester.pumpAndSettle();

    await widgetTester.enterText(phoneNumberTextField, phoneNumber);
    await widgetTester.pumpAndSettle();

    await widgetTester.enterText(passwordTextField, password);
    await widgetTester.pumpAndSettle();
  }

  // Taps the register button
  Future<void> tapRegister(WidgetTester widgetTester) async {
    await widgetTester.tap(registerButton);
    await widgetTester.pumpAndSettle();
  }

  // Taps the login button
  Future<void> tapLogin(WidgetTester widgetTester) async {
    await widgetTester.tap(loginButton);
    await widgetTester.pumpAndSettle();
  }
}
