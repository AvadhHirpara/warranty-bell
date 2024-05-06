part of 'forgot_password_bloc.dart';

class ForgotPasswordEvent {
  const ForgotPasswordEvent();
  @override
  List<Object?> get props => [];
}

class ForgotButtonEvent extends ForgotPasswordEvent{
  final String? email;

  ForgotButtonEvent({required this.email});

}
