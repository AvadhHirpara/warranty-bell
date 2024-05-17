import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:WarrantyBell/Constants/api_urls.dart';
import 'package:WarrantyBell/Constants/color_constants.dart';
import 'package:WarrantyBell/Constants/image_constants.dart';
import 'package:WarrantyBell/Controller/custom_text_field.dart';
import 'package:WarrantyBell/Controller/text_editing_controller.dart';
import 'package:WarrantyBell/Element/padding_class.dart';
import 'package:WarrantyBell/Enums/loading_status.dart';
import 'package:WarrantyBell/Pages/Authentications/EditProfile/edit_profile_bloc.dart';
import 'package:WarrantyBell/Utils/Mixins/progress_indicator.dart';
import 'package:WarrantyBell/Utils/routes.dart';
import 'package:WarrantyBell/Utils/validation.dart';
import 'package:WarrantyBell/main.dart';
import 'package:WarrantyBell/widgets/common_button.dart';
import 'package:WarrantyBell/widgets/common_text_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  List<FocusNode> focusNode = [FocusNode(), FocusNode(), FocusNode(), FocusNode(), FocusNode()];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode validate = AutovalidateMode.disabled;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: BlocConsumer<EditProfileBloc, EditProfileState>(
        listener: (context, state) {
          if(state.status == LoadStatus.loading){
            showProgressThreeDots(context);
          } else if (state.status == LoadStatus.success) {
            hideProgress(context);
            Navigator.pushNamed(context, homeScreen);
          } else if (state.status == LoadStatus.failure) {
            hideProgress(context);
          }
        },
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () => Future(() => false),
            child: Scaffold(
              appBar: PreferredSize(
                  preferredSize: const Size(100, 250),
                  child: Container(
                    padding: const EdgeInsets.only(top: 50),
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            end: Alignment.centerRight,
                            colors: <Color>[AppBarColor.lightBlue, AppBarColor.blue]),
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10),)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(Icons.arrow_back, color: AppIconColor.white)),
                          Align(
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    state.profileImage?.path == null ? CircleAvatar(
                                      radius: 60,
                                      child: ClipOval(
                                        child: CachedNetworkImage(
                                          imageUrl: userData.profile != '' ? "${ApiUrls.imageUrl}${userData.profile}" : "https://i.pinimg.com/564x/de/6e/8d/de6e8d53598eecfb6a2d86919b267791.jpg",
                                          width: 150,
                                          height: 150,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ) :
                                    Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: FileImage(File(state.profileImage!.path)),
                                            fit: BoxFit.cover
                                        ),
                                        borderRadius: const BorderRadius.all(Radius.circular(100.00)),
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      bottom: 0,
                                      child: GestureDetector(
                                        onTap: () {
                                          showImagePicker(context);
                                        },
                                        child: Container(
                                          width: 35,
                                          height: 35,
                                          decoration: BoxDecoration(
                                            color: AppBackGroundColor.white,
                                            borderRadius: BorderRadius.circular(100),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: SvgPicture.asset(AppImages.edit),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                paddingTop(05),
                                commonTextView('${userData.displayName}', fontWeight: FontWeight.w500, color: AppTextColor.white, fontSize: 18),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    autovalidateMode: validate,
                    child: Column(
                      children: [
                        paddingTop(20),
                        customTextField(
                            MediaQuery
                                .of(context)
                                .size
                                .width,
                            "First Name",
                            TextAlign.left,
                            fName,
                                (value) => validateFirstName(value),
                            focusNode[0],
                                (value) => userData.firstName = value,
                                (value) {
                              FocusScope.of(context).requestFocus();
                            },
                            false,
                            TextInputAction.next,
                            TextInputType.name,
                            TextCapitalization.none,
                            userData.firstName!,
                            context,
                            '',
                            isShowTitle: true
                        ),
                        paddingTop(10),
                        customTextField(
                            MediaQuery
                                .of(context)
                                .size
                                .width,
                            "Last Name",
                            TextAlign.left,
                            lName,
                                (value) => validateLastName(value),
                            focusNode[1],
                                (value) => userData.lastName = value.toString(),
                                (value) {
                              FocusScope.of(context).requestFocus();
                            },
                            false,
                            TextInputAction.next,
                            TextInputType.name,
                            TextCapitalization.none,
                            userData.lastName!,
                            context,
                            '',
                            isShowTitle: true
                        ),
                        paddingTop(10),
                        customTextField(
                            MediaQuery
                                .of(context)
                                .size
                                .width,
                            "Mobile Number",
                            TextAlign.left,
                            mobileNumber, (value) => validateMobileNumber(value),
                            focusNode[2], (value) => userData.mobile = int.parse(value),
                                (value) {
                              FocusScope.of(context).requestFocus();
                            },
                            false,
                            TextInputAction.next,
                            TextInputType.number,
                            TextCapitalization.none,
                            userData.mobile.toString(),
                            context,
                            '',
                            isShowTitle: true),
                        paddingTop(10),
                        customTextField(
                            MediaQuery
                                .of(context)
                                .size
                                .width,
                            "Email Id",
                            TextAlign.left,
                            rEmail,
                                (value) => validateEmail(value),
                            focusNode[3],
                                (value) => userData.email = value,
                                (value) {
                              FocusScope.of(context).requestFocus();
                            },
                            false,
                            TextInputAction.next,
                            TextInputType.name,
                            TextCapitalization.none,
                            userData.email!,
                            context,
                            '',
                            isShowTitle: true,
                            readOnly: true
                        ),
                        paddingTop(30),
                        commonButton("Submit", () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState?.save();
                            context.read<EditProfileBloc>().add(SubmitButtonEvent());
                          } else {
                            validate = AutovalidateMode.onUserInteraction;
                          }
                        }, 55),
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


  ///Check Camera Permission
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

  ///Show Image Picker
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
                                  picker.pickImage(source: ImageSource.camera).then((value) {
                                    if (value != null) {
                                      context.read<EditProfileBloc>().add(SelectedImageEvent(value));
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
                                      context.read<EditProfileBloc>().add(SelectedImageEvent(value));
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

}
