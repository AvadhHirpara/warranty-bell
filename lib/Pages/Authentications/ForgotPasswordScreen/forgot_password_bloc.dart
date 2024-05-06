import 'package:bloc/bloc.dart';
import 'package:WarrantyBell/Constants/api_urls.dart';
import 'package:WarrantyBell/Controller/text_editing_controller.dart';
import 'package:WarrantyBell/Enums/loading_status.dart';
import 'package:WarrantyBell/Model/forgot_password_model.dart';
import 'package:WarrantyBell/Networking/ApiServicesHelper/api_services.dart';

part 'forgot_password_state.dart';
part 'forgot_password_event.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordState()) {
    on<ForgotButtonEvent>((event, emit) => forgotButtonTap(event, emit));
  }


forgotButtonTap (ForgotButtonEvent event, Emitter<ForgotPasswordState>emit){
    Map<String, dynamic> body = {
      "email" : fEmail.text,
    };

    forgotPassword(body);
  }

  forgotPassword(Map<String,dynamic> body) async {
    emit(state.copyWith(status:LoadStatus.loading));
    try {
      var res = await ApiService.request(ApiUrls.forgotPassword, RequestMethods.POST, showLogs: true, header: commonHeader,requestBody:body);
      if(res["statuscode"] != 400){
        emit(state.copyWith(status:LoadStatus.success));
      }else{
        emit(state.copyWith(status:LoadStatus.failure,message: res["message"]));
      }
    } catch (e) {
      emit(state.copyWith(status:LoadStatus.failure));
      print('forgot password exception : $e');
    }
  }

}


