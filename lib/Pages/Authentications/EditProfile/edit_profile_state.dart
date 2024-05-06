part of 'edit_profile_bloc.dart';

class EditProfileState {
  LoadStatus? status;
  String? email;
  String? fName;
  String? lName;
  String? mobileNumber;
  String? message;
  XFile? profileImage;

  EditProfileState({this.status, this.message = '',  this.email, this.fName, this.lName, this.mobileNumber,this.profileImage});

  EditProfileState copyWith({
    LoadStatus? status,
    String? email,
    String? fName,
    String? lName,
    String? message,
    String? mobileNumber,
    XFile? profileImage
  }) {
    return EditProfileState(
      status: status ?? this.status,
      message: message ?? this.message,
      email:  email ?? this.email,
      fName:  fName ?? this.fName,
      lName: lName ?? this.lName,
      mobileNumber: mobileNumber ?? this.mobileNumber,
        profileImage: profileImage ?? this.profileImage
    );
  }

  @override
  List<Object?> get props => [status,message,mobileNumber,fName,lName,email,profileImage];
}

