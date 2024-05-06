part of 'notification_bloc.dart';

class NotificationEvent {}

class NotificationInitialEvent extends NotificationEvent{}

class DeleteNotificationEvent extends NotificationEvent{
  NotificationModel? notificationModel;
  DeleteNotificationEvent({this.notificationModel});
}

class UpdateNotificationEvent extends NotificationEvent{
  NotificationModel? notificationModel;
  UpdateNotificationEvent({this.notificationModel});
}