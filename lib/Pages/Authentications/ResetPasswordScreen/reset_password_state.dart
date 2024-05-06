part of 'reset_password_bloc.dart';

class ResetPasswordState {
  LoadStatus? status;
  String? password;
  String? message;
  String? confirmPassword;
  bool? isObscureText;
  bool? isObscureConfirmPassword;

  ResetPasswordState({this.status = LoadStatus.initial, this.message = '', this.isObscureText = true, this.password, this.isObscureConfirmPassword = true,this.confirmPassword});

  ResetPasswordState copyWith({
    LoadStatus? status,
    String? password,
    String? message,
    bool? isObscureText,
    bool? isObscureConfirmPassword,
    String? confirmPassword
  }) {
    return ResetPasswordState(
        status: status ?? this.status,
        message: message ?? this.message,
        isObscureText: isObscureText ?? this.isObscureText,
        isObscureConfirmPassword:  isObscureConfirmPassword ?? this.isObscureConfirmPassword,
        confirmPassword: confirmPassword ?? this.confirmPassword
    );
  }
}

