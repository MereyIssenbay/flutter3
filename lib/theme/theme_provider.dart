

import 'package:flutter/material.dart';
import 'package:music_player_app_tute/theme/dark_mode.dart';
import 'package:music_player_app_tute/theme/light_mode.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = light_mode;


  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == dark_mode;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (isDarkMode) {
      themeData = light_mode;
    } else {
      themeData = dark_mode;
    }
    
  }
}