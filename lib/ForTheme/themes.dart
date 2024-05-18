import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  hintColor: Colors.white,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color.fromRGBO(27, 49, 58, 1.000),
    foregroundColor: Colors.white,
  ),
  scaffoldBackgroundColor: const Color.fromRGBO(19, 35, 42, 1.000),
  appBarTheme: const AppBarTheme(
    foregroundColor: Colors.white,
    backgroundColor: Color.fromRGBO(27, 49, 58, 1.000),
  ),
  backgroundColor: const Color.fromRGBO(15, 28, 33, 1.000),
  bottomAppBarColor: Colors.white,
  shadowColor: Color.fromARGB(255, 198, 226, 222),
  cardColor: Colors.black,
);

//For Light theme
final lightTheme = ThemeData(
  //brightness: Brightness.light,
  hintColor: Colors.black,
  backgroundColor: const Color.fromRGBO(106, 186, 177, 1.000),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: const Color.fromRGBO(106, 186, 177, 1.000),
  ),
  primaryTextTheme: const TextTheme(
    bodyText1: TextStyle(
      color: Color.fromRGBO(212, 235, 233, 1.000),
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color.fromRGBO(106, 186, 177, 1.000),
    foregroundColor: Colors.black,
  ),
  scaffoldBackgroundColor:
      Colors.white54, //const Color.fromRGBO(212, 235, 233, 1.000),
  appBarTheme: const AppBarTheme(
    foregroundColor: Color.fromRGBO(8, 31, 29, 1.000),
    //Color.fromRGBO(17, 63, 57, 1.000),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color.fromRGBO(212, 235, 233, 1.000),
  ),
  bottomAppBarColor: Colors.black,
  shadowColor: Color.fromARGB(255, 109, 204, 193),
  cardColor: Colors.deepPurple,
);
