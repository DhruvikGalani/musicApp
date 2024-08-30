// import 'package:flutter/material.dart';
// import 'package:music_app/variable.dart';
//
// class ThemeProvider extends ChangeNotifier {
//   // initially, LIGHT MODE
//   ThemeData _themeData = lightTheme;
//
//   // get Theme
//   ThemeData get themedata => _themeData;
//
//   // is dark mode
//   bool get isDarkMode => _themeData == darkTheme;
//
//   // set theme
//   set themeData(ThemeData themeData) {
//     _themeData = themeData;
//
//     // update UI
//     notifyListeners();
//   }
//
//   void toggleTheme() {
//     if (_themeData == lightTheme) {
//       themeData = darkTheme;
//     } else
//       themeData = lightTheme;
//   }
// }
import 'package:flutter/material.dart';
import 'package:music_app/variable.dart';

class ThemeProvider extends ChangeNotifier {
  // initially, LIGHT MODE
  ThemeData _themeData = (isDarkMode! == false) ? lightTheme : darkTheme;

  // get Theme
  ThemeData get themedata => _themeData;

  // is dark mode

  // set theme
  set themeData(ThemeData themeData) {
    _themeData = themeData;

    // update UI
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    isDarkMode = pref!.getBool("mode") ?? false;
    isDarkMode = !isDarkMode!;
    await pref!.setBool("mode", isDarkMode!);
    isDarkMode = pref!.getBool("mode") ?? false;
    print(" isdark = $isDarkMode");
    themeData = (isDarkMode == true) ? darkTheme : lightTheme;
  }
}
