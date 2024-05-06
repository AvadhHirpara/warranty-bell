part of 'notification_schedule_bloc.dart';

class NotificationScheduleEvent {}

class NotificationInitialEvent extends NotificationScheduleEvent{}

class ChangeNotificationStatusEvent extends NotificationScheduleEvent{
   NotificationScheduleModel? notificationScheduleModel;
   bool? isStatus = false;
   ChangeNotificationStatusEvent({this.notificationScheduleModel, this.isStatus = false});
}