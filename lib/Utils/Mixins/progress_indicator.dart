import 'package:WarrantyBell/Constants/color_constants.dart';
import 'package:WarrantyBell/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

showProgressThreeDots(BuildContext context,{Color? loaderColor}) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: SpinKitRing(
          color: loaderColor ?? AppBackGroundColor.blue,
          size: 25,
        ),
      ));
}

hideProgress(BuildContext context) async {
  Navigator.pop(context);
}