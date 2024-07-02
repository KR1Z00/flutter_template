import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_template/app/localization/generated/locale_keys.g.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../integration_test_helpers.dart';
import 'pages/forgot_password_test_page.dart';
import 'pages/login_test_page.dart';
import 'pages/register_test_page.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  final newUserEmail = "${DateTime.now().millisecondsSinceEpoch}@email.com";
  const newUserPassword = "strongPassword123!";

  group(
    "Authentication Regression Tests",
    () {
      setUp(initialiseAppForIntegrationTest);
      tearDown(() async => tearDownAppForIntegrationTest(binding));

      testWidgets(
        "View login screen",
        (WidgetTester tester) async {
          await tester.performSetup();
          await tester.pumpApp();
          final loginPage = LoginTestPage();

          // The user should see the login page
          await loginPage.assertIsActive(tester);
        },
        semanticsEnabled: false,
      );

      testWidgets(
        "View register screen",
        (WidgetTester tester) async {
          await tester.performSetup();
          await tester.pumpApp();
          final loginPage = LoginTestPage();
          final registerPage = RegisterPage();

          // When the user selects the register button
          await loginPage.tapRegister(tester);

          // Then the user should see the register page
          await registerPage.assertIsActive(tester);
        },
      );

      testWidgets(
        "Register new user",
        (WidgetTester tester) async {
          await tester.performSetup();
          await tester.pumpApp();
          final loginPage = LoginTestPage();
          final registerPage = RegisterPage();

          // When the user selects the register button
          await loginPage.tapRegister(tester);

          // Then the user should see the register page
          await registerPage.assertIsActive(tester);

          // When the user enters valid credentials
          await registerPage.enterCredentials(
            tester,
            email: newUserEmail,
            name: "Test Account",
            phoneNumber: "1234567890",
            password: newUserPassword,
          );

          // And the user selects the register button
          await registerPage.tapRegister(tester);

          // Then the page should show a success message
          expect(
            find.text(tr(LocaleKeys.registerSuccess)),
            findsOneWidget,
          );

          // When the user selects the login button to navigate back
          await registerPage.tapLogin(tester);

          // The user should see the login page
          await loginPage.assertIsActive(tester);
        },
      );

      testWidgets(
        "Login with new user",
        (WidgetTester tester) async {
          await tester.pumpApp();
          final loginPage = LoginTestPage();

          // When the user enters valid credentials
          await loginPage.enterEmailAndPassword(
            tester,
            email: newUserEmail,
            password: newUserPassword,
          );

          // When the user selects the login button
          await loginPage.tapLogin(tester);

          // Then it should open the next page, navigating away from the login page
          expect(LoginTestPage.loginHeader, findsNothing);
          expect(LoginTestPage.loginButton, findsNothing);
        },
      );

      testWidgets(
        "View forgot password screen",
        (WidgetTester tester) async {
          await tester.pumpApp();
          final loginPage = LoginTestPage();
          final forgotPasswordPage = ForgotPasswordPage();

          // When the user selects the forgot password button
          await loginPage.tapForgotPassword(tester);

          // Then the user should see the forgot password page
          await forgotPasswordPage.assertIsActive(tester);
        },
      );

      testWidgets(
        "Reset forgotten password",
        (WidgetTester tester) async {
          await tester.pumpApp();
          final loginPage = LoginTestPage();
          final forgotPasswordPage = ForgotPasswordPage();

          // When the user selects the forgot password button
          await loginPage.tapForgotPassword(tester);

          // Then the user should see the forgot password page
          await forgotPasswordPage.assertIsActive(tester);

          // When the user enters an email
          await forgotPasswordPage.enterEmail(
            tester,
            email: newUserEmail,
          );

          // And the user selects the reset password button
          await forgotPasswordPage.tapResetPassword(tester);

          // Then the page should show a success message
          expect(
            find.text(tr(LocaleKeys.forgotPasswordSuccess)),
            findsOneWidget,
          );
        },
      );
    },
  );
}
