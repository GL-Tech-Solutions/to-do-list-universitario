import 'package:flutter/material.dart';
import 'package:flutter_aula_1/l10n/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  final SharedPreferences sp;
  Locale? _locale;

  LocaleProvider({required this.sp}) {
    _startLocaleProvider();
  }

  void _startLocaleProvider() {
    if (sp.containsKey('languageCode')) {
      String? language = sp.getString('languageCode');
      if (language != null) {
        _locale = Locale(language);
      }
    }
  }

  Locale? get locale => _locale;

  void setLocale(Locale locale) {
    if (!L10n.all.contains(locale)) {
      return;
    }

    _locale = locale;
    sp.setString('languageCode', locale.languageCode);
    notifyListeners();
  }

  void clearLocale() {
    _locale = null;
    sp.clear();
    notifyListeners();
  }
}
