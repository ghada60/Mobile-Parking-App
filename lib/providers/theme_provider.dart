// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

const primaryConol = Colors.purple;

class ThemeProvider with ChangeNotifier {
  ThemeMode? _themeMode;
   ThemeMode? get themeMode => _themeMode;

    ThemeProvider(this._themeMode);

   

  bool get isDarkMode {
    if (_themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return _themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) async{
    _themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isDark", isOn);
    notifyListeners();
  }
  }

Map<int, Color> blackSwatchColorMap = {
  50: Color.fromRGBO(32, 32, 32, .1),
  100: Color.fromRGBO(32, 32, 32, .2),
  200: Color.fromRGBO(32, 32, 32, .3),
  300: Color.fromRGBO(32, 32, 32, .4),
  400: Color.fromRGBO(32, 32, 32, .5),
  500: Color.fromRGBO(32, 32, 32, .6),
  600: Color.fromRGBO(32, 32, 32, .7),
  700: Color.fromRGBO(32, 32, 32, .8),
  800: Color.fromRGBO(32, 32, 32, .9),
  900: Color.fromRGBO(32, 32, 32, 1),
};
MaterialColor blackSwatch = MaterialColor(0xFF170707, blackSwatchColorMap);

Map<int, Color> whiteSwatchColorMap = {
  50: Color.fromRGBO(250, 250, 250, .1),
  100: Color.fromRGBO(250, 250, 250, .2),
  200: Color.fromRGBO(250, 250, 250, .3),
  300: Color.fromRGBO(250, 250, 250, .4),
  400: Color.fromRGBO(250, 250, 250, .5),
  500: Color.fromRGBO(250, 250, 250, .6),
  600: Color.fromRGBO(250, 250, 250, .7),
  700: Color.fromRGBO(250, 250, 250, .8),
  800: Color.fromRGBO(250, 250, 250, .9),
  900: Color.fromRGBO(250, 250, 250, 1),
};
// Green color code: 93cd48 and first two characters (FF) are alpha values (transparency)
MaterialColor whiteSwatch = MaterialColor(0xFFF7F7F7, whiteSwatchColorMap);

class MyThemes {
  static final darkTheme = ThemeData(
    appBarTheme: AppBarTheme(
      color: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    primaryColor: primaryConol,
    textTheme: TextTheme(
      headline1: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      headline2: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      headline3: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      headline4: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      headline5: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      headline6: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      subtitle1: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      subtitle2: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      bodyText1: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      bodyText2: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      caption: TextStyle(
        fontSize: 8,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      button: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      overline: TextStyle(
        fontSize: 10,
      ),
    ),
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: whiteSwatch,
      brightness: Brightness.dark,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: primaryConol,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: primaryConol,
      ),
    ),
    iconTheme: IconThemeData(color: whiteSwatch),
    primaryIconTheme: IconThemeData(color: whiteSwatch),
  );

  ThemeData getDark() => darkTheme;

  static final lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      color: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.black),
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      headline2: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      headline3: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      headline4: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      headline5: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      headline6: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      subtitle1: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      subtitle2: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      bodyText1: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      bodyText2: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      caption: TextStyle(
        fontSize: 8,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      button: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      overline: TextStyle(
        fontSize: 10,
      ),
    ),
    primaryColor: primaryConol,
    brightness: Brightness.light,
    dividerColor: Colors.white54,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: blackSwatch,
      brightness: Brightness.light,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: primaryConol,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: primaryConol,
      ),
    ),
    iconTheme: IconThemeData(color: Colors.black),
  );
  ThemeData getLight() => lightTheme;
}
