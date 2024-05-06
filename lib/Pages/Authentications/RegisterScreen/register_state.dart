import 'package:WarrantyBell/Enums/loading_status.dart';
import 'package:image_picker/image_picker.dart';

class RegisterState {
  LoadStatus? status;
  String? firstName;
  String? lastName;
  String? mobileNo;
  String? email;
  String? password;
  String? message;
  bool? isObscureText;
  bool? isTerms;
  XFile? imageFile;

  RegisterState({this.status = LoadStatus.initial, this.message = '', this.isObscureText = true, this.password, this.email, this.isTerms = false,this.imageFile,this.firstName,this.lastName,this.mobileNo});

  RegisterState copyWith({
    LoadStatus? status,
    String? email,
    String? password,
    String? message,
    bool? isObscureText,
    bool? isTerms,
    XFile? imageFile,
    String? firstName,
    String? lastName,
    String? mobileNo
  }) {
    return RegisterState(
        status: status ?? this.status,
        message: message ?? this.message,
        isObscureText: isObscureText ?? this.isObscureText,
        isTerms:  isTerms ?? this.isTerms,
      imageFile: imageFile ?? this.imageFile,
      firstName: firstName ??  this.firstName,
      lastName: lastName ??  this.lastName,
      mobileNo: mobileNo ??  this.mobileNo,
    );
  }
}