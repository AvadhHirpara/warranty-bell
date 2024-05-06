part of 'notification_bloc.dart';

class NotificationState {
  LoadStatus? status;
  String? flag;
  List<NotificationModel>? notifications = [];


  NotificationState({this.status = LoadStatus.initial,this.flag, this.notifications});

  NotificationState copyWith({
    LoadStatus? status,
    String? flag,
    List<NotificationModel>? notifications
  }) {
    return NotificationState(
      status: status ?? this.status,
      flag: flag ?? this.flag,
      notifications : notifications ?? this.notifications
    );
  }

  @override
  List<Object?> get props => [
    status,
    flag,
    notifications
  ];

}