import 'package:ebutler_task/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

ThemeData getAppTheme(BuildContext context, bool isDark) {
  final textTheme = Theme.of(context).textTheme;

  return ThemeData(
    brightness: isDark ? Brightness.dark : Brightness.light,
    primaryColorDark: AppColors.dartkPrimary,
    primaryColorLight: AppColors.lightPrimary,
    scaffoldBackgroundColor: isDark
        ? AppColors.scaffoldBackgroundDarkColor
        : AppColors.scaffoldBackgroundLightColor,
    textTheme: GoogleFonts.tajawalTextTheme(textTheme).copyWith(
      subtitle1: TextStyle(color: AppColors.subtitle1LightColor),
      headline1: GoogleFonts.tajawal(
        textStyle: textTheme.headline1,
        color: isDark
            ? AppColors.headline1DarkColor
            : AppColors.headline1LightColor,
        fontSize: 22,
        fontWeight: FontWeight.w700,
      ),
      headline2: GoogleFonts.tajawal(
        textStyle: textTheme.headline2,
        color: isDark
            ? AppColors.headline2DarkColor
            : AppColors.headline2LightColor,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      headline3: GoogleFonts.tajawal(
        textStyle: textTheme.headline3,
        color: isDark
            ? AppColors.headline3DarkColor
            : AppColors.headline3LightColor,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      headline4: GoogleFonts.tajawal(
        textStyle: textTheme.headline4,
        color: isDark
            ? AppColors.headline4DarkColor
            : AppColors.headline4LightColor,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      headline5: GoogleFonts.tajawal(
        textStyle: textTheme.headline5,
        color: isDark
            ? AppColors.headline5DarkColor
            : AppColors.headline5LightColor,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      headline6: GoogleFonts.tajawal(
        textStyle: textTheme.headline6,
        color: isDark
            ? AppColors.headline6DarkColor
            : AppColors.headline6LightColor,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    ),
    cardTheme: CardTheme(
      color: isDark ? AppColors.cardDarkColor : AppColors.cardLightColor,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      shadowColor: isDark ? Colors.white : Colors.black,
    ),
    dividerColor: isDark ? Colors.white : Colors.grey,
    appBarTheme: AppBarTheme(
      elevation: 2,
      color: isDark ? Colors.blueGrey : AppColors.cardLightColor,
      iconTheme: IconThemeData(
        color: isDark ? Colors.white : Colors.black,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      errorMaxLines: 2,
      suffixIconColor: isDark ? Colors.white70 : Colors.grey,
      fillColor: Colors.white,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1,
          color: AppColors.enableColor,
          style: BorderStyle.solid,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      disabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(10.0),
        ),
        borderSide: BorderSide(
          width: 2,
          color:
              isDark ? AppColors.focuseDarkColor : AppColors.focuseLightColor,
          style: BorderStyle.solid,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(10.0),
        ),
        borderSide: BorderSide(
          width: 1,
          color: AppColors.errorColor,
          style: BorderStyle.solid,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(10.0),
        ),
        borderSide: BorderSide(
          width: 2,
          color: AppColors.errorColor,
          style: BorderStyle.solid,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 8,
      ),
      prefixIconColor: Colors.blue,
      labelStyle: Theme.of(context)
          .textTheme
          .headline4!
          .copyWith(color: Colors.grey.shade400, fontSize: 14),
      hintStyle: Theme.of(context)
          .textTheme
          .headline4!
          .copyWith(color:  Colors.grey , fontSize: 14),
    ),
    iconTheme: IconThemeData(
      color: isDark ? Colors.white : Colors.black,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        disabledBackgroundColor: Colors.grey,
        backgroundColor: isDark ? Colors.blueGrey : Colors.blue,
        textStyle: Theme.of(context).textTheme.headline6,
      ),
    ),
  );
}
