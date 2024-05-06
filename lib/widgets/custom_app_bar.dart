import 'package:cached_network_image/cached_network_image.dart';
import 'package:WarrantyBell/Constants/api_urls.dart';
import 'package:WarrantyBell/Constants/color_constants.dart';
import 'package:WarrantyBell/Constants/image_constants.dart';
import 'package:WarrantyBell/Utils/routes.dart';
import 'package:WarrantyBell/main.dart';
import 'package:WarrantyBell/widgets/common_text_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Networking/FirebaseNotificationHelper/firebase_notification.dart';

GlobalVariable globalVariable = GlobalVariable();

///CustomAppBar
Widget customAppBar({VoidCallback? onTapNotification, VoidCallback? onTapMenuBar}){
  return Container(
    padding: const EdgeInsets.only(top: 35),
    decoration:  const BoxDecoration(
    gradient: LinearGradient(
        end: Alignment.centerRight,
        colors: <Color>[AppBarColor.lightBlue,AppBarColor.blue]),
      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight : Radius.circular(10),)
  ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: userData.profile != '' ? "${ApiUrls.imageUrl}${userData.profile}" : "https://i.pinimg.com/564x/de/6e/8d/de6e8d53598eecfb6a2d86919b267791.jpg",
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width:10),
              commonTextView(userData.firstName.toString(),fontSize: 16,fontWeight: FontWeight.w600,color: AppTextColor.white)
            ],
          ),
          Row(
            children: [
              InkWell(
                onTap: onTapNotification,
                child: Stack(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppBackGroundColor.white,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SvgPicture.asset(AppImages.notification),
                      ),
                    ),
                    globalVariable.isNotificationArrive == true ? Positioned(
                        top : 2,
                        right: 0,
                        child: Container(
                          decoration: const BoxDecoration(
                              color: AppBackGroundColor.blue, borderRadius: BorderRadius.all(Radius.circular(100))
                          ),
                          height: 10,width: 10,
                        )) : const Offstage(),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: onTapMenuBar,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppBackGroundColor.white,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SvgPicture.asset(AppImages.menu),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}