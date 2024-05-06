import 'package:WarrantyBell/Constants/api_string.dart';

class User {
  String? userId;
  String? email;
  String? password;
  String? deviceType;
  String? name;
  String? displayName;
  String? firstName;
  String? lastName;
  String? deviceToken;
  int? mobile;
  String? loginType;
  String? authToken;
  String? profile;
  bool? notificationStatus;

  User({
    this.userId = '',
    this.email = '',
    this.password = '',
    this.deviceType = '',
    this.name = '',
    this.displayName = '',
    this.firstName = '',
    this.lastName = '',
    this.deviceToken = '',
    this.mobile = 0,
    this.loginType = '',
    this.authToken = '',
    this.profile,
    this.notificationStatus = false
  });

  User.fromJson(Map<String, dynamic> json) {
    userId = json[UserModelKeys.id].toString() ?? '';
    email = json[UserModelKeys.email] ?? '';
    password = json[UserModelKeys.password] ?? '';
    deviceType = json[UserModelKeys.deviceType] ?? '';
    name = json[UserModelKeys.name] ?? '';
    displayName = json[UserModelKeys.displayName] ?? '';
    firstName = json[UserModelKeys.firstName] ?? '';
    lastName = json[UserModelKeys.lastName] ?? '';
    deviceToken = json[UserModelKeys.deviceToken] ?? '';
    mobile = json[UserModelKeys.mobile] ?? 0;
    profile = json[UserModelKeys.profile] ?? '';
    loginType = json[UserModelKeys.loginType] ?? '';
    authToken = json[UserModelKeys.authToken] ?? '';
    notificationStatus = json[UserModelKeys.notificationStatus] ?? false;
  }

  User.fromSharedJson(Map<String, dynamic> json) {
    userId = json[UserModelKeys.id] ?? '';
    email = json[UserModelKeys.email] ?? '';
    password = json[UserModelKeys.password] ?? '';
    deviceType = json[UserModelKeys.deviceType] ?? '';
    name = json[UserModelKeys.name] ?? '';
    displayName = json[UserModelKeys.displayName] ?? '';
    firstName = json[UserModelKeys.firstName] ?? '';
    lastName = json[UserModelKeys.lastName] ?? '';
    deviceToken = json[UserModelKeys.deviceToken] ?? '';
    mobile = json[UserModelKeys.mobile] ?? 0;
    profile = json[UserModelKeys.profile] ?? '';
    loginType = json[UserModelKeys.loginType] ?? '';
    authToken = json[UserModelKeys.authToken] ?? '';
    notificationStatus = json[UserModelKeys.notificationStatus] ?? false;
  }

  Map<String, dynamic> toJson() {
    final json = <String,dynamic>{};
    json[UserModelKeys.id] = userId ?? '';
    json[UserModelKeys.email] = email ?? '';
    json[UserModelKeys.password] = password ?? '';
    json[UserModelKeys.deviceType] = deviceType ?? '';
    json[UserModelKeys.name] = name ?? '';
    json[UserModelKeys.displayName] = displayName ?? '';
    json[UserModelKeys.firstName] = firstName ?? '';
    json[UserModelKeys.lastName] = lastName ?? '';
    json[UserModelKeys.deviceToken] = deviceToken ?? '';
    json[UserModelKeys.mobile] = mobile ?? 0;
    json[UserModelKeys.loginType] = loginType ?? '';
    json[UserModelKeys.authToken] = authToken ?? '';
    json[UserModelKeys.profile] = profile ?? '';
    json[UserModelKeys.notificationStatus] = notificationStatus ?? false;
    return json;
  }

  Map<String, dynamic> toSharedJson() {
    final json = <String,dynamic>{};
    json[UserModelKeys.id] = userId ?? '';
    json[UserModelKeys.email] = email ?? '';
    json[UserModelKeys.password] = password ?? '';
    json[UserModelKeys.deviceType] = deviceType ?? '';
    json[UserModelKeys.name] = name ?? '';
    json[UserModelKeys.displayName] = displayName ?? '';
    json[UserModelKeys.firstName] = firstName ?? '';
    json[UserModelKeys.lastName] = lastName ?? '';
    json[UserModelKeys.deviceToken] = deviceToken ?? '';
    json[UserModelKeys.mobile] = mobile ?? 0;
    json[UserModelKeys.loginType] = loginType ?? '';
    json[UserModelKeys.authToken] = authToken ?? '';
    json[UserModelKeys.profile] = profile ?? '';
    json[UserModelKeys.notificationStatus] = notificationStatus ?? false;
    return json;
  }

  ///For login api request body
  Map<String, dynamic> toRequestLoginJson() {
    final json = <String,dynamic>{};
    json[UserModelKeys.email] = email ?? '';
    json[UserModelKeys.password] = password ?? '';
    json[UserModelKeys.deviceType] = deviceType ?? '';
    json[UserModelKeys.deviceToken] = deviceToken ?? '';
    json[UserModelKeys.loginType] = loginType ?? '';
    return json;
  }

  ///For register api request body
  Map<String, dynamic> toRequestRegisterJson() {
    final json = <String,dynamic>{};
    json[UserModelKeys.firstName] = firstName ?? '';
    json[UserModelKeys.lastName] = lastName ?? '';
    json[UserModelKeys.email] = email ?? '';
    json[UserModelKeys.password] = password ?? '';
    json[UserModelKeys.deviceType] = deviceType ?? '';
    json[UserModelKeys.mobile] = mobile.toString() ?? '';
    json[UserModelKeys.profile] = profile ?? '';
    json[UserModelKeys.deviceToken] = deviceToken ?? '';
    json[UserModelKeys.loginType] = loginType ?? '';
    return json;
  }
}