import 'package:WarrantyBell/Constants/api_urls.dart';
import 'package:WarrantyBell/Constants/color_constants.dart';
import 'package:WarrantyBell/Element/padding_class.dart';
import 'package:WarrantyBell/Element/responsive_size_value.dart';
import 'package:WarrantyBell/widgets/common_text_view.dart';
import 'package:flutter/material.dart';

///CommonCategoryViewWidget
Widget commonCategoryCardView(String? title,String? icon){
  return SizedBox(
    width: setWidth(175),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 08,vertical: 04),
      child: Container(
        decoration: BoxDecoration(
          color: AppBackGroundColor.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, 1),
              blurRadius: 5,
              spreadRadius: 0,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: AppBackGroundColor.blue,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Image.network("${ApiUrls.imageUrl}$icon" ?? '',color: AppIconColor.white),
                ),
              ),
              paddingTop(10),
              commonTextView(title ?? '',fontWeight: FontWeight.w500,color: AppTextColor.blue,fontSize: 18,overflow: TextOverflow.ellipsis,maxLines: 1),
            ],
          ),
        ),
      ),
    ),
  );
}