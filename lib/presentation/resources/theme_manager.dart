import 'package:_tut_app/presentation/resources/color_manager.dart';
import 'package:_tut_app/presentation/resources/fonts_manager.dart';
import 'package:_tut_app/presentation/resources/styles_manager.dart';
import 'package:_tut_app/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
      //main colors of the app
      primaryColor: ColorManager.primary,
      primaryColorLight: ColorManager.primaryOpacity70,
      primaryColorDark: ColorManager.darkPrimary,
      disabledColor: ColorManager.grey1,

      //accent color
      colorScheme:
          ColorScheme.fromSwatch().copyWith(secondary: ColorManager.grey),

      //ripple color
      splashColor: ColorManager.primaryOpacity70,

      //card view theme
      cardTheme: CardTheme(
          color: ColorManager.white,
          shadowColor: ColorManager.grey,
          elevation: AppSize.s4),

      //app bar theme
      appBarTheme: AppBarTheme(
          centerTitle: true,
          color: ColorManager.primary,
          elevation: AppSize.s4,
          shadowColor: ColorManager.primaryOpacity70,
          titleTextStyle: getRegularStyle(
              color: ColorManager.white, fontSize: FontSize.s16)),

      //button theme
      buttonTheme: ButtonThemeData(
          shape: StadiumBorder(),
          disabledColor: ColorManager.grey1,
          buttonColor: ColorManager.primary,
          splashColor: ColorManager.primaryOpacity70),

      //elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            textStyle: getRegularStyle(color: ColorManager.white),
            foregroundColor: ColorManager.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s12))),
      ),

      //text theme
      textTheme: TextTheme(
          //headline-1
          displayMedium: getSemiBoldStyle(
              color: ColorManager.darkGrey, fontSize: FontSize.s16),
          //subtitle-1
          titleSmall: getMediumStyle(
              color: ColorManager.lightGrey, fontSize: FontSize.s14),
          titleMedium: getMediumStyle(
              color: ColorManager.primary, fontSize: FontSize.s14),
          //caption
          labelLarge: getRegularStyle(color: ColorManager.grey1),
          //body text 1
          bodyMedium: getRegularStyle(color: ColorManager.grey)),
      inputDecorationTheme: InputDecorationTheme(
          contentPadding: EdgeInsets.all(AppPadding.p8),
          //hint style
          hintStyle: getRegularStyle(color: ColorManager.grey1),
          //label style
          labelStyle: getMediumStyle(color: ColorManager.darkGrey),
          //error style
          errorStyle: getRegularStyle(color: ColorManager.error),

          //enabled border
          enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: ColorManager.grey, width: AppSize.s1_5),
              borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
              borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),
          errorBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: ColorManager.grey, width: AppSize.s1_5),
              borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),
          focusedErrorBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: ColorManager.grey, width: AppSize.s1_5),
              borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)))));
}
