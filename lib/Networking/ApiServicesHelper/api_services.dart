import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:awesome_top_snackbar/awesome_top_snackbar.dart';
import 'package:WarrantyBell/Constants/api_string.dart';
import 'package:WarrantyBell/Constants/color_constants.dart';
import 'package:WarrantyBell/Networking/NetworkHelper/custom_exception.dart';
import 'package:WarrantyBell/Utils/Mixins/progress_indicator.dart';
import 'package:WarrantyBell/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as p;
import 'package:path/path.dart';

enum RequestMethods { GET, POST, PUT, DELETE, POSTFILE }

Map<String,String> commonHeader = {
  ApiServicesHeaderKEYs.accept: "application/json",
  ApiServicesHeaderKEYs.contentType: "application/json"
};

Map<String,String> commonHeaderWithToken = {
  ApiServicesHeaderKEYs.accept: "application/json",
  ApiServicesHeaderKEYs.contentType: "application/json",
  ApiServicesHeaderKEYs.authorization : "Bearer ${userData.authToken}"
};

Map<String,String> commonHeaderWithMultiPartFormData={
  // ApiServicesHeaderKEYs.authorization:"Bearer ",
  ApiServicesHeaderKEYs.contentType: "multipart/form-data",
};

class ApiService {
  static bool isHideProgress = false;
  static hideProgress(BuildContext context) {
    if (!isHideProgress) {
      Navigator.pop(context);
      isHideProgress = true;
    }
  }

  static Future<dynamic> request(String url, RequestMethods methods, { BuildContext? context,Map<String, String>? header, Map<String, dynamic>? requestBody,  bool showLogs = true, Color? loaderColor, XFile? postFiles,String? fileStringKey}) async {
    BuildContext contextApi = context ?? navState.currentContext!;
    
    try {
      if (showLogs) {
        log("---Request url: \n$url \nheader: $header \nbody: $requestBody");
      }
      var response = await apiCallMethod(url, methods, header: header ?? {}, requestBody: requestBody ?? {},postFiles: postFiles,fileStringKey:fileStringKey);
      var multiPartResponse = '';
      if (showLogs) {
        if(methods == RequestMethods.POSTFILE && response is http.StreamedResponse){
          /// listen for response
          multiPartResponse = await response.stream.bytesToString();
          var displayError = jsonDecode(multiPartResponse);
          return displayError;
        }else {
          log("---Response :  ${response?.body ?? {}} StatusCode: ${response?.statusCode ?? 0}");
        }
      }
  
      if (response != null && response is http.Response) {
        if (response.statusCode == 200 ||response.statusCode == 201 && response.body.isNotEmpty) {
          return jsonDecode(response.body);
        } else {
          if (response.statusCode == 404 || response.statusCode == 502) {
            log("---!! AuthenticationFailed !!---");
            var displayError = jsonDecode(response.body);
            // if(displayError[ApiValidationKEYs.data][ApiValidationKEYs.invalidEmail] != null){
            //   showAlertDialog(context!, Languages.of(context)!.commonStringTr.oops, Languages.of(NavigationService.navigatorKey.currentContext!)!.validationStringTr.validEmail, Languages.of(context)!.commonStringTr.ok);
            // }
            // else if(displayError[ApiValidationKEYs.data][ApiValidationKEYs.emailNotFound] != null){
            //   showAlertDialog(context!, Languages.of(context)!.commonStringTr.oops, Languages.of(NavigationService.navigatorKey.currentContext!)!.validationStringTr.emailNotExists, Languages.of(context)!.commonStringTr.ok, onTapOk: (){pushReplacement(context, WelcomeScreen());});
            // } else if(displayError[ApiValidationKEYs.data][ApiValidationKEYs.incorrectPassword] != null){
            //   showAlertDialog(context!, Languages.of(context)!.commonStringTr.oops, Languages.of(NavigationService.navigatorKey.currentContext!)!.validationStringTr.validPassword, Languages.of(context)!.commonStringTr.ok);
            // }else if (displayError[ApiValidationKEYs.data][ApiValidationKEYs.existingUserLogin] != null){
            //   showAlertDialog(context!, Languages.of(context)!.commonStringTr.oops, Languages.of(NavigationService.navigatorKey.currentContext!)!.validationStringTr.userAllReadyExists, Languages.of(context)!.commonStringTr.ok);
            // }else if (displayError[ApiValidationKEYs.data][ApiValidationKEYs.existingUserEmail] != null){
            //   showAlertDialog(context!, Languages.of(context)!.commonStringTr.oops, Languages.of(NavigationService.navigatorKey.currentContext!)!.validationStringTr.userEmailExists, Languages.of(context)!.commonStringTr.ok);
            // }else if (displayError[ApiValidationKEYs.data][ApiValidationKEYs.error] != null){
            //   showAlertDialog(context!, Languages.of(context)!.commonStringTr.oops, Languages.of(NavigationService.navigatorKey.currentContext!)!.validationStringTr.emailNotExists, Languages.of(context)!.commonStringTr.ok);
            // }else if (displayError[ApiValidationKEYs.data][ApiValidationKEYs.emailError] != null){
            //   showAlertDialog(context!, Languages.of(context)!.commonStringTr.oops, Languages.of(NavigationService.navigatorKey.currentContext!)!.validationStringTr.emailNotExists, Languages.of(context)!.commonStringTr.ok);
            // }else if (displayError[ApiValidationKEYs.data][ApiValidationKEYs.tokenError] != null){
            //   showAlertDialog(context!, Languages.of(context)!.commonStringTr.oops, Languages.of(NavigationService.navigatorKey.currentContext!)!.validationStringTr.invalidToken, Languages.of(context)!.commonStringTr.ok);
            // }
          } else if (response.statusCode == 500){
            log("---!! some thing went wrong status code is ${response.statusCode} !!---");
          }
          else {
            var error = responseCodeHandle(navState.currentContext!, response).toString();
            log("--- Error : $error");
            // showToast(contextApi, error, Toast.LENGTH_SHORT);
          }
          return null;
        }
      } else if(methods == RequestMethods.POSTFILE){
        return jsonDecode(multiPartResponse);
      }else{
        log("---!! somethingWentWrong !!---");
        // showToast(contextApi, apiString.somethingWentWrong, Toast.LENGTH_SHORT);
        return null;
      }
    } on SocketException catch (_) {
    
      // showToast(contextApi, apiString.mobileDataOff, Toast.LENGTH_SHORT);
    } catch (e) {
      if (showLogs) {
        log("---Error : $e");
      }
      
      return null;
    }
  }

