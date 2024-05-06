import 'package:WarrantyBell/Constants/color_constants.dart';
import 'package:WarrantyBell/Style/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///Common Button
Widget commonButton(String title,VoidCallback onTap,double buttonHeight,{Color? textColor,double? radius,Color? buttonColor}){
  return InkWell(
    onTap: onTap,
    child: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: buttonColor ?? AppButtonColor.blue,
        borderRadius: BorderRadius.circular(radius ?? 14)
      ),
    height: buttonHeight,
      child: Text(title,style: TextStyleTheme.customTextStyle(textColor ?? AppTextColor.white, 16, FontWeight.w500),),
    ),
  );
}