part of 'notification_schedule_bloc.dart';

class NotificationScheduleState {
  LoadStatus? status;
  bool? isStatus = false;
  List<NotificationScheduleModel>? notificationScheduleList = [];

  NotificationScheduleState({this.status = LoadStatus.initial,this.isStatus = false, this.notificationScheduleList});

  NotificationScheduleState copyWith({
    LoadStatus? status,
    bool? isStatus,
   List<NotificationScheduleModel>? notificationScheduleList

  }) {
    return NotificationScheduleState(
      status: status ?? this.status,
      isStatus: isStatus ?? this.isStatus,
      notificationScheduleList: notificationScheduleList ?? this.notificationScheduleList,
    );
  }
}