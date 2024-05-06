part of 'forgot_password_bloc.dart';


class ForgotPasswordState {
  LoadStatus? status;
  String? email;
  String? message;

  ForgotPasswordState({this.status = LoadStatus.initial, this.email, this.message = ''});

  ForgotPasswordState copyWith({
    LoadStatus? status,
    String? email,
    String? message
  }) {
    return ForgotPasswordState(
        status: status ?? this.status,
        email: email ?? this.email,
      message: message ?? this.message
    );
  }
}
