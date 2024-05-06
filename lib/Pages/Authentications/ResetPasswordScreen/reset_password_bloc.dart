import 'dart:async';
import 'package:WarrantyBell/Constants/api_urls.dart';
import 'package:WarrantyBell/Controller/text_editing_controller.dart';
import 'package:WarrantyBell/Enums/loading_status.dart';
import 'package:WarrantyBell/Networking/ApiServicesHelper/api_services.dart';
import 'package:WarrantyBell/Pages/Authentications/ResetPasswordScreen/reset_password_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  ResetPasswordBloc() : super(ResetPasswordState()) {
    on<ResetPasswordHideShowEvent>((event, emit) => showHidePass(event, emit));
    on<ResetConfirmPasswordHideShowEvent>((event, emit) => showHideConfirmPass(event, emit));
    on<ResetPasswordButtonEvent>((event, emit) => resetPasswordButtonTap(event, emit));
  }

  FutureOr<void> showHidePass(ResetPasswordHideShowEvent event, Emitter<ResetPasswordState> emit) {
    emit(state.copyWith(isObscureText: event.isObscureText));
  }

  FutureOr<void> showHideConfirmPass(ResetConfirmPasswordHideShowEvent event, Emitter<ResetPasswordState> emit) {
    emit(state.copyWith(isObscureConfirmPassword: event.isObscureConfirmPassword));
  }

  FutureOr<void> resetPasswordButtonTap (ResetPasswordButtonEvent event, Emitter<ResetPasswordState>emit){
    Map<String, dynamic> body = {
      "email" : fEmail.text,
      "new_password" :password.text,
      "confirm_password" : confirmPassword.text
    };

    resetPassword(body);
  }

  Future resetPassword(Map<String,dynamic> body) async {
    emit(state.copyWith(status:LoadStatus.loading));
    try{
      var res = await ApiService.request(ApiUrls.resetPassword, RequestMethods.POST, showLogs: true,header: commonHeader,requestBody: body);
      if(res != null){
        if(res["statuscode"] == 201) {
          emit(state.copyWith(status:LoadStatus.success));
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
