import 'package:WarrantyBell/Constants/api_string.dart';
import 'package:WarrantyBell/Constants/color_constants.dart';
import 'package:WarrantyBell/Constants/image_constants.dart';
import 'package:WarrantyBell/Element/padding_class.dart';
import 'package:WarrantyBell/Style/text_style.dart';
import 'package:WarrantyBell/Utils/routes.dart';
import 'package:WarrantyBell/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    loadUserDataSharedPrefs();
    Future.delayed(const Duration(milliseconds: 2200), () {
      print("get user id in splace init state ${userData.userId}");
      userData.userId == '' ?  Navigator.pushNamed(context, login)  : Navigator.pushNamed(context,homeScreen) ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              end: Alignment.centerRight,
              colors: <Color>[AppBarColor.lightBlue,AppBarColor.blue]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 110.0),
              child: Image.asset(AppImages.appIcon),
            ),
            paddingTop(15),
            Text(AppName.warrantyBell,style: TextStyleTheme.customTextStyle(AppTextColor.white, 30, FontWeight.bold),)
          ],
        ),
      )
    );
  }
}
