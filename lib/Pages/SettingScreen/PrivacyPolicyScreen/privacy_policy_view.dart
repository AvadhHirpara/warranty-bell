import 'package:WarrantyBell/Constants/api_string.dart';
import 'package:WarrantyBell/Constants/color_constants.dart';
import 'package:WarrantyBell/Enums/loading_status.dart';
import 'package:WarrantyBell/Pages/SettingScreen/PrivacyPolicyScreen/privacy_policy_bloc.dart';
import 'package:WarrantyBell/Utils/Mixins/progress_indicator.dart';
import 'package:WarrantyBell/widgets/common_text_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {

  @override
  void initState() {
    super.initState();
    context.read<PrivacyPolicyBloc>().add(PrivacyInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () { FocusScope.of(context).requestFocus(FocusNode()); },
      child: BlocConsumer<PrivacyPolicyBloc, PrivacyPolicyState>(
        listener: (context, state) {
          if(state.status == LoadStatus.loading){
            showProgressThreeDots(context);
          }else if(state.status == LoadStatus.success ){
            hideProgress(context);
          }else if(state.status == LoadStatus.failure){
            hideProgress(context);
          }
        },
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () => Future(() => false),
            child: Scaffold(
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
                              child: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Icon(Icons.arrow_back,color: AppIconColor.white),
                              )),
                          Expanded(child: commonTextView(SettingString.privacyPolicy, fontWeight: FontWeight.w500, color: AppTextColor.white, fontSize: 18)),
                        ],
                      ),
                    ),
                  )),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child:Html(
                    data: state.privacyData,
                    style: {
                      "h1": Style(color: AppTextColor.black,fontSize:  FontSize(20)),
                      "h3": Style(color: AppTextColor.black,fontSize:  FontSize(16)),
                      "p": Style(color: AppTextColor.black,fontSize:  FontSize(14)),
                      "body": Style(color: AppTextColor.black,fontSize:  FontSize(15))
                    },
                  )
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}