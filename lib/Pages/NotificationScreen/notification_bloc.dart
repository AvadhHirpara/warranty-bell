import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:WarrantyBell/Constants/api_string.dart';
import 'package:WarrantyBell/Constants/api_urls.dart';
import 'package:WarrantyBell/Enums/loading_status.dart';
import 'package:WarrantyBell/Model/notification_model.dart';
import 'package:WarrantyBell/Networking/ApiServicesHelper/api_services.dart';
import 'package:WarrantyBell/main.dart';
import 'package:meta/meta.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  List<NotificationModel> notificationList = [];

  NotificationBloc() : super(NotificationState()) {
    on<NotificationInitialEvent>((event, emit) {
      getNotifications();
    });

    on<DeleteNotificationEvent>(deleteNotification);
    on<UpdateNotificationEvent>(updateNotificationStatus);

  }

  ///DeleteProductButtonTap
  FutureOr<void> deleteNotification(DeleteNotificationEvent event, Emitter<NotificationState>emit){
    deleteNotifications(event.notificationModel?.sId,);
  }

  ///DeleteProductButtonTap
  FutureOr<void> updateNotificationStatus(UpdateNotificationEvent event, Emitter<NotificationState>emit){

    Map<String, dynamic> body ={
      "notification_id" : event.notificationModel?.sId,
      "status" : true
    };

    updateNotification(body);
  }

  ///GetNotification
  Future getNotifications() async {
    String token = await sharedPref.read('token');
    Map<String,String> tokeWithHeader = {
      ApiServicesHeaderKEYs.accept: "application/json",
      ApiServicesHeaderKEYs.contentType: "application/json",
      ApiServicesHeaderKEYs.authorization : "Bearer $token"
    };
    emit(state.copyWith(status:LoadStatus.loading));
    try{
      var res = await ApiService.request(ApiUrls.getNotification, RequestMethods.GET, showLogs: true,header: tokeWithHeader);
      if(res != null){
        if(res[UserModelKeys.data] != null && res[UserModelKeys.data] is List) {
          for (var element in (res[UserModelKeys.data])) {
            NotificationModel notificationModel = NotificationModel.fromJson(element ?? {});
            notificationList.add(notificationModel);
          }
          emit(state.copyWith(status:LoadStatus.success,notifications: notificationList,flag: "notification"));
        }else{
          emit(state.copyWith(status:LoadStatus.failure));
        }
      }
    }
    catch(e){
      emit(state.copyWith(status:LoadStatus.failure));
      print("get notifications exception $e");
    }
  }

  ///DeleteNotification
  Future deleteNotifications(String? id) async {
    String token = await sharedPref.read('token');
    Map<String,String> tokeWithHeader = {
      ApiServicesHeaderKEYs.accept: "application/json",
      ApiServicesHeaderKEYs.contentType: "application/json",
      ApiServicesHeaderKEYs.authorization : "Bearer $token"
    };
    emit(state.copyWith(status:LoadStatus.loading));
    try{
      var res = await ApiService.request("${ApiUrls.deleteNotification}?${ApiUrls.notificationId}=$id", RequestMethods.POST, showLogs: true, header: tokeWithHeader);
      if(res != null){
        if(res["statuscode"] == 201) {
          emit(state.copyWith(status:LoadStatus.success,flag: "delete"));
        }else{
          emit(state.copyWith(status:LoadStatus.failure));
        }
      }
    }
    catch(e){
      emit(state.copyWith(status:LoadStatus.failure));
      print("delete notification exception $e");
    }
  }

  ///UpdateNotification
  Future updateNotification(Map<String, dynamic> body) async {
    String token = await sharedPref.read('token');
    Map<String,String> tokeWithHeader = {
      ApiServicesHeaderKEYs.accept: "application/json",
      ApiServicesHeaderKEYs.contentType: "application/json",
      ApiServicesHeaderKEYs.authorization : "Bearer $token"
    };
    try{
      var res = await ApiService.request(ApiUrls.updateNotification, RequestMethods.POST, showLogs: true, header: tokeWithHeader,requestBody: body);
      if(res != null){
        if(res["statuscode"] == 201) {
        }else{
          emit(state.copyWith(status:LoadStatus.failure));
        }
      }
    }
    catch(e){
      emit(state.copyWith(status:LoadStatus.failure));
      print("update notification exception $e");
    }
  }

}