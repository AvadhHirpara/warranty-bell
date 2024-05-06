import 'package:awesome_top_snackbar/awesome_top_snackbar.dart';
import 'package:WarrantyBell/Constants/api_string.dart';
import 'package:WarrantyBell/Constants/color_constants.dart';
import 'package:WarrantyBell/Constants/image_constants.dart';
import 'package:WarrantyBell/Controller/text_editing_controller.dart';
import 'package:WarrantyBell/Element/padding_class.dart';
import 'package:WarrantyBell/Element/responsive_size_value.dart';
import 'package:WarrantyBell/Enums/loading_status.dart';
import 'package:WarrantyBell/Pages/Authentications/OtpVerifyScreen/otp_verify_bloc.dart';
import 'package:WarrantyBell/Style/text_style.dart';
import 'package:WarrantyBell/Utils/Mixins/progress_indicator.dart';
import 'package:WarrantyBell/utils/routes.dart';
import 'package:WarrantyBell/widgets/common_button.dart';
import 'package:WarrantyBell/widgets/common_text_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OtpVerifyScreen extends StatefulWidget {
  const OtpVerifyScreen({super.key});

  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  @override
  Widget build(BuildContext context) {
    double width;
    double height;

    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () { FocusScope.of(context).requestFocus(FocusNode()); },
      child: BlocConsumer<OtpVerifyBloc, OtpVerifyState>(
        listener: (context, state){
          if(state.status == LoadStatus.validationError){
            hideProgress(context);
          } else if(state.status == LoadStatus.success && state.flag == "resendOtp"){
            hideProgress(context);
            awesomeTopSnackbar(context,state.message.toString());
          }else if(state.status == LoadStatus.success){
            hideProgress(context);
            Navigator.pushNamed(context,resetPassword);
          }else if (state.status == LoadStatus.failure){
            awesomeTopSnackbar(context,state.message.toString());
            hideProgress(context);
          }else if (state.status == LoadStatus.loading){
            showProgressThreeDots(context,loaderColor:AppBackGroundColor.blue);
          }
        },
        builder: (context, state){
          return WillPopScope(
            onWillPop: () => Future(() => false),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: GestureDetector(onTap: (){  Navigator.pop(context);},child: const Icon(Icons.arrow_back,size: 25,)),
              ),
              body: Container(
                width: width,
                height: height,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    paddingTop(30),
                    Center(child: SvgPicture.asset(AppImages.otpSelected)),
                    paddingTop(40),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                          color:AppBackGroundColor.darkGrey,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Image.asset(AppImages.email),
                      ),
                    ),
                    paddingTop(15),
                    Align(alignment : Alignment.center,child: commonTextView(OtpVerifyString.otp,color:AppTextColor.blue, fontSize: 32,fontWeight: FontWeight.w600)),
                    paddingTop(25),
                    Center(child: commonTextView(OtpVerifyString.otpDescription,color:AppTextColor.darkGrey, fontSize: 14,fontWeight: FontWeight.w400)),
                    paddingTop(15),
                    OtpTextField(
                      numberOfFields: 5,
                      fieldWidth: setWidth(55),
                      borderRadius: BorderRadius.circular(12),
                      filled: true,
                      fillColor: AppBackGroundColor.lightGrey,
                      borderColor: AppBorderColor.blue,
                      showFieldAsBox: true,
                      onSubmit: (String code){
                        state.otp = code;
                      },
                    ),
                    paddingTop(15),
                    commonButton(OtpVerifyString.resetPassword,() {
                      if(state.otp != ''){
                        context.read<OtpVerifyBloc>().add(VerifyOtpEvent(email: fEmail.text,otp: state.otp));
                      }else{
                        awesomeTopSnackbar(context,"Please Enter Otp");
                      }
                    },60),
                    paddingTop(15),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(text:OtpVerifyString.didNotGet,
                              style: TextStyleTheme.customTextStyle(AppTextColor.darkBlue, 16, FontWeight.w400),
                            ),
                            TextSpan(
                              text: OtpVerifyString.resendOtp,
                              style: TextStyleTheme.customTextStyle(AppTextColor.navyBlue, 16, FontWeight.w400),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  context.read<OtpVerifyBloc>().add(ResendOtpEvent(email: fEmail.text));
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      )
    );
  }
}