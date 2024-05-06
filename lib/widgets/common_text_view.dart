import 'package:WarrantyBell/Constants/color_constants.dart';
import 'package:WarrantyBell/Style/text_style.dart';
import 'package:flutter/material.dart';

///Common TextView
Widget commonTextView(String title, {double? fontSize,Color? color,FontWeight? fontWeight,TextAlign? align,TextOverflow? overflow,int? maxLines}){
  return Text(
    title,
    style: TextStyleTheme.customTextStyle( color ?? AppTextColor.black, fontSize ?? 16, fontWeight ?? FontWeight.w600,),
    textAlign: align ?? TextAlign.center,
    overflow: overflow ?? TextOverflow.ellipsis,
    maxLines: maxLines ?? 2,
  );
}