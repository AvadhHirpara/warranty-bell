import 'dart:developer';
import 'package:WarrantyBell/Constants/api_string.dart';
import 'package:WarrantyBell/Constants/color_constants.dart';
import 'package:WarrantyBell/Model/user_data_model.dart';
import 'package:WarrantyBell/Networking/FirebaseNotificationHelper/firebase_notification.dart';
import 'package:WarrantyBell/Repository/shared_pref.dart';
import 'package:WarrantyBell/Utils/life_cycle_handler.dart';
import 'package:WarrantyBell/Utils/routes.dart';
import 'package:WarrantyBell/utils/cubit/ConnectionCheckerCubit.dart';
import 'package:WarrantyBell/utils/cubit/internet_cubit.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';

final sl = GetIt.instance;
final GlobalKey<NavigatorState> navState = GlobalKey<NavigatorState>();
final FirebaseMessaging fcm = FirebaseMessaging.instance;


@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

SharedPref sharedPref = SharedPref();
User userData = User();

loadUserDataSharedPrefs() async {
  var data = await sharedPref.read(UserDefault.user);
  User user = data != null ? User.fromSharedJson(data) : User();
  userData = user;
}

updateUserDataSharedPrefs(User user) {
  sharedPref.save(UserDefault.user, user.toSharedJson());
  loadUserDataSharedPrefs();
}

Future<void> main(main) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await ScreenUtil.ensureScreenSize();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
  Bloc.observer = AppBlocObserver();
  userData.deviceToken = (await fcm.getToken());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {

  NotificationService notificationService = NotificationService();

    @override
  void initState() {
      loadUserDataSharedPrefs();
      notificationService.requestNotificationPermission();
      notificationService.initLocalNotifications();
      notificationService.firebaseInit();
      WidgetsBinding.instance.addObserver(LifecycleEventHandler());
      super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(LifecycleEventHandler());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: AppBackGroundColor.grey,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MultiBlocProvider(
      providers: [
        BlocProvider<ConnectionCheckerCubit>(
          create: (_) => ConnectionCheckerCubit(
              internetConnectionChecker: InternetConnectionChecker()),
        ),
        BlocProvider<InternetCubit>(
          create: (context) => InternetCubit(connectivity: Connectivity()),
        ),
      ],
      child: ScreenUtilInit(
        builder: (BuildContext context, child1) => MaterialApp(
          theme: ThemeData(
              primaryColor: AppBackGroundColor.blue,
              pageTransitionsTheme: const PageTransitionsTheme(builders: {
                TargetPlatform.android: CupertinoPageTransitionsBuilder(),
                TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
              })),
          debugShowCheckedModeBanner: false,
          navigatorKey: navState,
          themeMode: ThemeMode.light,
          title: "Expiry",
          initialRoute:splashScreen,
          onGenerateRoute: Routes.onGenerateRoute,
          scrollBehavior:
          const ScrollBehavior().copyWith(scrollbars: false),
          // builder: (context, widget) {
          //   final connectionState =
          //       context.watch<ConnectionCheckerCubit>().state;
          //   widget = WrapScreenUtils(child: widget ?? const Offstage());
          //   widget = EasyLoading.init()(context, widget);
          //   return widget;
          // },
        ),
      ),
    );
  }
}

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);

    // if (change.nextState is InternetConnectionDisconnected) {
    //   awesomeTopSnackbar(navState.currentContext!, "Internet Connection Lost");
    // } else if (change.nextState is InternetConnectionConnected) {
    //   showSuccessSnackBar(navState.currentContext!, "Internet Connection Connected");
    // }

    log('onChange: ${bloc.runtimeType}, ${bloc.state} \nCurrent state: ${change.currentState}\nNext state: ${change.nextState}');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, ${bloc.state}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    log('onEvent(${bloc.state}, ${bloc.runtimeType}, $event)');
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    log('onTransition(${bloc.state}, ${bloc.runtimeType}, ${transition.currentState}, ${transition.nextState})');
    super.onTransition(bloc, transition);
  }

  @override
  void onCreate(BlocBase bloc) {
    log('onCreate(${bloc.state}, ${bloc.runtimeType})');
    super.onCreate(bloc);
  }

  @override
  void onClose(BlocBase bloc) {
    log('onTransition(${bloc.state}, ${bloc.runtimeType})');
    super.onClose(bloc);
  }
}
