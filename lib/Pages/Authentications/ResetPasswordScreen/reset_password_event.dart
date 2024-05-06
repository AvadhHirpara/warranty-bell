class ResetPasswordEvent {
  const ResetPasswordEvent();
  @override
  List<Object?> get props => [];
}

class ResetPasswordHideShowEvent extends ResetPasswordEvent {
  final bool isObscureText;
  const ResetPasswordHideShowEvent(this.isObscureText);
}

class ResetConfirmPasswordHideShowEvent extends ResetPasswordEvent {
  final bool isObscureConfirmPassword;
  const ResetConfirmPasswordHideShowEvent(this.isObscureConfirmPassword);
}

class ResetPasswordButtonEvent extends ResetPasswordEvent {
  String? password;
  String? confirmPassword;

  ResetPasswordButtonEvent({required this.password, required this.confirmPassword});

}