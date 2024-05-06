part of 'login_bloc.dart';

class LoginState {
  LoadStatus? status;
  String? email;
  String? fName;
  String? lName;
  String? mobileNumber;
  String? password;
  String? message;
  bool? isObscureText;
  bool? isRemember;

  LoginState({this.status, this.message = '', this.isObscureText = true, this.password, this.email, this.isRemember = false, this.fName, this.lName, this.mobileNumber});

  LoginState copyWith({
    LoadStatus? status,
    String? email,
    String? password,
    String? message,
    bool? isObscureText,
    bool? isRemember,
  }) {
    return LoginState(
      status: status ?? this.status,
      message: message ?? this.message,
      isObscureText: isObscureText ?? this.isObscureText,
      isRemember:  isRemember ?? this.isRemember,
    );
  }
}