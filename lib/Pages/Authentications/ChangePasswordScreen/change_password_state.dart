part of 'change_password_bloc.dart';


class ChangePasswordState {
  LoadStatus? status;
  String? password;
  String? message;
  String? confirmPassword;
  bool? isObscureText;
  bool? isObscureConfirmPassword;

  ChangePasswordState({this.status = LoadStatus.initial, this.message = '', this.isObscureText = true, this.password, this.isObscureConfirmPassword = true,this.confirmPassword});

  ChangePasswordState copyWith({
    LoadStatus? status,
    String? password,
    String? message,
    bool? isObscureText,
    bool? isObscureConfirmPassword,
    String? confirmPassword
  }) {
    return ChangePasswordState(
        status: status ?? this.status,
        message: message ?? this.message,
        isObscureText: isObscureText ?? this.isObscureText,
        isObscureConfirmPassword:  isObscureConfirmPassword ?? this.isObscureConfirmPassword,
        confirmPassword: confirmPassword ?? this.confirmPassword
    );
  }
}

