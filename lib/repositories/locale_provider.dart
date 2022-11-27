import 'package:flutter/cupertino.dart';

import '../generated/l10n.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = Locale('pt');

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (!AppLocalizationDelegate().supportedLocales.contains(locale)) {
      _locale = locale;
    }
  }

  void clearLocale() {
    _locale = Locale('pt');
    notifyListeners();
  }
}