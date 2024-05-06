import 'package:WarrantyBell/Constants/color_constants.dart';
import 'package:WarrantyBell/widgets/common_text_view.dart';
import 'package:flutter/material.dart';

///CommonSettingItemView
Widget commonSettingItemView(String text,{Widget? child,VoidCallback? onTap}){
  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: AppBackGroundColor.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0,0),
              spreadRadius: 2,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 08),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              commonTextView(text, color: AppTextColor.lightBlack, fontSize: 16, fontWeight: FontWeight.w500),
              child ?? Container()
            ],
          ),
        ),
      ),
    ),
  );
}