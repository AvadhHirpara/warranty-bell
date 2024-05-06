part of 'otp_verify_bloc.dart';


class OtpVerifyState {
  LoadStatus? status;
  String? email;
  String? message;
  String? otp;
  String? flag;

  OtpVerifyState({this.status = LoadStatus.initial, this.email, this.message = '', this.otp = '',this.flag});

  OtpVerifyState copyWith({
    LoadStatus? status,
    String? email,
    String? message,
    String? otp,
    String? flag
  }) {
    return OtpVerifyState(
        status: status ?? this.status,
        email: email ?? this.email,
        message: message ?? this.message,
        otp: otp ?? this.otp,
        flag: flag ?? this.flag
    );
  }
}
