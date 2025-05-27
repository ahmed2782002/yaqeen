import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ApplicationTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: const Color(0xFFB7935F),
    scaffoldBackgroundColor: Colors.transparent,
    colorScheme: ColorScheme.fromSeed(
      primary: const Color(0xFFB7935F),
      seedColor: const Color(0xFFB7935F),
      onSecondary: Colors.black,
      onPrimary: const Color(0xFFB7935F),
      onBackground: const Color(0xFFF8F8F8),
      onPrimaryContainer: Colors.white,
      onSurface: Colors.black,
    ),
    appBarTheme: AppBarTheme(

        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        titleTextStyle: GoogleFonts.elMessiri(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        )),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Color(0xFFB7935F),
      //color icon selected
      selectedIconTheme: IconThemeData(
        color: Colors.black,
        size: 32,
      ),
      // color item under the icon selected
      selectedItemColor: Colors.black,
      // color icon unselected
      unselectedIconTheme: IconThemeData(
        color: Colors.white,
        size: 28,
      ),
      // color item under the icon unselected
      unselectedItemColor: Colors.white,
    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.elMessiri(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      bodyMedium: GoogleFonts.elMessiri(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      bodySmall: GoogleFonts.elMessiri(
        fontSize: 18,
        fontWeight: FontWeight.normal,
        color: Colors.black,
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: const Color(0xFFB7935F).withOpacity(0.7),
    ),
    dividerColor: const Color(0xFFB7935F),
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: const Color(0xFF141A2E),
    colorScheme: ColorScheme.fromSeed(
      primary: const Color(0xFF141A2E),
      seedColor: const Color(0xFF141A2E),
      onSecondary: const Color(0xFF7A6310),
      onPrimary: const Color(0xFFFACC1D),
      onBackground: const Color(0xFF141A2E),
      onPrimaryContainer: Colors.black,
      onSurface: Colors.white,
    ),
    appBarTheme: AppBarTheme(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        titleTextStyle: GoogleFonts.elMessiri(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        )),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Color(0xFF141A2E),
      //color icon selected
      selectedIconTheme: IconThemeData(
        color: Color(0xFFFACC1D),
        size: 32,
      ),
      // color item under the icon selected
      selectedItemColor: Color(0xFFFACC1D),
      // color icon unselected
      unselectedIconTheme: IconThemeData(
        color: Colors.white,
        size: 28,
      ),
      // color item under the icon unselected
      unselectedItemColor: Colors.white,
    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.elMessiri(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      bodyMedium: GoogleFonts.elMessiri(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      bodySmall: GoogleFonts.elMessiri(
        fontSize: 18,
        fontWeight: FontWeight.normal,
        color: Colors.white,
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: const Color(0xFF141A2E).withOpacity(0.9),
    ),
    dividerColor: const Color(0xFFFACC1D),
  );
}
