import 'dart:ui';
import 'package:WarrantyBell/Constants/api_string.dart';
import 'package:WarrantyBell/Constants/color_constants.dart';
import 'package:WarrantyBell/Constants/image_constants.dart';
import 'package:WarrantyBell/Element/padding_class.dart';
import 'package:WarrantyBell/Enums/loading_status.dart';
import 'package:WarrantyBell/Pages/SettingScreen/Module/common_setting_item_view.dart';
import 'package:WarrantyBell/Pages/SettingScreen/setting_bloc.dart';
import 'package:WarrantyBell/Utils/Mixins/alert_dialog.dart';
import 'package:WarrantyBell/Utils/routes.dart';
import 'package:WarrantyBell/main.dart';
import 'package:WarrantyBell/widgets/common_text_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: BlocConsumer<SettingBloc, SettingState>(
        listener: (context, state) {
          if (state.status == LoadStatus.success && state.flag == 'delete') {
            Navigator.pushNamedAndRemoveUntil(context, login, (route) => false);
            sharedPref.removeAll();
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: PreferredSize(
                preferredSize: const Size(100, 150),
                child: Container(
                  padding: const EdgeInsets.only(top: 75),
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          end: Alignment.centerRight,
                          colors: <Color>[AppBarColor.lightBlue,AppBarColor.blue]),
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight : Radius.circular(10),)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.arrow_back,color: AppIconColor.white)),
                        Expanded(child: commonTextView(SettingString.setting, fontWeight: FontWeight.w500, color: AppTextColor.white, fontSize: 18)),
                      ],
                    ),
                  ),
                )),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  paddingTop(30),
                  commonSettingItemView(SettingString.notification,child: SvgPicture.asset(state.isNotificationStatus == false ? AppImages.switchOff : AppImages.switchOn),onTap: (){context.read<SettingBloc>().add(ChangeNotificationStatusEvent(isNotificationStatus: !state.isNotificationStatus!) );}),
                  commonSettingItemView(SettingString.privacyPolicy,child: const Icon(Icons.arrow_forward_ios_outlined),onTap: (){Navigator.pushNamed(context,privacyScreen);}),
                  commonSettingItemView(SettingString.terms,child: const Icon(Icons.arrow_forward_ios_outlined),onTap: (){Navigator.pushNamed(context,termsScreen);}),
                  // commonSettingItemView(SettingString.support,child: const Icon(Icons.arrow_forward_ios_outlined)),
                  commonSettingItemView(SettingString.changePassword,child: const Icon(Icons.arrow_forward_ios_outlined),onTap: (){Navigator.pushNamed(context,changePassword);}),
                  commonSettingItemView(SettingString.deleteAccount, onTap: (){ showAlertDialog(context, SettingString.deleteAccount, SettingString.areYouSureDelete, CommonString.yes,onTapOk: (){ Navigator.pop(context); context.read<SettingBloc>().add(DeleteAccountEvent());},isShowCancel: true,cancelButtonText: CommonString.no);}),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}