import 'package:_tut_app/presentation/resources/fonts_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

TextStyle _getTextStyle(
    double fontSize, String fontFamily, FontWeight fontWeight, Color color) {
  return TextStyle(
      fontSize: fontSize,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      color: color);
}

//regular
TextStyle getRegularStyle({fontSize = FontSize.s12, required Color color}) {
  return TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: FontWeightManager.regular,
      fontFamily: FontConstants.fontFamily);
}

//bold
TextStyle getBoldStyle({fontSize = FontSize.s12, required Color color}) {
  return TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: FontWeightManager.bold,
      fontFamily: FontConstants.fontFamily);
}

//semi-bold
TextStyle getSemiBoldStyle({fontSize = FontSize.s12, required Color color}) {
  return TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: FontWeightManager.semiBold,
      fontFamily: FontConstants.fontFamily);
}

//medium
TextStyle getMediumStyle({fontSize = FontSize.s12, required Color color}) {
  return TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: FontWeightManager.medium,
      fontFamily: FontConstants.fontFamily);
}

//light
TextStyle getLightStyle({fontSize = FontSize.s12, required Color color}) {
  return TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: FontWeightManager.light,
      fontFamily: FontConstants.fontFamily);
}
