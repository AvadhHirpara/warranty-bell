import 'dart:async';
import 'dart:io';
import 'package:WarrantyBell/Constants/api_string.dart';
import 'package:WarrantyBell/Constants/api_urls.dart';
import 'package:WarrantyBell/Controller/text_editing_controller.dart';
import 'package:WarrantyBell/Enums/loading_status.dart';
import 'package:WarrantyBell/Model/user_data_model.dart';
import 'package:WarrantyBell/Networking/ApiServicesHelper/api_services.dart';
import 'package:WarrantyBell/Pages/Authentications/RegisterScreen/register_state.dart';
import 'package:WarrantyBell/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'register_event.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterState()) {
    on<RegisterPasswordHideShowEvent>((event, emit) => showHidePass(event, emit));
    on<CheckTermsEvent>((event, emit) => isTerms(event, emit));
    on<SelectedImageEvent>(_onSelectedImageEvent);
    on<RegisterButtonEvent>((event, emit) => registerButtonTap(event, emit));
  }

  FutureOr<void> showHidePass(RegisterPasswordHideShowEvent event, Emitter<RegisterState> emit) {
    emit(state.copyWith(isObscureText: event.isObscureText));
  }

  FutureOr<void> isTerms(CheckTermsEvent event, Emitter<RegisterState>emit) {
    emit(state.copyWith(isTerms: event.isTerms));
  }

  FutureOr<void> _onSelectedImageEvent(SelectedImageEvent event, Emitter<RegisterState> emit) {
    emit(state.copyWith(imageFile: event.imageFile));
  }


  FutureOr<void> registerButtonTap(RegisterButtonEvent event, Emitter<RegisterState>emit) {
    Map<String, dynamic> body ;
    print("iamge file is ${event.imageFile}");
    if(event.imageFile == null){
      body = {
        "email" : rEmail.text,
        "first_name" : fName.text,
        "last_name" : lName.text,
        "mobile" : mobileNumber.text,
        "password" : rPassword.text,
        "device_type" : LoginTypeDefault.defaultLogin,
        "device_token" :  userData.deviceToken,
        "login_type" : Platform.operatingSystem,
        "photo" : ''
      };
    }else{
      body = {
        "email" : rEmail.text,
        "first_name" : fName.text,
        "last_name" : lName.text,
        "mobile" : mobileNumber.text,
        "password" : rPassword.text,
        "device_type" : LoginTypeDefault.defaultLogin,
        "device_token" :  userData.deviceToken,
        "login_type" : Platform.operatingSystem,
      };
    }

    signUpWithEmailPassword(event.imageFile,body);
  }


  Future signUpWithEmailPassword( imageFile,Map<String, dynamic> body) async {
    emit(state.copyWith(status:LoadStatus.loading));
    try {
      var res = await ApiService.request(ApiUrls.register, RequestMethods.POSTFILE, showLogs: true, header: commonHeaderWithMultiPartFormData, requestBody: body,postFiles:imageFile);
          if(res[UserModelKeys.data] != null){
            if (res[UserModelKeys.data] != null || res['statuscode'] == 201) {
              UserData userRes = UserData.fromJson(res[UserModelKeys.data]);
              userData.userId = userRes.userId;
              userData.displayName ="${userData.firstName ?? ''} ${userData.lastName ?? ''}";
              userData.authToken = userRes.authToken;
              userData.mobile = userRes.mobile;
              userData.displayName = "${userData.firstName ?? ''} ${userData.lastName ?? ''}";
              updateUserDataSharedPrefs(userData);
              emit(state.copyWith(status:LoadStatus.success,message: res['message']));
            }
          }else{
            emit(state.copyWith(status:LoadStatus.failure,message: res['message']));
          }
      }
    catch (e) {
      emit(state.copyWith(status:LoadStatus.failure));
      print("signup email exception $e");
    }
  }
}