part of 'setting_bloc.dart';

class SettingEvent {}

class SettingInitialEvent extends SettingEvent{
  bool? isNotificationStatus = false;
  SettingInitialEvent({this.isNotificationStatus = false});
}

class ChangeNotificationStatusEvent extends SettingEvent{
  bool? isNotificationStatus = false;
  ChangeNotificationStatusEvent({this.isNotificationStatus = false});
}

class DeleteAccountEvent extends SettingEvent{}
