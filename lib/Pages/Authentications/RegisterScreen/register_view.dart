import 'dart:io';
import 'package:awesome_top_snackbar/awesome_top_snackbar.dart';
import 'package:WarrantyBell/Constants/api_string.dart';
import 'package:WarrantyBell/Constants/color_constants.dart';
import 'package:WarrantyBell/Constants/image_constants.dart';
import 'package:WarrantyBell/Controller/custom_text_field.dart';
import 'package:WarrantyBell/Controller/text_editing_controller.dart';
import 'package:WarrantyBell/Element/padding_class.dart';
import 'package:WarrantyBell/Enums/loading_status.dart';
import 'package:WarrantyBell/Pages/Authentications/LoginScreen/login_view.dart';
import 'package:WarrantyBell/Pages/Authentications/RegisterScreen/register_bloc.dart';
import 'package:WarrantyBell/Pages/Authentications/RegisterScreen/register_event.dart';
import 'package:WarrantyBell/Pages/Authentications/RegisterScreen/register_state.dart';
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
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  List<FocusNode> focusNode = [FocusNode(), FocusNode(), FocusNode(), FocusNode(), FocusNode()];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode validate = AutovalidateMode.disabled;

  @override
  void initState(){
    super.initState();
    getToken();
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
      child: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if(state.status == LoadStatus.success){
            hideProgress(context);
            Navigator.pushNamedAndRemoveUntil(context, login, (route) => false);
          }else if(state.status == LoadStatus.loading){
            showProgressThreeDots(context,loaderColor:AppBackGroundColor.blue);
          }else if (state.status == LoadStatus.failure){
            hideProgress(context);
            awesomeTopSnackbar(context,state.message.toString());
          }else if(state.status == LoadStatus.validationError){
            hideProgress(context);
          }
        },
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () => Future(() => false),
            child: Scaffold(
              body: Container(
                width: width,
                height: height,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    autovalidateMode: validate,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        paddingTop(45),
                        commonTextView(RegisterString.signUpTitle, color: AppTextColor.blue, fontSize: 32),
                        paddingTop(15),
                       state.imageFile == null || state.imageFile?.path == '' ? Container(
                         height: 100,
                         width: 100,
                         decoration: BoxDecoration(
                           color: AppBackGroundColor.lightGrey,
                           borderRadius: BorderRadius.circular(50),
                         ),
                         child: GestureDetector(
                           onTap: () {
                             showImagePicker(context);
                           },
                           child: Padding(
                             padding: const EdgeInsets.all(35.0),
                             child: SvgPicture.asset(AppImages.camera),
                           ),
                         ),
                       ) : Container(
                         height: 100,
                         width: 100,
                         decoration: BoxDecoration(
                           image: DecorationImage(
                               image: FileImage(File(state.imageFile!.path)),
                               fit: BoxFit.cover
                           ),
                           borderRadius: const BorderRadius.all(Radius.circular(100.00)),
                         ),
                       ),
                        paddingTop(15),
                        state.imageFile == null || state.imageFile?.path == '' ? Container() : InkWell(
                            onTap: (){context.read<RegisterBloc>().add(SelectedImageEvent(XFile('')));},
                            child: commonTextView(RegisterString.removePhoto, fontWeight: FontWeight.w500, color: AppTextColor.red, fontSize: 16)),
                        InkWell(
                            onTap: (){
                              showImagePicker(context);
                            },
                            child: commonTextView(RegisterString.uploadPhoto, color: AppTextColor.blue, fontSize: 21, fontWeight: FontWeight.w500)),
                        paddingTop(20),
                        customTextField(
                          MediaQuery.of(context).size.width,
                          '',
                          TextAlign.left,
                          fName,
                          (value) => validateFirstName(value),
                          focusNode[0],
                          (value) => userData.firstName = value,
                          (value) {FocusScope.of(context).requestFocus();},
                          false,
                          TextInputAction.next,
                          TextInputType.name,
                          TextCapitalization.none,
                          RegisterString.firstName,
                          context,
                          '',
                        ),
                        paddingTop(20),
                        customTextField(
                          MediaQuery.of(context).size.width,
                          '',
                          TextAlign.left,
                          lName,
                          (value) => validateLastName(value),
                          focusNode[1],
                          (value) => userData.lastName = value,
                          (value) {FocusScope.of(context).requestFocus();},
                          false,
                          TextInputAction.next,
                          TextInputType.name,
                          TextCapitalization.none,
                          RegisterString.lastName,
                          context,
                          '',
                        ),
                        paddingTop(20),
                        customTextField(
                          MediaQuery.of(context).size.width,
                          '',
                          TextAlign.left,
                          rEmail,
                          (value) => validateEmail(value),
                          focusNode[2],
                              (value) => userData.email = value,
                              (value) {FocusScope.of(context).requestFocus();},
                          false,
                          TextInputAction.next,
                          TextInputType.emailAddress,
                          TextCapitalization.none,
                          RegisterString.emailHint,
                          context,
                          '',
                        ),
                        paddingTop(20),
                        customTextField(MediaQuery.of(context).size.width, '', TextAlign.left, mobileNumber, (value) => validateMobileNumber(value),
                                focusNode[3], (value) => userData.mobile = value,
                                (value) {FocusScope.of(context).requestFocus();},
                            false,
                            TextInputAction.next, TextInputType.number, TextCapitalization.none, RegisterString.mobileNumber, context, ''),
                        paddingTop(20),
                        customTextField(
                          MediaQuery.of(context).size.width,
                          '',
                          TextAlign.left,
                          rPassword,
                          (value) => validatePassword(value),
                          focusNode[4],
                          (value) => userData.password = value,
                          (value) {FocusScope.of(context).requestFocus();},
                          state.isObscureText!,
                          TextInputAction.done,
                          TextInputType.emailAddress,
                          TextCapitalization.none,
                          RegisterString.passwordHint,
                          context,
                          state.isObscureText == false ? AppImages.visiblityOff : AppImages.visiblityOn,
                          onSuffixIconTap: () {
                            print("call on tap icon${state.isObscureText} ");
                            context.read<RegisterBloc>().add(RegisterPasswordHideShowEvent(!state.isObscureText!));
                          },
                        ),
                        paddingTop(15),
                        Row(
                          children: [
                            const Expanded(child: Divider()),
                            commonTextView(LoginString.or, color: AppTextColor.darkBlue, fontSize: 16),
                            const Expanded(child: Divider()),
                          ],
                        ),
                        paddingTop(20),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: Container(
                        //         padding: const EdgeInsets.all(15),
                        //         decoration: BoxDecoration(
                        //           color: AppBackGroundColor.lightGrey,
                        //           borderRadius: BorderRadius.circular(14),
                        //         ),
                        //         child: Row(
                        //           children: [
                        //             SvgPicture.asset(AppImages.facebook),
                        //             const SizedBox(width: 8),
                        //             Text(LoginString.facebook, style: TextStyleTheme.customTextStyle(AppTextColor.darkGrey, 16, FontWeight.w500)),
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //     const SizedBox(width: 15),
                        //     Expanded(
                        //       child: Container(
                        //         padding: const EdgeInsets.all(15),
                        //         decoration: BoxDecoration(
                        //           color: AppBackGroundColor.lightGrey,
                        //           borderRadius: BorderRadius.circular(14),
                        //         ),
                        //         child: Row(
                        //           children: [
                        //             SvgPicture.asset(AppImages.google),
                        //             const SizedBox(width: 8),
                        //             Text(LoginString.google, style: TextStyleTheme.customTextStyle(AppTextColor.darkGrey, 16, FontWeight.w500)),
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // paddingTop(10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                context.read<RegisterBloc>().add(CheckTermsEvent(!state.isTerms!));
                              },
                              child: Container(
                                padding: const EdgeInsets.all(01),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(08), color: AppBackGroundColor.lightGrey),
                                child: Icon(
                                  Icons.check,
                                  color: state.isTerms == true ? AppIconColor.blue : AppIconColor.lightGrey,
                                  size: 20,
                                ),
                              ),
                            ),
                            const SizedBox(width: 05),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: RegisterString.iAgree,
                                      style: TextStyleTheme.customTextStyle(AppTextColor.darkBlue, 14, FontWeight.w400),
                                    ),
                                    TextSpan(
                                      text: RegisterString.terms,
                                      style: TextStyleTheme.customTextStyle(AppTextColor.navyBlue, 14, FontWeight.w400),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                                        },
                                    ),
                                    TextSpan(
                                      text: RegisterString.and,
                                      style: TextStyleTheme.customTextStyle(AppTextColor.darkBlue, 14, FontWeight.w400),
                                    ),
                                    TextSpan(
                                      text: RegisterString.privacy,
                                      style: TextStyleTheme.customTextStyle(AppTextColor.navyBlue, 14, FontWeight.w400),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        paddingTop(35),
                        commonButton(RegisterString.register, () {
                          if (formKey.currentState!.validate()) {
                            if(state.isTerms != true){
                              awesomeTopSnackbar(context,"Please check Terms & Condition");
                            }else{
                              context.read<RegisterBloc>().add(RegisterButtonEvent(email: rEmail.text, password: rPassword.text,fName: fName.text,lName: lName.text,mobile: mobileNumber.text,imageFile: state.imageFile));
                            }
                          } else {
                            validate = AutovalidateMode.onUserInteraction;
                          }
                        }, 55),
                        paddingTop(05),
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: RegisterString.doHaveAccount,
                                style: TextStyleTheme.customTextStyle(AppTextColor.darkBlue, 18, FontWeight.w400),
                              ),
                              TextSpan(
                                text: RegisterString.signIn,
                                style: TextStyleTheme.customTextStyle(AppTextColor.navyBlue, 18, FontWeight.w400),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    Navigator.pushNamed(context, login);
                                  },
                              ),
                            ],
                          ),
                        ),
                        paddingBottom(20),
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

  Future<bool> permissionCheck() async {
    final status = await Permission.camera.status;
    if (status == PermissionStatus.granted) {
      return true;
    } else if (status == PermissionStatus.permanentlyDenied) {
      openAppSettings();
    }
    final result = await Permission.camera.request();
    return result == PermissionStatus.granted;
  }

  void showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      useRootNavigator: true,
      enableDrag: false,
      builder: (BuildContext context1) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              Navigator.pop(context);
                              permissionCheck().then((value) async {
                                if (value) {
                                  final ImagePicker picker = ImagePicker();
                                  picker.pickImage(source: ImageSource.camera,

                                  ).then((value) {
                                    if (value != null) {
                                      context.read<RegisterBloc>().add(SelectedImageEvent(value));
                                    }
                                  });
                                }
                              });
                            },
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                color: AppBackGroundColor.darkGrey,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(padding: const EdgeInsets.all(15), child: SvgPicture.asset(AppImages.bottomCamera)),
                            ),
                          ),
                          const Text("Take a picture")
                        ],
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              Navigator.pop(context);
                              permissionCheck().then((value) async {
                                if (value) {
                                  final ImagePicker picker = ImagePicker();
                                  picker.pickImage(source: ImageSource.gallery).then((value) {
                                    if (value != null) {
                                      context.read<RegisterBloc>().add(SelectedImageEvent(value));
                                    }
                                  });
                                }
                              });
                            },
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                color: AppBackGroundColor.darkGrey,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(padding: const EdgeInsets.all(15), child: SvgPicture.asset(AppImages.gallery)),
                            ),
                          ),
                          const Text("Choose a picture")
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              paddingTop(10),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    fName.clear();
    lName.clear();
    rEmail.clear();
    rPassword.clear();
    mobileNumber.clear();
    super.dispose();
  }

}
