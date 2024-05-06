import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:WarrantyBell/Constants/api_string.dart';
import 'package:WarrantyBell/Constants/api_urls.dart';
import 'package:WarrantyBell/Enums/loading_status.dart';
import 'package:WarrantyBell/Model/notification_schedule_model.dart';
import 'package:WarrantyBell/Networking/ApiServicesHelper/api_services.dart';
import 'package:WarrantyBell/main.dart';

part 'notification_schedule_event.dart';
part 'notification_schedule_state.dart';

class NotificationScheduleBloc extends Bloc<NotificationScheduleEvent, NotificationScheduleState> {
   List<NotificationScheduleModel> notificationScheduleList = [];
  NotificationScheduleBloc() : super(NotificationScheduleState()) {

    on<NotificationInitialEvent>((event, emit){
      getNotificationSchedule();
    });

    on<ChangeNotificationStatusEvent>((event, emit) => changeNotificationStatus(event, emit));
  }

  FutureOr<void> changeNotificationStatus (ChangeNotificationStatusEvent event, Emitter<NotificationScheduleState>emit){
    emit(state.copyWith(status : LoadStatus.initial,isStatus: event.notificationScheduleModel?.status));
    Map<String, dynamic> body = {
      "id" : event.notificationScheduleModel?.sId,
      "status" : event.isStatus
    };
    updateNotificationSchedule(body,event);
  }

  ///GetNotificationSchedule
  Future getNotificationSchedule() async {
    String token = await sharedPref.read('token');
    Map<String,String> tokeWithHeader = {
      ApiServicesHeaderKEYs.accept: "application/json",
      ApiServicesHeaderKEYs.contentType: "application/json",
      ApiServicesHeaderKEYs.authorization : "Bearer $token"
    };
    emit(state.copyWith(status:LoadStatus.loading));
    try{
      notificationScheduleList.clear();
      var res = await ApiService.request(ApiUrls.notificationSchedule, RequestMethods.GET, showLogs: true,header: tokeWithHeader);
      if(res != null){
        if(res[UserModelKeys.data] != null && res[UserModelKeys.data] is List) {
          for (var element in (res[UserModelKeys.data])) {
            NotificationScheduleModel notificationScheduleModel = NotificationScheduleModel.fromJson(element ?? {});
            notificationScheduleList.add(notificationScheduleModel);
          }
          emit(state.copyWith(status:LoadStatus.success,notificationScheduleList: notificationScheduleList,));
        }else{
          emit(state.copyWith(status:LoadStatus.failure));
        }
      }
    }
    catch(e){
      emit(state.copyWith(status:LoadStatus.failure));
      print("notification schedule exception $e");
    }
  }

  ///UpdateNotificationSchedule
   Future updateNotificationSchedule(Map<String, dynamic> body,ChangeNotificationStatusEvent event) async {
     //emit(state.copyWith(status:LoadStatus.loading));
     String token = await sharedPref.read('token');
     Map<String,String> tokeWithHeader = {
       ApiServicesHeaderKEYs.accept: "application/json",
       ApiServicesHeaderKEYs.contentType: "application/json",
       ApiServicesHeaderKEYs.authorization : "Bearer $token"
     };
     try{
       var res = await ApiService.request(ApiUrls.updateNotificationSchedule, RequestMethods.POST, showLogs: true,header: tokeWithHeader,requestBody: body);
       if(res != null){
         if(res["statuscode"] == 201) {
           notificationScheduleList.clear();
           getNotificationSchedule();
         }else{
           emit(state.copyWith(status:LoadStatus.failure));
         }
       }
     }
     catch(e){
       emit(state.copyWith(status:LoadStatus.failure));
       print("notification schedule exception $e");
     }
   }

}
