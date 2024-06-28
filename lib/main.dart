import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/app/dependency_injection.dart';
import 'package:flutter_template/app/localization/app_locales.dart';
import 'package:flutter_template/app/router_config.dart';
import 'package:flutter_template/app/theme/text_theme.dart';
import 'package:flutter_template/app/theme/theme.dart';
import 'package:flutter_template/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
  FirebaseAnalytics.instance.logAppOpen();

  registerDependencies();

  runApp(
    EasyLocalization(
      supportedLocales: AppLocales.availableLocales,
      path: 'assets/translations',
      fallbackLocale: AppLocales.fallbackLocale,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'App Title',
      theme: MaterialTheme(customTextTheme(context)).dark(),
      routerConfig: appRouterConfig,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}
