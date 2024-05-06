part of 'setting_bloc.dart';

class SettingState {
  LoadStatus? status;
  bool? isNotificationStatus = false;
  String? flag;

  SettingState({this.status = LoadStatus.initial, this.isNotificationStatus = false, this.flag = ''});

  SettingState copyWith({
    LoadStatus? status,
    bool? isNotificationStatus,
    String? flag
  }) {
    return SettingState(
      status: status ?? this.status,
        isNotificationStatus : isNotificationStatus ?? this.isNotificationStatus,
        flag : flag ?? this.flag
    );
  }
}
