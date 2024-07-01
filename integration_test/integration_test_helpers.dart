import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_template/app/dependency_injection.dart';
import 'package:flutter_template/app/localization/app_locales.dart';
import 'package:flutter_template/firebase_options.dart';
import 'package:flutter_template/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:integration_test/integration_test.dart';

import 'emulator_setup.dart';

extension IntegrationTestHelpers on WidgetTester {
  Future<void> performSetup() async {
    testTextInput.register();
  }

  Future<void> pumpApp() async {
    await pumpWidget(
      EasyLocalization(
        supportedLocales: AppLocales.availableLocales,
        path: 'assets/translations',
        fallbackLocale: AppLocales.fallbackLocale,
        child: const MyApp(),
      ),
      phase: EnginePhase.sendSemanticsUpdate,
    );
    await pumpAndSettle(const Duration(seconds: 1));
  }
}

Future<void> initialiseAppForIntegrationTest() async {
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setupFirebaseEmulators();
  registerDependencies();

  await Future.delayed(const Duration(seconds: 2));
}

Future<void> tearDownAppForIntegrationTest(
  IntegrationTestWidgetsFlutterBinding binding,
) async {
  await GetIt.instance.reset();
  await FirebaseAuth.instance.signOut();
  binding.reset();
  binding.resetEpoch();
}
