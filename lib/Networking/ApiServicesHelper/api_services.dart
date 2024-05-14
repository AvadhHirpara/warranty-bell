import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:WarrantyBell/Model/user_data_model.dart';
import 'package:WarrantyBell/Pages/HomeScreen/home_bloc.dart';
import 'package:WarrantyBell/Style/text_style.dart';
import 'package:WarrantyBell/Utils/routes.dart';
import 'package:awesome_top_snackbar/awesome_top_snackbar.dart';
import 'package:WarrantyBell/Constants/api_string.dart';
import 'package:WarrantyBell/Constants/color_constants.dart';
import 'package:WarrantyBell/Networking/NetworkHelper/custom_exception.dart';
import 'package:WarrantyBell/Utils/Mixins/progress_indicator.dart';
import 'package:WarrantyBell/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          var decode = jsonDecode(response.body);
          if(decode["statuscode"] == 401){
            ScaffoldMessenger.of(contextApi).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: AppBackGroundColor.blue,
                  content: Text(decode["message"],style: TextStyleTheme.customTextStyle(AppTextColor.white, 16, FontWeight.w500),),
                )
            );
            userData = UserData();
            userData.authToken = null;
            sharedPref.removeAll();
              Navigator.pushNamed(contextApi, login);
          }else{
            return jsonDecode(response.body);
          }
        } else {
          if (response.statusCode == 404 || response.statusCode == 401) {
            log("---!! AuthenticationFailed !!---");
            var displayError = jsonDecode(response.body);
          } else if (response.statusCode == 500){
            log("---!! some thing went wrong status code is ${response.statusCode} !!---");
          }
          else {
            var error = responseCodeHandle(navState.currentContext!, response).toString();
            log("--- Error : $error");
          }
          return null;
        }
      } else if(methods == RequestMethods.POSTFILE){
        return jsonDecode(multiPartResponse);
      }else{
        log("---!! somethingWentWrong !!---");
        return null;
      }
    } on SocketException catch (_) {
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