  static dynamic responseCodeHandle(
      BuildContext context, http.Response response) {
    switch (response.statusCode) {
      case 400:
        throw BadRequestException(context, response.body.toString());
      case 401:
      case 404:
      case 403:
        throw UnauthorisedException(context, response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            context, 'Fetch data exception ${response.statusCode}');
    }
  }

  static Future<dynamic> apiCallMethod(String url, RequestMethods methods,
      {Map<String, String>? header, Map<String, dynamic>? requestBody, XFile? postFiles,String? fileStringKey }) async {
    if (methods == RequestMethods.GET) {
      return await http.get(Uri.parse(url), headers: header!);
    } else if (methods == RequestMethods.POST) {
      return await http.post(Uri.parse(url),
          headers: header!, body: jsonEncode(requestBody!));
    } else if (methods == RequestMethods.PUT) {
      return await http.put(Uri.parse(url),
          headers: header!, body: jsonEncode(requestBody!));
    } else if (methods == RequestMethods.DELETE) {
      return await http.delete(Uri.parse(url),
          headers: header!, body: jsonEncode(requestBody!));
    }
    else if (methods == RequestMethods.POSTFILE /*&& postFiles != null*/){
      var request = http.MultipartRequest("POST", Uri.parse(url));
      request.headers.addAll(header!);
      request.fields.addAll(requestBody!.map((key, value) => MapEntry(key, value.toString())));
      if(postFiles != null){
        final extension = p.extension(postFiles.path ?? "").replaceAll(".", "");
        request.files.add( await http.MultipartFile.fromPath("photo", postFiles.path,filename: basename(postFiles.path),contentType: MediaType("image", extension)));
      }
      return await request.send();
    }
    return null;
  }
}