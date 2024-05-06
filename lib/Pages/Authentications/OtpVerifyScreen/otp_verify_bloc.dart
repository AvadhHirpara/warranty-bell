import 'package:bloc/bloc.dart';
import 'package:WarrantyBell/Constants/api_urls.dart';
import 'package:WarrantyBell/Controller/text_editing_controller.dart';
import 'package:WarrantyBell/Enums/loading_status.dart';
import 'package:WarrantyBell/Networking/ApiServicesHelper/api_services.dart';
import 'package:meta/meta.dart';

part 'otp_verify_event.dart';
part 'otp_verify_state.dart';

class OtpVerifyBloc extends Bloc<OtpVerifyEvent, OtpVerifyState> {
  OtpVerifyBloc() : super(OtpVerifyState()) {
    on<VerifyOtpEvent>((event, emit) => otpVerifyButtonTap(event, emit));
    on<ResendOtpEvent>((event, emit) => resendOtpButtonTap(event, emit));
  }

  otpVerifyButtonTap (VerifyOtpEvent event, Emitter<OtpVerifyState>emit){
    Map<String, dynamic> body = {
      "email" : fEmail.text,
      "otp" : event.otp
    };

    forgotPassword(body);
  }

  resendOtpButtonTap (ResendOtpEvent event, Emitter<OtpVerifyState>emit){
    Map<String, dynamic> body = {
      "email" : fEmail.text,
    };

    resendOtp(body);
  }

  resendOtp(Map<String,dynamic> body) async {
    emit(state.copyWith(status:LoadStatus.loading));
    try {
      var res = await ApiService.request(ApiUrls.resendOtp, RequestMethods.POST, showLogs: true, header: commonHeader,requestBody:body);
      if(res["statuscode"] != 400){
        emit(state.copyWith(status:LoadStatus.success,flag: "resendOtp",message:res["message"]));
      }else{
        emit(state.copyWith(status:LoadStatus.failure,message: res["message"]));
      }
    } catch (e) {
      emit(state.copyWith(status:LoadStatus.failure));
      print('resend password exception : $e');
    }
  }


  forgotPassword(Map<String,dynamic> body) async {
    emit(state.copyWith(status:LoadStatus.loading));
    try {
      var res = await ApiService.request(ApiUrls.verifyOtp, RequestMethods.POST, showLogs: true, header: commonHeader,requestBody:body);
      if(res["statuscode"] == 200){
        emit(state.copyWith(status:LoadStatus.success,message: res["message"]));
      }else{
        emit(state.copyWith(status:LoadStatus.failure,message: res["message"]));
      }
    } catch (e) {
      emit(state.copyWith(status:LoadStatus.failure));
      print('forgot password exception : $e');
    }
  }

}
