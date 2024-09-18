// ignore_for_file: public_member_api_docs

import "package:flutter/material.dart";

class ThemeManager {
  factory ThemeManager() {
    return _instance;
  }

  ThemeManager._internal();
  static final ThemeManager _instance = ThemeManager._internal();

  bool _isDarkMode = false;

  ThemeData get themeData {
    return _isDarkMode ? ThemeData.dark() : ThemeData.light();
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
  }
}
