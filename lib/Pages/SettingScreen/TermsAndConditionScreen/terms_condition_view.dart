import 'package:WarrantyBell/Constants/api_string.dart';
import 'package:WarrantyBell/Constants/color_constants.dart';
import 'package:WarrantyBell/Enums/loading_status.dart';
import 'package:WarrantyBell/Pages/SettingScreen/TermsAndConditionScreen/terms_condition_bloc.dart';
import 'package:WarrantyBell/Utils/Mixins/progress_indicator.dart';
import 'package:WarrantyBell/widgets/common_text_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

class TermsAndConditionScreen extends StatefulWidget {
  const TermsAndConditionScreen({super.key});

  @override
  State<TermsAndConditionScreen> createState() => _TermsAndConditionScreenState();
}

class _TermsAndConditionScreenState extends State<TermsAndConditionScreen> {

  @override
  void initState() {
    super.initState();
    context.read<TermsConditionBloc>().add(TermsInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () { FocusScope.of(context).requestFocus(FocusNode()); },
      child: BlocConsumer<TermsConditionBloc, TermsConditionState>(
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
                      child: Stack(
                        children: [
                          Positioned(
                              left: 0,
                              right: 0,
                              child: commonTextView(SettingString.terms, fontWeight: FontWeight.w500, color: AppTextColor.white, fontSize: 18)),
                          InkWell(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: const Icon(Icons.arrow_back,color: AppIconColor.white)),
                        ],
                      ),
                    ),
                  )),
              body: SingleChildScrollView(
                  child:Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    child: Html(
                        data: state.termsData,
                      style: {
                        "h1": Style(color: AppTextColor.black,fontSize:  FontSize(20)),
                        "h3": Style(color: AppTextColor.black,fontSize:  FontSize(16)),
                        "p": Style(color: AppTextColor.black,fontSize:  FontSize(16)),
                        "body": Style(color: AppTextColor.black,fontSize:  FontSize(18))
                      },
                    ),
                  )
              ),
            ),
          );
        },
      ),
    );
  }
}