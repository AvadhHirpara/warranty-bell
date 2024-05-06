part of 'otp_verify_bloc.dart';

class OtpVerifyEvent {
  const OtpVerifyEvent();
  @override
  List<Object?> get props => [];
}

class VerifyOtpEvent extends OtpVerifyEvent{
  final String? email;
  final String? otp;

  VerifyOtpEvent({required this.email, this .otp});

}

class ResendOtpEvent extends OtpVerifyEvent{
  final String? email;

  ResendOtpEvent({ this.email});
}
