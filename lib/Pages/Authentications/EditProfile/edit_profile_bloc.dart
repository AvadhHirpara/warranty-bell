import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:WarrantyBell/Constants/api_string.dart';
import 'package:WarrantyBell/Constants/api_urls.dart';
import 'package:WarrantyBell/Controller/text_editing_controller.dart';
import 'package:WarrantyBell/Enums/loading_status.dart';
import 'package:WarrantyBell/Model/user_data_model.dart';
import 'package:WarrantyBell/Networking/ApiServicesHelper/api_services.dart';
import 'package:WarrantyBell/main.dart';
import 'package:image_picker/image_picker.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc() : super(EditProfileState()) {

    on<EditProfileEvent>((event, emit) {
        fName.text = userData.firstName!;
        lName.text = userData.lastName!;
        rEmail.text = userData.email!;
        mobileNumber.text = userData.mobile.toString();
    });
    on<SelectedImageEvent>(_onSelectedImageEvent);
    on<SubmitButtonEvent>(submitButtonTap);

  }

  FutureOr<void> submitButtonTap (SubmitButtonEvent event, Emitter<EditProfileState>emit){

    Map<String, dynamic> body ;
    if(state.profileImage == null){
      body = {
        "first_name" : fName.text,
        "last_name" : lName .text,
        "mobile" : mobileNumber.text,
        "photo" : ""
      };
    }else{
      body = {
        "first_name" : fName.text,
        "last_name" : lName .text,
        "mobile" : mobileNumber.text
      };
    }

    editProfile(body);

  }


  FutureOr<void> _onSelectedImageEvent(SelectedImageEvent event, Emitter<EditProfileState> emit) {
    emit(state.copyWith(profileImage: event.profileImage));
    print("profile path is ${event.profileImage}");
  }

  Future editProfile(Map<String, dynamic> body) async {
    String token = await sharedPref.read('token');
    Map<String,String> tokeWithHeader = {
      ApiServicesHeaderKEYs.accept: "application/json",
      ApiServicesHeaderKEYs.contentType: "application/json",
      ApiServicesHeaderKEYs.authorization : "Bearer $token"
    };
    emit(state.copyWith(status:LoadStatus.loading));
    try{
      var res = await ApiService.request(ApiUrls.updateProfile, RequestMethods.POSTFILE, showLogs: true,header: tokeWithHeader,requestBody: body,postFiles:state.profileImage);
      if(res != null){
        if(res[UserModelKeys.data] != null) {
          UserData userRes = UserData.fromJson(res[UserModelKeys.data]);
          userData.firstName = userRes.firstName;
          userData.lastName = userRes.lastName;
          userData.profile = userRes.profile;
          userData.displayName ="${userData.firstName ?? ''} ${userData.lastName ?? ''}";
          updateUserDataSharedPrefs(userData);
          emit(state.copyWith(status:LoadStatus.success,message:res["message"]));
        }else{
          emit(state.copyWith(status:LoadStatus.failure));
        }
      }
    }
    catch(e){
      emit(state.copyWith(status:LoadStatus.failure));
      print("add products exception $e");
    }
  }

}