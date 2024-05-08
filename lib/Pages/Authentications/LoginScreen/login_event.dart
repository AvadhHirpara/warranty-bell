part of 'login_bloc.dart';

class LoginEvent {
  const LoginEvent();
  @override
  List<Object?> get props => [];
}

class LoginPasswordHideShowEvent extends LoginEvent {
  bool? isObscureText = false;
  LoginPasswordHideShowEvent({this.isObscureText = false});
}

class CheckRememberEvent extends LoginEvent{
  final bool isRemember;
  const CheckRememberEvent(this.isRemember);
}

class ValidateValueEvent extends LoginEvent {
  final String? email;
  final String? password;
  const ValidateValueEvent(this.email, this.password);
}

class GoogleLoginEvent extends LoginEvent{

}

class LoginButtonEvent extends LoginEvent{
  final String? email;
  final String? password;
  final String? message;
      LoginButtonEvent({this.email, this.password,this.message});
}