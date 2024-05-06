import 'package:awesome_top_snackbar/awesome_top_snackbar.dart';
import 'package:WarrantyBell/Constants/api_string.dart';
import 'package:WarrantyBell/Constants/color_constants.dart';
import 'package:WarrantyBell/Constants/image_constants.dart';
import 'package:WarrantyBell/Controller/custom_text_field.dart';
import 'package:WarrantyBell/Controller/text_editing_controller.dart';
import 'package:WarrantyBell/Element/padding_class.dart';
import 'package:WarrantyBell/Enums/loading_status.dart';
import 'package:WarrantyBell/Pages/Authentications/ChangePasswordScreen/change_password_bloc.dart';
import 'package:WarrantyBell/Utils/Mixins/progress_indicator.dart';
import 'package:WarrantyBell/Utils/routes.dart';
import 'package:WarrantyBell/utils/validation.dart';
import 'package:WarrantyBell/widgets/common_button.dart';
import 'package:WarrantyBell/widgets/common_text_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  List<FocusNode> focusNode = [FocusNode(), FocusNode()];
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
      child: BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
        listener: (context, state) {
          if(state.status == LoadStatus.validationError){
            hideProgress(context);
          }else if(state.status == LoadStatus.success){
            hideProgress(context);
            awesomeTopSnackbar(context,state.message.toString());
            Navigator.pushNamed(context, homeScreen);
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
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      size: 25,
                    )),
              ),
              body: SingleChildScrollView(
                child: Container(
                  width: width,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: formKey,
                    autovalidateMode: validate,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        paddingTop(40),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                              color: AppBackGroundColor.darkGrey,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Image.asset(AppImages.lock),
                          ),
                        ),
                        paddingTop(15),
                        Align(alignment: Alignment.center, child: commonTextView(ChangePasswordString.resetPassword, color: AppTextColor.blue, fontSize: 32, fontWeight: FontWeight.w600)),
                        paddingTop(15),
                        customTextField(
                          MediaQuery.of(context).size.width,
                          '',
                          TextAlign.left,
                          password,
                              (value) => validatePassword(value),
                          focusNode[0],
                              (value) => '',
                              (value) {FocusScope.of(context).requestFocus();},
                          state.isObscureText!,
                          TextInputAction.next,
                          TextInputType.text,
                          TextCapitalization.none,
                          ChangePasswordString.passwordHint,
                          context,
                          state.isObscureText == false ? AppImages.visiblityOff : AppImages.visiblityOn,
                          onSuffixIconTap: () {
                            context.read<ChangePasswordBloc>().add(ChangePasswordHideShowEvent(!state.isObscureText!));
                          },
                        ),
                        paddingTop(20),
                        customTextField(
                          MediaQuery.of(context).size.width,
                          '',
                          TextAlign.left,
                          confirmPassword,
                              (value) => validateConfirmPassword(password.text, value),
                          focusNode[1],
                              (value) => '',
                              (value) {FocusScope.of(context).requestFocus();},
                          state.isObscureConfirmPassword!,
                          TextInputAction.done,
                          TextInputType.text,
                          TextCapitalization.none,
                          ChangePasswordString.confirmPasswordTitle,
                          context,
                          state.isObscureConfirmPassword == false ? AppImages.visiblityOff : AppImages.visiblityOn,
                          onSuffixIconTap: () {
                            context.read<ChangePasswordBloc>().add(ChangeConfirmPasswordHideShowEvent(!state.isObscureConfirmPassword!));
                          },
                        ),
                        paddingTop(45),
                        commonButton(ChangePasswordString.submit, () {
                          if (formKey.currentState!.validate()) {
                            context.read<ChangePasswordBloc>().add(ChangePasswordButtonEvent(password: password.text, confirmPassword: confirmPassword.text));
                          } else {
                            validate = AutovalidateMode.onUserInteraction;
                          }
                        }, 60)
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
    password.clear();
    confirmPassword.clear();
    super.dispose();
  }
}
