part of 'edit_profile_bloc.dart';

class EditProfileEvent {}

class EditProfileInitialEvent extends EditProfileEvent{}


class SubmitButtonEvent extends EditProfileEvent{
  final String? email;
  final String? mobileNumber;
  final String? message;
  final String? fName;
  final String? lName;
  SubmitButtonEvent({this.message,this.email,this.fName,this.lName,this.mobileNumber});
}

class SelectedImageEvent extends EditProfileEvent {
  final XFile profileImage;
  SelectedImageEvent(this.profileImage);
}