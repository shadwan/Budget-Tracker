import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService with ChangeNotifier {
  final SharedPreferences sharedPreferences;
  bool _darkTheme = true;

  ThemeService(this.sharedPreferences);

  static const darkThemeKey = 'darkTheme';

  bool get darkTheme {
    return sharedPreferences.getBool(darkThemeKey) ?? _darkTheme;
  }

  set darkTheme(bool value) {
    _darkTheme = value;
    sharedPreferences.setBool(darkThemeKey, value);
    notifyListeners();
  }
}
