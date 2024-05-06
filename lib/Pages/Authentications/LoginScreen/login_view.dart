import 'package:awesome_top_snackbar/awesome_top_snackbar.dart';
import 'package:WarrantyBell/Constants/api_string.dart';
import 'package:WarrantyBell/Constants/color_constants.dart';
import 'package:WarrantyBell/Constants/image_constants.dart';
import 'package:WarrantyBell/Controller/custom_text_field.dart';
import 'package:WarrantyBell/Controller/text_editing_controller.dart';
import 'package:WarrantyBell/Element/padding_class.dart';
import 'package:WarrantyBell/Enums/loading_status.dart';
import 'package:WarrantyBell/Pages/Authentications/LoginScreen/login_bloc.dart';
import 'package:WarrantyBell/Style/text_style.dart';
import 'package:WarrantyBell/Utils/Mixins/progress_indicator.dart';
import 'package:WarrantyBell/main.dart';
import 'package:WarrantyBell/utils/routes.dart';
import 'package:WarrantyBell/utils/validation.dart';
import 'package:WarrantyBell/widgets/common_button.dart';
import 'package:WarrantyBell/widgets/common_text_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  List<FocusNode> focusNode = [FocusNode(), FocusNode()];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode validate = AutovalidateMode.disabled;

  @override
  initState() {
    getToken();
    super.initState();
  }

  getToken() async {
    userData.deviceToken = (await fcm.getToken()) ?? '';
  }

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
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
         if (state.status == LoadStatus.loading){
              showProgressThreeDots(context,loaderColor:AppBackGroundColor.blue);
            }
            else if(state.status == LoadStatus.success){
              hideProgress(context);
              Navigator.pushNamed(context,homeScreen);
            }else if (state.status == LoadStatus.failure){
           hideProgress(context);
              awesomeTopSnackbar(context,state.message.toString());
            }
        },
        builder: (context, state) {
          return SafeArea(
            top: false, bottom: false,
            child: Scaffold(
              body: SingleChildScrollView(
                child: Container(
                  width: width,
                  height: height,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: formKey,
                    autovalidateMode: validate,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        paddingTop(45),
                        Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            color: AppBackGroundColor.darkGrey,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Image.asset(AppImages.signInLogo),
                        ),
                        paddingTop(15),
                        commonTextView(LoginString.signInTitle, color: AppTextColor.blue, fontSize: 32),
                        paddingTop(20),
                        customTextField(
                          MediaQuery
                              .of(context)
                              .size
                              .width,
                          '',
                          TextAlign.left,
                          email, (value) => validateEmail(value),
                          focusNode[0], (value) => userData.email = value,
                         (value) {FocusScope.of(context).requestFocus();},
                          false,
                          TextInputAction.next,
                          TextInputType.emailAddress,
                          TextCapitalization.none,
                          LoginString.emailHint,
                          context,
                          '',),
                        paddingTop(20),
                        customTextField(
                            MediaQuery
                                .of(context)
                                .size
                                .width,
                            '',
                            TextAlign.left,
                            loginPassword, (value) => validatePassword(value),
                            focusNode[1], (value) => userData.password = value,
                            (value) {FocusScope.of(context).requestFocus();},
                            state.isObscureText!,
                            TextInputAction.done,
                            TextInputType.emailAddress,
                            TextCapitalization.none,
                            LoginString.passwordHint,
                            context,
                            state.isObscureText == false ? AppImages.visiblityOff : AppImages.visiblityOn, onSuffixIconTap: () {
                          context.read<LoginBloc>().add(LoginPasswordHideShowEvent(isObscureText: !state.isObscureText!));
                        }),
                        paddingTop(05),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     // Row(
                        //     //   children: [
                        //     //     GestureDetector(
                        //     //       onTap: () {
                        //     //         context.read<LoginBloc>().add(CheckRememberEvent(!state.isRemember!));
                        //     //       },
                        //     //       child: Container(
                        //     //         padding: const EdgeInsets.all(01),
                        //     //         decoration: BoxDecoration(
                        //     //             borderRadius: BorderRadius.circular(08),
                        //     //             color: AppBackGroundColor.lightGrey
                        //     //         ),
                        //     //         child: Icon(Icons.check, color: state.isRemember == true ? AppIconColor.blue : AppIconColor.lightGrey, size: 20,),
                        //     //       ),
                        //     //     ),
                        //     //     const SizedBox(width: 05),
                        //     //     Text(LoginString.rememberMe, style: TextStyleTheme.customTextStyle(AppTextColor.grey, 14, FontWeight.w400),)
                        //     //   ],
                        //     // ),
                        //     GestureDetector(
                        //       onTap: () {
                        //         Navigator.pushNamed(context, forgotPassword);
                        //       },
                        //       child: commonTextView(LoginString.forgotPassword, color: AppTextColor.grey, fontSize: 14, fontWeight: FontWeight.w400),
                        //     ),
                        //   ],
                        // ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, forgotPassword);
                          },
                          child: Align(
                            alignment: Alignment.centerRight,
                              child: commonTextView(LoginString.forgotPassword, color: AppTextColor.grey, fontSize: 14, fontWeight: FontWeight.w400)),
                        ),
                        paddingTop(20),
                        Row(
                          children: [
                            const Expanded(child: Divider()),
                            commonTextView(LoginString.or, color: AppTextColor.darkBlue, fontSize: 16),
                            const Expanded(child: Divider()),
                          ],
                        ),
                        paddingTop(20),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: AppBackGroundColor.lightGrey,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(AppImages.facebook),
                                    const SizedBox(width: 8),
                                    Text(
                                        LoginString.facebook,
                                        style: TextStyleTheme.customTextStyle(AppTextColor.darkGrey, 16, FontWeight.w500)
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(width: 15),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: AppBackGroundColor.lightGrey,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(AppImages.google),
                                    const SizedBox(width: 8),
                                    Text(
                                        LoginString.google,
                                        style: TextStyleTheme.customTextStyle(AppTextColor.darkGrey, 16, FontWeight.w500)
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        paddingTop(35),
                        commonButton(LoginString.login, () {
                          if(formKey.currentState!.validate()){
                            formKey.currentState?.save();
                            context.read<LoginBloc>().add(LoginButtonEvent(email: email.text,password: loginPassword.text));
                          }else{
                            validate = AutovalidateMode.onUserInteraction;
                          }
                        }, 55),
                        paddingTop(05),
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(text: LoginString.dontHaveAccount,
                                style: TextStyleTheme.customTextStyle(AppTextColor.darkBlue, 16, FontWeight.w400),
                              ),
                              TextSpan(
                                text: LoginString.signUp,
                                style: TextStyleTheme.customTextStyle(AppTextColor.navyBlue, 18, FontWeight.w400),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(context, register);
                                  },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
    rEmail.clear();
    rPassword.clear();
    super.dispose();
  }

}
