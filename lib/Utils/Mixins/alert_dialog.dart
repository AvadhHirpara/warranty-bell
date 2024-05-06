import 'package:WarrantyBell/Constants/color_constants.dart';
import 'package:WarrantyBell/Style/text_style.dart';
import 'package:flutter/material.dart';

showAlertDialog(BuildContext context, String title, String content,String okButtonText, {VoidCallback? onTapOk,bool isShowCancel = false,String cancelButtonText = ''}) {
  Widget okButton = ElevatedButton(
    style: ElevatedButton.styleFrom(backgroundColor:AppBackGroundColor.white),
    onPressed: onTapOk ?? () async {Navigator.pop(context);},
    child: Text(okButtonText, style: TextStyleTheme.customTextStyle(AppTextColor.black,12,FontWeight.w400)),
  );
  Widget cancelButton = ElevatedButton(
    style: ElevatedButton.styleFrom(backgroundColor:AppBackGroundColor.blue),
    onPressed:() async {Navigator.pop(context);},
    child: Text(cancelButtonText, style: TextStyleTheme.customTextStyle(AppTextColor.white,12,FontWeight.w400)),
  );
  AlertDialog alert = AlertDialog(
    title: Text(title,style: TextStyleTheme.customTextStyle(AppTextColor.blue, 16, FontWeight.w600,),),
    content: Text(content),
    actions: [
      okButton,
      isShowCancel == true  ? cancelButton : Container(),
    ],
  );

  /// show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}