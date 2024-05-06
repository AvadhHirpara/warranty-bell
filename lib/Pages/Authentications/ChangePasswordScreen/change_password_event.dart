part of 'change_password_bloc.dart';

class ChangePasswordEvent {
  const ChangePasswordEvent();
  @override
  List<Object?> get props => [];
}

class ChangePasswordHideShowEvent extends ChangePasswordEvent {
  final bool isObscureText;
  const ChangePasswordHideShowEvent(this.isObscureText);
}

class ChangeConfirmPasswordHideShowEvent extends ChangePasswordEvent {
  final bool isObscureConfirmPassword;
  const ChangeConfirmPasswordHideShowEvent(this.isObscureConfirmPassword);
}

class ChangePasswordButtonEvent extends ChangePasswordEvent {
  String? password;
  String? confirmPassword;

  ChangePasswordButtonEvent({required this.password, required this.confirmPassword});

}