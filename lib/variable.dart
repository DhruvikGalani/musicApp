import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool? isDarkMode;
double volume = 0.5;
bool isDrawer = true;
SharedPreferences? pref;
final ThemeData darkTheme = ThemeData(
  hoverColor: Colors.transparent,
  splashColor: Colors.transparent,
  primarySwatch: Colors.blueGrey,
  brightness: Brightness.dark,
  primaryColor: Colors.black,
  hintColor: Colors.grey[600],
  backgroundColor: Colors.black,
  scaffoldBackgroundColor: Colors.black,
  cardColor: Colors.grey[850],
  dividerColor: Colors.grey[700],
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.grey[600],
    disabledColor: Colors.grey[800],
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18.0),
    ),
    textTheme: ButtonTextTheme.primary,
  ),
  appBarTheme: AppBarTheme(
    color: Colors.black,
    iconTheme: IconThemeData(color: Colors.white70),
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarColor: Colors.transparent),
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(color: Colors.white70),
    bodyText2: TextStyle(color: Colors.white60),
    headline1: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    headline2: TextStyle(color: Colors.white70),
    headline3: TextStyle(color: Colors.white60),
    button: TextStyle(color: Colors.black),
  ),
  iconTheme: IconThemeData(color: Colors.grey[600], size: 22),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.grey[600],
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.black,
    selectedItemColor: Colors.grey[600],
    unselectedItemColor: Colors.white60,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey[800],
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade600),
      borderRadius: BorderRadius.circular(10.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
      borderRadius: BorderRadius.circular(10.0),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    labelStyle: TextStyle(color: Colors.white60),
    hintStyle: TextStyle(color: Colors.white54),
  ),
);

final ThemeData lightTheme = ThemeData(
  hoverColor: Colors.transparent,
  splashColor: Colors.transparent,
  primarySwatch: Colors.blueGrey,
  brightness: Brightness.light,
  primaryColor: Colors.white,
  hintColor: Colors.grey[400],
  backgroundColor: Colors.white,
  scaffoldBackgroundColor: Colors.white,
  cardColor: Colors.white,
  dividerColor: Colors.grey[300],
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.blueGrey[300],
    disabledColor: Colors.grey,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    textTheme: ButtonTextTheme.primary,
  ),
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.transparent),
    color: Colors.white,
    iconTheme: IconThemeData(color: Colors.black),
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(color: Colors.black87),
    bodyText2: TextStyle(color: Colors.black54),
    headline1: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    headline2: TextStyle(color: Colors.black87),
    headline3: TextStyle(color: Colors.black54),
    button: TextStyle(color: Colors.white),
  ),
  iconTheme: IconThemeData(color: Colors.grey[600], size: 22),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.grey[400],
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: Colors.blueGrey[300],
    unselectedItemColor: Colors.grey[600],
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey[100],
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blueGrey.shade300),
      borderRadius: BorderRadius.circular(15.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade300),
      borderRadius: BorderRadius.circular(15.0),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    labelStyle: TextStyle(color: Colors.black54),
    hintStyle: TextStyle(color: Colors.black38),
  ),
);
