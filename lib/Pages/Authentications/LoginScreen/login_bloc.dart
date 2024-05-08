import 'dart:async';
import 'dart:io';
import 'package:WarrantyBell/Constants/api_string.dart';
import 'package:WarrantyBell/Constants/api_urls.dart';
import 'package:WarrantyBell/Controller/text_editing_controller.dart';
import 'package:WarrantyBell/Enums/loading_status.dart';
import 'package:WarrantyBell/Model/user_data_model.dart';
import 'package:WarrantyBell/Networking/ApiServicesHelper/api_services.dart';
import 'package:WarrantyBell/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
part 'login_event.dart';
part 'login_state.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn();

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {
    on<LoginPasswordHideShowEvent>((event, emit) => showHidePass(event, emit));
    on<CheckRememberEvent>((event, emit) => isCheckRemember(event, emit));
    on<LoginButtonEvent>((event, emit) => loginButtonTap(event, emit));
    on<GoogleLoginEvent>((event, emit) => googleLogin(event, emit));
  }

  FutureOr<void> showHidePass(LoginPasswordHideShowEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(status: LoadStatus.initial, isObscureText: event.isObscureText));
  }

  FutureOr<void> isCheckRemember (CheckRememberEvent event, Emitter<LoginState>emit){
  emit(state.copyWith(status: LoadStatus.initial,isRemember: event.isRemember));
  }

  FutureOr<void> googleLogin(GoogleLoginEvent event, Emitter<LoginState>emit) async {
     _googleSignIn.disconnect();
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        emit(state.copyWith(status: LoadStatus.initial));
        print("credential social login is ${credential.toString()}");
        print("google user data is ${googleUser.toString()}");
      }
    } catch (error) {
      print(error);
    }
  }


  FutureOr<void> loginButtonTap (LoginButtonEvent event, Emitter<LoginState>emit){
    Map<String, dynamic> body = {
      "email" : email.text,
      "password" : loginPassword.text,
      "login_type" : Platform.operatingSystem,
      "device_type" : LoginTypeDefault.defaultLogin,
      "device_token" :  userData.deviceToken
    };

    signInWithEmailPassword(body);
  }

  Future signInWithEmailPassword(Map<String,dynamic> body) async {
    emit(state.copyWith(status:LoadStatus.loading));
    try{
      var res = await ApiService.request(ApiUrls.login, RequestMethods.POST, showLogs: true,header: commonHeader,requestBody: body);
      if(res != null){
        if(res[UserModelKeys.data] != null) {
          UserData userRes = UserData.fromJson(res[UserModelKeys.data]);
          sharedPref.save("token", userRes.authToken);
          userData.authToken = userRes.authToken;
          userData.userId = userRes.userId;
          userData.firstName = userRes.firstName;
          userData.lastName = userRes.lastName;
          userData.displayName ="${userData.firstName ?? ''} ${userData.lastName ?? ''}";
          userData.mobile = userRes.mobile;
          userData.profile = userRes.profile;
          userData.notificationStatus = userRes.notificationStatus;
          updateUserDataSharedPrefs(userData);
          emit(state.copyWith(status:LoadStatus.success,message: res['message']));
        }else{
          emit(state.copyWith(status:LoadStatus.failure,message: res['message']));
        }
      }
    }
    catch(e){
      emit(state.copyWith(status:LoadStatus.failure));
      print("signin email exception $e");
    }
  }

}