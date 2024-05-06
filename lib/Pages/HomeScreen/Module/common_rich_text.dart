import 'package:WarrantyBell/Constants/color_constants.dart';
import 'package:WarrantyBell/Style/text_style.dart';
import 'package:flutter/material.dart';

///Common Rich Text
Widget commonRichText(String? key, String? value,{int? maxLine}){
  return RichText(
    overflow: TextOverflow.ellipsis,
    maxLines:  maxLine ?? 1,
    text: TextSpan(
      children: <TextSpan>[
        TextSpan(text: key,
          style: TextStyleTheme.customTextStyle(AppTextColor.offBlue, 14, FontWeight.w500),
        ),
        TextSpan(
          text: value,
          style: TextStyleTheme.customTextStyle(AppTextColor.lightBlack, 14, FontWeight.w500),
        ),
      ],
    ),
  );
}