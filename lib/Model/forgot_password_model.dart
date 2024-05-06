import 'package:WarrantyBell/Constants/api_string.dart';

class ForgotPasswordModel {
  bool? success;
  String? message;

  ForgotPasswordModel({this.success, this.message});

  ForgotPasswordModel.fromJson(Map<String, dynamic> json) {
    success = json[CommonApiResponseKeys.success];
    message = json[CommonApiResponseKeys.message];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data[CommonApiResponseKeys.success] = success;
    data[CommonApiResponseKeys.message] = message;
    return data;
  }
}