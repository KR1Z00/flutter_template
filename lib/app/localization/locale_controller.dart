import 'package:flutter/widgets.dart';
import 'package:flutter_template/app/localization/app_locales.dart';

class LocaleController {
  Locale getLocale() {
    return AppLocales.fallbackLocale;
  }
}
