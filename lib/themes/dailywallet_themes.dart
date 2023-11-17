import 'dart:io';

import 'package:bitcoin_ui/bitcoin_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ThemeData materialLightTheme(context) {
  return ThemeData(
    colorScheme: lightThemeColors(context),
    textTheme: lightThemeText(context),
    scaffoldBackgroundColor: lightThemeColors(context).background,
    appBarTheme: appBarTheme(context),
  );
}

CupertinoThemeData cupertinoLightTheme(context) {
  return MaterialBasedCupertinoThemeData(
      materialTheme: materialLightTheme(context));
}

ColorScheme lightThemeColors(context) {
  return ColorScheme(
      brightness: Brightness.light,
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
    labelMedium: BitcoinTextStyle.body5(textColor), // NavigationBarItem.label
    labelSmall: BitcoinTextStyle.body5(textColor),
  );
}

appBarTheme(context) {
  return AppBarTheme(
    backgroundColor: Color(0xFF000000), //lightThemeColors(context).background,
    titleTextStyle: lightThemeText(context).headlineSmall,
  );
}

EdgeInsets platformInsets(InsetSize size) {
  if (Platform.isIOS) {
    switch (size) {
      case InsetSize.small:
        return const EdgeInsets.fromLTRB(16, 16, 16, 16);
      case InsetSize.medium:
        return const EdgeInsets.fromLTRB(32, 32, 32, 32);
      case InsetSize.large:
        return const EdgeInsets.fromLTRB(32, 32, 32, 40);
      default:
        return const EdgeInsets.fromLTRB(0, 0, 0, 16);
    }
  } else {
    switch (size) {
      case InsetSize.small:
        return const EdgeInsets.fromLTRB(16, 16, 16, 16);
      case InsetSize.medium:
        return const EdgeInsets.fromLTRB(32, 32, 32, 32);
      case InsetSize.large:
        return const EdgeInsets.fromLTRB(32, 32, 32, 24);
      default:
        return const EdgeInsets.fromLTRB(0, 0, 0, 16);
    }
  }
}

enum InsetSize { small, medium, large }
