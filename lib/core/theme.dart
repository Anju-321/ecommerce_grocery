import 'package:flutter/material.dart';
import 'style/colors.dart';
import 'style/fonts.dart';

const TextStyle appBarTextStyle = TextStyle(fontSize: 14, fontFamily: inter6SemiBold, color: secondaryBrandClr);

ThemeData appTheme = ThemeData(
  fontFamily: inter4Regular,
  appBarTheme: const AppBarTheme(
    color: backgroundLightClr,
    centerTitle: false,
    scrolledUnderElevation: 0,
    iconTheme: IconThemeData(color: secondaryBrandClr),
    titleTextStyle: appBarTextStyle,
  
  ),
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(seedColor: primaryClr).copyWith(background: backgroundLightClr),
);
