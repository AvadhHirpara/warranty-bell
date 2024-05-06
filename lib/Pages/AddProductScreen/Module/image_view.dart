import 'dart:io';
import 'package:WarrantyBell/Constants/api_urls.dart';
import 'package:WarrantyBell/Constants/color_constants.dart';
import 'package:WarrantyBell/Constants/image_constants.dart';
import 'package:WarrantyBell/Element/padding_class.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

///ImageViewDialog
showImage(BuildContext context, {String? imageUrl, XFile? image}){
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        backgroundColor: AppBackGroundColor.white,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child:Column(
            mainAxisSize: MainAxisSize.min,
            children: [
                GestureDetector(
                  onTap: (){Navigator.pop(context);},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: SvgPicture.asset(AppImages.closeIcon)),
                  ),
                ),
            paddingTop(05),
              imageUrl != '' ? Image.network("${ApiUrls.imageUrl}$imageUrl",height: 250,width: double.maxFinite,fit: BoxFit.cover) : Image.file(File(image!.path),height: 250,width: double.maxFinite,fit: BoxFit.cover),
              paddingBottom(45)
            ],
          )
        ),
      );
    },
  );
}