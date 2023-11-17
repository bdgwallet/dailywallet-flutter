import 'package:bitcoin_ui/bitcoin_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//import 'package:dailywallet_flutter/themes/bitcoin_ui.dart';

ColorScheme lightThemeColors(context) {
  return ColorScheme(
      brightness: Brightness.dark,
      primary: Bitcoin.orange,
      onPrimary: Bitcoin.white,
      secondary: Bitcoin.neutral2,
      onSecondary: Bitcoin.neutral5,
      error: Bitcoin.red,
      onError: Bitcoin.red,
      background: Bitcoin.white,
      onBackground: Bitcoin.black,
      surface: Bitcoin.white,
      onSurface: Bitcoin.black,
      onSurfaceVariant: Bitcoin.neutral5, // Unselected NavigationBarItem
      onSecondaryContainer: Bitcoin.black); // Selected NavigationBarItem Icon
}

TextTheme lightThemeText(context) {
  final textColor = Theme.of(context).colorScheme.onBackground;
  return TextTheme(
    /* displayLarge: ,
    displayMedium: ,
    displaySmall: ,
    headlineLarge: , */
    headlineMedium: BitcoinTextStyle.title1(textColor),
    headlineSmall: BitcoinTextStyle.title2(textColor),
    titleLarge: BitcoinTextStyle.title3(textColor),
    titleMedium: BitcoinTextStyle.title4(textColor),
    titleSmall: BitcoinTextStyle.title5(textColor),
    bodyLarge: BitcoinTextStyle.body1(textColor),
    bodyMedium: BitcoinTextStyle.body2(textColor),
    bodySmall: BitcoinTextStyle.body4(textColor),
    labelLarge: BitcoinTextStyle.body4(textColor),
    labelMedium: BitcoinTextStyle.body5(textColor), // BottomNavigationBar
    labelSmall: BitcoinTextStyle.body5(textColor),
  );
}

appBarTheme(context) {
  return AppBarTheme(
    backgroundColor: Color(0xFF000000), //lightThemeColors(context).background,
    titleTextStyle: lightThemeText(context).headlineSmall,
  );
}

ThemeData materialLightTheme(context) {
  return ThemeData(
    colorScheme: lightThemeColors(context),
    textTheme: lightThemeText(context),
    scaffoldBackgroundColor: lightThemeColors(context).background,
    appBarTheme: appBarTheme(context),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue,
        unselectedItemColor: Colors.red),
  );
}
