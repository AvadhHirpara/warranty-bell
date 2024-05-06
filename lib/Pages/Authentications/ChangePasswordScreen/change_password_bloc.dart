import 'dart:async';
import 'package:WarrantyBell/Constants/api_urls.dart';
import 'package:WarrantyBell/Controller/text_editing_controller.dart';
import 'package:WarrantyBell/Enums/loading_status.dart';
import 'package:WarrantyBell/Networking/ApiServicesHelper/api_services.dart';
import 'package:WarrantyBell/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Constants/api_string.dart';
part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc() : super(ChangePasswordState()) {
    on<ChangePasswordHideShowEvent>((event, emit) => showHidePass(event, emit));
    on<ChangeConfirmPasswordHideShowEvent>((event, emit) => showHideConfirmPass(event, emit));
    on<ChangePasswordButtonEvent>((event, emit) => changePasswordButtonTap(event, emit));
  }

  FutureOr<void> showHidePass(ChangePasswordHideShowEvent event, Emitter<ChangePasswordState> emit) {
    emit(state.copyWith(isObscureText: event.isObscureText));
  }

  FutureOr<void> showHideConfirmPass(ChangeConfirmPasswordHideShowEvent event, Emitter<ChangePasswordState> emit) {
    emit(state.copyWith(isObscureConfirmPassword: event.isObscureConfirmPassword));
  }

  FutureOr<void> changePasswordButtonTap (ChangePasswordButtonEvent event, Emitter<ChangePasswordState>emit){
    Map<String, dynamic> body = {
      "email" : userData.email,
      "new_password" :password.text,
      "confirm_password" : confirmPassword.text
    };

    resetPassword(body);
  }

  Future resetPassword(Map<String,dynamic> body) async {
    String token = await sharedPref.read('token');
    Map<String,String> tokeWithHeader = {
      ApiServicesHeaderKEYs.accept: "application/json",
      ApiServicesHeaderKEYs.contentType: "application/json",
      ApiServicesHeaderKEYs.authorization : "Bearer $token"
    };
    emit(state.copyWith(status:LoadStatus.loading));
    try{
      var res = await ApiService.request(ApiUrls.resetPassword, RequestMethods.POST, showLogs: true,header: tokeWithHeader,requestBody: body);
      if(res != null){
        if(res["statuscode"] == 201) {
          emit(state.copyWith(status:LoadStatus.success,message: res['message']));
        }else{
          emit(state.copyWith(status:LoadStatus.failure,message: res['message']));
        }
      }
    }
    catch(e){
      emit(state.copyWith(status:LoadStatus.failure));
      print("signin email exception $e");
    }
  }

}
