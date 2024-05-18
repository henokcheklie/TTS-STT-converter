import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyThemePreferance {
  static const THEME_KEY = 'theme_key';

  setTheme(bool value) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    await _pref.setBool(THEME_KEY, value);
  }

  getTheme() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    return _pref.getBool(THEME_KEY) ?? false;
  }
}

//change notifier
class ModelTheme extends ChangeNotifier {
  late bool _isDark;
  late MyThemePreferance _preferance;
  bool get isDark => _isDark;

  //constractor
  ModelTheme() {
    _isDark = false;
    _preferance = MyThemePreferance();
    getPreference();
  }
  // set theme
  set isDark(bool value) {
    _isDark = value;
    _preferance.setTheme(value);
    notifyListeners();
  }

  getPreference() async {
    _isDark = await _preferance.getTheme();
    notifyListeners();
  }
}
