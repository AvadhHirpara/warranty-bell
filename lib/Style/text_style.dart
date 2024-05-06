import 'package:flutter/material.dart';

class TextStyleTheme{
  static TextStyle customTextStyle(Color color, double size,FontWeight fontWeight, {double? spacing, TextDecoration? textDecoration, String? fontFamily}){
    return TextStyle(
      fontFamily: fontFamily ?? "Poppins",
      color: color,
      fontSize: size,
      fontWeight: fontWeight,
      decoration: textDecoration,
      letterSpacing: 0
    );
  }
}