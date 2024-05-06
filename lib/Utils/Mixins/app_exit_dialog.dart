import 'dart:io';
import 'package:WarrantyBell/Constants/api_string.dart';
import 'package:WarrantyBell/Constants/color_constants.dart';
import 'package:WarrantyBell/Style/text_style.dart';
import 'package:flutter/material.dart';

Future<bool> showExitPopup(context) async{
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.symmetric(vertical: 15,horizontal: 18),
          content: Wrap(
            children: [
              Text(CommonString.doYouExit,style: TextStyleTheme.customTextStyle(AppTextColor.black, 14, FontWeight.normal),),
              const SizedBox(height: 40),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        exit(0);
                      },
                      style: ElevatedButton.styleFrom(backgroundColor:AppBackGroundColor.blue),
                      child: Text(CommonString.yes,style: TextStyleTheme.customTextStyle(AppTextColor.white,12,FontWeight.w400)),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppBackGroundColor.darkGrey,
                        ),
                        child: Text(CommonString.no, style: TextStyleTheme.customTextStyle(AppTextColor.white,12,FontWeight.w400)),
                      ))
                ],
              )
            ],
          ),
        );
      });
}