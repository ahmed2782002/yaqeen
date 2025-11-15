import 'package:flutter/material.dart';

import 'package:yaqeen/Islami/Core/Provider/prefs_helper.dart';

class AppProvider extends ChangeNotifier {
  ThemeMode currentTheme = ThemeMode.light;
  String currentLocale = "en";

  void init() async {
    String mode = PrefsHelper.getMode();
    if (mode == "dark") {
      changeTheme(ThemeMode.dark);
    } else {
      changeTheme(ThemeMode.light);
    }
    String? newLang = PrefsHelper.getLanguage();
    changeLocal(newLang ?? "en");
  }

// Obtain shared preferences.

// the function using Manage application theme changes
  void changeTheme(ThemeMode newTheme) {
    if (newTheme == ThemeMode.dark) {
      PrefsHelper.saveTheme("dark");
    } else {
      PrefsHelper.saveTheme("light");
    }
    currentTheme = newTheme;
    notifyListeners();
  }





  // change the mode if is dark then done else light and
  // the action take in settings by use ? "light":"dark"
  bool isDarkEnabled() {
    return currentTheme == ThemeMode.dark;
  }

  // the function using Manage application languages  changes

  void changeLocal(String newLocale) {
    currentLocale = newLocale;
    PrefsHelper.saveLanguage(newLocale);
    notifyListeners();
  }
}
