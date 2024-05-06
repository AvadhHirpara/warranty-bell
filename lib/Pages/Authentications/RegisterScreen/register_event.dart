import 'package:image_picker/image_picker.dart';

class RegisterEvent {
  const RegisterEvent();
  @override
  List<Object?> get props => [];
}

class RegisterPasswordHideShowEvent extends RegisterEvent {
  final bool isObscureText;
  const RegisterPasswordHideShowEvent(this.isObscureText);
}

class CheckTermsEvent extends RegisterEvent{
  final bool isTerms;
  const CheckTermsEvent(this.isTerms);
}

class RegisterButtonEvent extends RegisterEvent{
  final String? email;
  final String? password;
  final String? message;
  final String? fName;
  final String? lName;
  final String? mobile;
  final XFile? imageFile;
  RegisterButtonEvent({this.email,this.password, this.lName,this.fName,this.message,this.mobile,this.imageFile});
}

class SelectedImageEvent extends RegisterEvent {
  final XFile imageFile;

  SelectedImageEvent(this.imageFile);
}