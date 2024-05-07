import 'package:WarrantyBell/Pages/AddProductScreen/add_product_bloc.dart';
import 'package:WarrantyBell/Pages/AddProductScreen/add_product_view.dart';
import 'package:WarrantyBell/Pages/AllCategoryScreen/all_category_bloc.dart';
import 'package:WarrantyBell/Pages/AllCategoryScreen/all_category_view.dart';
import 'package:WarrantyBell/Pages/Authentications/ChangePasswordScreen/change_password_bloc.dart';
import 'package:WarrantyBell/Pages/Authentications/ChangePasswordScreen/change_password_view.dart';
import 'package:WarrantyBell/Pages/Authentications/EditProfile/edit_profile_bloc.dart';
import 'package:WarrantyBell/Pages/Authentications/EditProfile/edit_profile_view.dart';
import 'package:WarrantyBell/Pages/Authentications/LoginScreen/login_bloc.dart';
import 'package:WarrantyBell/Pages/Authentications/LoginScreen/login_view.dart';
import 'package:WarrantyBell/Pages/Authentications/RegisterScreen/register_bloc.dart';
import 'package:WarrantyBell/Pages/Authentications/RegisterScreen/register_view.dart';
import 'package:WarrantyBell/Pages/Authentications/ForgotPasswordScreen/forgot_password_bloc.dart';
import 'package:WarrantyBell/Pages/Authentications/ForgotPasswordScreen/forgot_password_view.dart';
import 'package:WarrantyBell/Pages/Authentications/OtpVerifyScreen/otp_verify_bloc.dart';
import 'package:WarrantyBell/Pages/Authentications/OtpVerifyScreen/otp_verify_view.dart';
import 'package:WarrantyBell/Pages/Authentications/ResetPasswordScreen/reset_password_bloc.dart';
import 'package:WarrantyBell/Pages/Authentications/ResetPasswordScreen/reset_password_view.dart';
import 'package:WarrantyBell/Pages/HomeScreen/CategoryProductScreen/category_product_bloc.dart';
import 'package:WarrantyBell/Pages/HomeScreen/CategoryProductScreen/category_product_view.dart';
import 'package:WarrantyBell/Pages/HomeScreen/home_bloc.dart';
import 'package:WarrantyBell/Pages/HomeScreen/home_view.dart';
import 'package:WarrantyBell/Pages/NotificationScheduleScreen/notification_schedule_bloc.dart';
import 'package:WarrantyBell/Pages/NotificationScheduleScreen/notification_schedule_view.dart';
import 'package:WarrantyBell/Pages/NotificationScreen/notification_bloc.dart';
import 'package:WarrantyBell/Pages/NotificationScreen/notification_view.dart';
import 'package:WarrantyBell/Pages/ProductHistory/product_history_bloc.dart';
import 'package:WarrantyBell/Pages/ProductHistory/product_history_view.dart';
import 'package:WarrantyBell/Pages/SettingScreen/PrivacyPolicyScreen/privacy_policy_bloc.dart';
import 'package:WarrantyBell/Pages/SettingScreen/PrivacyPolicyScreen/privacy_policy_view.dart';
import 'package:WarrantyBell/Pages/SettingScreen/TermsAndConditionScreen/terms_condition_bloc.dart';
import 'package:WarrantyBell/Pages/SettingScreen/TermsAndConditionScreen/terms_condition_view.dart';
import 'package:WarrantyBell/Pages/SettingScreen/setting_bloc.dart';
import 'package:WarrantyBell/Pages/SettingScreen/setting_view.dart';
import 'package:WarrantyBell/Pages/SplaseScreen/splace_screen_view.dart';
import 'package:WarrantyBell/Pages/SplaseScreen/splacescreen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const login = "/login";
const register = "/register";
const forgotPassword = "/forgotPassword";
const otpVerify = "/otpVerify";
const resetPassword = "/resetPassword";
const homeScreen = "/home";
const addProductScreen = "/addProductScreen";
const settingScreen = "/settingScreen";
const notificationScheduleScreen = "/notificationSchedule";
const notificationScreen = "/notification";
const allCategoryScreen = "/allCategory";
const editProfileScreen = "/editProfile";
const splashScreen = "/splash";
const changePassword = "/changePassword";
const categoryProduct = "/categoryProduct";
const productHistory = "/productHistory";
const privacyScreen = "/privacy";
const termsScreen = "/terms";

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (create) => LoginBloc(),
              child: const LoginScreen(),
            ));
      case register:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (create) => RegisterBloc(),
              child: const RegisterScreen(),
            ));
      case forgotPassword:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (create) => ForgotPasswordBloc(),
              child: const ForgotPasswordScreen(),
            ));
      case resetPassword:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (create) => ResetPasswordBloc(),
              child: const ResetPasswordScreen(),
            ));
      case otpVerify:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (create) => OtpVerifyBloc(),
              child: const OtpVerifyScreen(),
            ));
      case homeScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (create) => HomeBloc(),
              child: const HomeScreen(),
            ));
      case addProductScreen:
        final arg = settings.arguments as Map<dynamic, dynamic>?;
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (create) => AddProductBloc()..add(AddProductInitialEvent(productModel: arg?['productModel'],isEdit: arg?['isEdit'],isNotification: arg?["isNotification"],notificationModel: arg?["notificationModel"])),
              child: const AddProductScreen(),
            ));
      case settingScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (create) => SettingBloc()..add(SettingInitialEvent()),
              child: const SettingScreen(),
            ));
      case notificationScheduleScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (create) => NotificationScheduleBloc(),
              child: const NotificationScheduleScreen(),
            ));
      case notificationScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (create) => NotificationBloc(),
              child: const NotificationScreen(),
            ));
      case allCategoryScreen:
        return MaterialPageRoute(
          settings: settings,
            builder: (context) => BlocProvider(
              create: (create) => AllCategoryBloc(),
              child: const AllCategoryScreen(),
            ));
      case editProfileScreen:
        return MaterialPageRoute(
            settings: settings,
            builder: (context) => BlocProvider(
              create: (create) => EditProfileBloc()..add(EditProfileEvent()),
              child: const EditProfileScreen(),
            ));
      case splashScreen:
        return MaterialPageRoute(
            settings: settings,
            builder: (context) => BlocProvider(
              create: (create) => SplacescreenBloc(),
              child: const SplashScreen(),
            ));
      case changePassword:
        return MaterialPageRoute(
            settings: settings,
            builder: (context) => BlocProvider(
              create: (create) => ChangePasswordBloc(),
              child: const ChangePasswordScreen(),
            ));
      case categoryProduct:
        final arg = settings.arguments as Map<dynamic, dynamic>?;
        return MaterialPageRoute(
            settings: settings,
            builder: (context) => BlocProvider(
              create: (create) => CategoryProductBloc()..add(CategoryProductInitialEvent(categoryId: arg?['categoryId'])),
              child: const CategoryProductScreen(),
            ));
      case productHistory:
        return MaterialPageRoute(
            settings: settings,
            builder: (context) => BlocProvider(
              create: (create) => ProductHistoryBloc(),
              child: const ProductHistoryScreen(),
            ));
      case privacyScreen:
        return MaterialPageRoute(
            settings: settings,
            builder: (context) => BlocProvider(
              create: (create) => PrivacyPolicyBloc(),
              child: const PrivacyPolicyScreen(),
            ));
      case termsScreen:
        return MaterialPageRoute(
            settings: settings,
            builder: (context) => BlocProvider(
              create: (create) => TermsConditionBloc(),
              child: const TermsAndConditionScreen(),
            ));
    }
  }
}