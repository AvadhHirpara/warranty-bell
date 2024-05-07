import 'dart:async';
import 'package:WarrantyBell/Controller/text_editing_controller.dart';
import 'package:bloc/bloc.dart';
import 'package:WarrantyBell/Constants/api_string.dart';
import 'package:WarrantyBell/Constants/api_urls.dart';
import 'package:WarrantyBell/Enums/loading_status.dart';
import 'package:WarrantyBell/Networking/ApiServicesHelper/api_services.dart';
import 'package:WarrantyBell/main.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc() : super(SettingState()) {

    on<SettingInitialEvent>((event, emit){
      emit(state.copyWith(isNotificationStatus: userData.notificationStatus));
    });

    on<ChangeNotificationStatusEvent>((event, emit) => changeNotificationStatus(event, emit));
    on<DeleteAccountEvent>((event, emit) => deleteAccount(event, emit));
  }

  FutureOr<void> changeNotificationStatus(ChangeNotificationStatusEvent event, Emitter<SettingState> emit) {
    emit(state.copyWith(isNotificationStatus: event.isNotificationStatus));
    Map<String, dynamic> body = {
      "status" : event.isNotificationStatus
    };

    updateNotificationSetting(body);
  }

  FutureOr<void> deleteAccount(DeleteAccountEvent event, Emitter<SettingState> emit) {
    deleteAccounts();
  }

  ///DeleteAccount
  Future deleteAccounts() async {
    String token = await sharedPref.read('token');
    Map<String,String> tokeWithHeader = {
      ApiServicesHeaderKEYs.accept: "application/json",
      ApiServicesHeaderKEYs.contentType: "application/json",
      ApiServicesHeaderKEYs.authorization : "Bearer $token"
    };
  emit(state.copyWith(status:LoadStatus.loading));
  try{
    var res = await ApiService.request(ApiUrls.deleteAccount, RequestMethods.POST, showLogs: true,   header: tokeWithHeader);
    if(res != null){
      if(res["statuscode"] == 200) {
        email.clear();
        loginPassword.clear();
        emit(state.copyWith(status:LoadStatus.success,flag: "delete"));
      }else{
        emit(state.copyWith(status:LoadStatus.failure));
      }
    }
  }
  catch(e){
    emit(state.copyWith(status:LoadStatus.failure));
    print("delete account exception $e");
  }
}

  ///UpdateNotificationSetting
  Future updateNotificationSetting(Map<String, dynamic> body) async {
    String token = await sharedPref.read('token');
    Map<String,String> tokeWithHeader = {
      ApiServicesHeaderKEYs.accept: "application/json",
      ApiServicesHeaderKEYs.contentType: "application/json",
      ApiServicesHeaderKEYs.authorization : "Bearer $token"
    };
    emit(state.copyWith(status:LoadStatus.loading));
    try{
      var res = await ApiService.request(ApiUrls.updateNotificationSetting, RequestMethods.POST, showLogs: true, header: tokeWithHeader,requestBody: body);
      if(res != null){
        if(res[UserModelKeys.data] != null ) {
          userData.notificationStatus = res[UserModelKeys.data]['status'];
        }else{
          emit(state.copyWith(status:LoadStatus.failure));
        }
      }
    }
    catch(e){
      emit(state.copyWith(status:LoadStatus.failure));
      print("notification setting  exception $e");
    }
  }

}