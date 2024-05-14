import 'package:awesome_top_snackbar/awesome_top_snackbar.dart';
import 'package:WarrantyBell/Constants/api_string.dart';
import 'package:WarrantyBell/Constants/color_constants.dart';
import 'package:WarrantyBell/Constants/image_constants.dart';
import 'package:WarrantyBell/Controller/custom_text_field.dart';
import 'package:WarrantyBell/Controller/text_editing_controller.dart';
import 'package:WarrantyBell/Element/padding_class.dart';
import 'package:WarrantyBell/Enums/loading_status.dart';
import 'package:WarrantyBell/Pages/Authentications/ForgotPasswordScreen/forgot_password_bloc.dart';
import 'package:WarrantyBell/Style/text_style.dart';
import 'package:WarrantyBell/Utils/Mixins/progress_indicator.dart';
import 'package:WarrantyBell/utils/routes.dart';
import 'package:WarrantyBell/utils/validation.dart';
import 'package:WarrantyBell/widgets/common_button.dart';
import 'package:WarrantyBell/widgets/common_text_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  List<FocusNode> focusNode = [FocusNode()];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode validate = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    double width;
    double height;

    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
  listener: (context, state) {
    if(state.status == LoadStatus.validationError){
      hideProgress(context);
    }else if(state.status == LoadStatus.success){
      hideProgress(context);
      Navigator.pushNamed(context,otpVerify);
    }else if (state.status == LoadStatus.failure){
      awesomeTopSnackbar(context,state.message.toString());
      hideProgress(context);
    }else if (state.status == LoadStatus.loading){
      showProgressThreeDots(context,loaderColor:AppBackGroundColor.blue);
    }
  },
  builder: (context, state) {
    return WillPopScope(
      onWillPop: () => Future(() => false),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: GestureDetector(onTap: (){  Navigator.pop(context);},child: const Icon(Icons.arrow_back,size: 25,)),
        ),
          body: Container(
            width: width,
            height: height,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: formKey,
              autovalidateMode: validate,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  paddingTop(30),
                  Center(child: SvgPicture.asset(AppImages.forgotSelected)),
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
                  Align(alignment : Alignment.center,child: commonTextView(ForgetPasswordString.forgotPasswordTitle,color:AppTextColor.blue, fontSize: 32,fontWeight: FontWeight.w600)),
                  paddingTop(15),
                  Center(child: commonTextView(ForgetPasswordString.forgotDescription,color:AppTextColor.darkGrey, fontSize: 14,fontWeight: FontWeight.w400)),
                  paddingTop(20),
                  customTextField(MediaQuery.of(context).size.width, '', TextAlign.left, fEmail, (value) => validateEmail(value), focusNode[0], (value) => '',
                        (value) {FocusScope.of(context).requestFocus();},
                    false, TextInputAction.done, TextInputType.emailAddress, TextCapitalization.none, LoginString.emailHint, context, '',),
                  paddingTop(35),
                  commonButton(ForgetPasswordString.continueButton,() {
                    if(formKey.currentState!.validate()){
                      context.read<ForgotPasswordBloc>().add(ForgotButtonEvent(email: fEmail.text));
                    }else{
                      validate = AutovalidateMode.onUserInteraction;
                    }
                  },60)
                ],
              ),
            ),
          ),
        ),
    );
  },
),
    );
  }

  @override
  void dispose() {
    fEmail.clear();
    super.dispose();
  }

}
