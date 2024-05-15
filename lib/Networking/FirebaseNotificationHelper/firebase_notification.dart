import 'dart:convert';
import 'dart:io';

import 'package:WarrantyBell/widgets/custom_app_bar.dart';
import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class GlobalVariable{
  bool isNotificationArrive = false;
}

 updateGlobalVariable() {
   globalVariable.isNotificationArrive = true;
}

class NotificationService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  void requestNotificationPermission() async {
    print("✅ user permission");
    NotificationSettings settings = await messaging.requestPermission(alert: true, announcement: true, badge: true,  sound: true);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("✅ user grant permission");
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print("✅ user grant provisional permission");
    } else {
      print("❎ user denied permission");
      AppSettings.openAppSettings();
    }
  }

  void initLocalNotifications() async {
    /*FirebaseMessaging.instance.deleteToken().then((value) {

    });*/
    String token = await messaging.getToken() ?? "";
    print("Token========== $token");
    messaging.onTokenRefresh.listen((event) {
      print("object========== $event");
    });
    // SharePref().saveToken(token);

    var androidInitializationSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSettings = const DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      defaultPresentSound: true,
      defaultPresentAlert: true,
      defaultPresentBadge: true,
      defaultPresentBanner: true,
      defaultPresentList: true,);

    var initializationSettings = InitializationSettings(android: androidInitializationSettings, iOS: iosInitializationSettings);

    try {
      await _flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: (payload) async {
          print("object======= onDidReceiveNotificationResponse");
          // print("😍 ==> goto next s ${jsonDecode(payload.payload.toString())}");
          handleNotification(jsonDecode(payload.payload!), AppState.background);
        },
        onDidReceiveBackgroundNotificationResponse: (payload) async {
          print("object======= onDidReceiveBackgroundNotificationResponse");
          print("😍 ==> goto next ${jsonDecode(payload.payload.toString())}");
          // handleNotification(jsonDecode(payload.payload.toString()), AppState.terminated);
        },
      );
    } catch (e) {
      print("😢 ==> goto next s exception ${e.toString()}");
    }

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
  }

  void firebaseInit() {
    FirebaseMessaging.onMessage.listen((message) {
      print("Notification Is In onMessage ${message.toString()}");
      updateGlobalVariable();
      print("globle notificaiton arrieve value is ${globalVariable.isNotificationArrive}");
      showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("Notification Is In open message $message");
      print("🥳 onMessageOpenedApp => ${message.notification?.title}");
      print("🥳 onMessageOpenedApp => ${message.notification?.body}");
      handleNotification(message.data, AppState.background);
    });

    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      print("Notification Is In getInitialMessage ${message.toString()}");
      if (message != null) {
        updateGlobalVariable();
        print("variable value is ${globalVariable.isNotificationArrive}");
        handleNotification(message.data, AppState.terminated);
      }
    });

    FirebaseMessaging.instance.subscribeToTopic("test").then((value) {
      print("object=============>>>>>");
    });

    FirebaseMessaging.onBackgroundMessage((RemoteMessage? message) async {
      print("onBackgroundMessage :: ${message!.data.toString()}");
      if (message != null) {
        updateGlobalVariable();
        handleNotification(message.data, AppState.terminated);
      }
    });
  }

}

Future<void> showNotification(RemoteMessage message) async {
  // RemoteNotification? notification = message.notification;
  print("message=====> showNotification === ${message.toMap()}");
  RemoteNotification? notification = message.notification;

  AndroidNotificationChannel androidNotificationChannel = const AndroidNotificationChannel(
    showBadge: true,
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.',
    // description
    importance: Importance.high,
    playSound: true,
    enableLights: true,
    enableVibration: true,
  );
  AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
    androidNotificationChannel.id.toString(),
    androidNotificationChannel.name.toString(),
    channelDescription: androidNotificationChannel.description,
    importance: Importance.max,
    priority: Priority.high,
    icon: '@mipmap/ic_launcher',
    playSound: true,
    enableLights: true,
    enableVibration: true,
    ongoing: true,
    largeIcon: const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
  );


  DarwinNotificationDetails darwinNotificationDetails =
  DarwinNotificationDetails(presentBanner: true,presentAlert: true, presentBadge: true, presentSound: true, subtitle: notification?.body ?? "");
  NotificationDetails notificationDetails = NotificationDetails(
    android: androidNotificationDetails,
    iOS: darwinNotificationDetails,
  );

    FlutterLocalNotificationsPlugin().show(0, notification?.title ?? "", notification?.body ?? "", notificationDetails);
  handleNotification(message.data, AppState.foreground);
}

void handleNotification(Map<String, dynamic> message, AppState appState) {

  print("object================ ${appState}");
  if (appState == AppState.terminated || appState == AppState.background) {
    // remoteData = message;
  }else{
    if (message['type'] == "logout_device") {
      // forceLogoutDialog();
    }
  }
  /*SharePref().clearPre();
  SharePref().saveNotificationType(message['notificationType']);
  SharePref().saveAlertsId(message['id_alerts'] ?? "");
  SharePref().saveFriendCode(message['deviceId'] ?? "");
  print('deviceId >> ${message['deviceId']}');
  print('notificationCode > ${navState.currentWidget}');
  if (appState == AppState.terminated) {
    isTerminated = 1;
    remoteData = message;
  } else {
    if (message['notificationType'] == "friendRequest") {
      Navigator.pushReplacementNamed(navState.currentContext!, routeSos, arguments: {'emergencyActive': message['notificationType'], 'deviceId': message['deviceId']});
    } else if (message['notificationType'] == "acceptedFR") {
      Navigator.pushNamedAndRemoveUntil(navState.currentContext!, routeSos, (Route<dynamic> route) => false,
          arguments: {'emergencyActive': message['notificationType'], 'deviceId': message['deviceId']});
    } else if (message['notificationType'] == "rejectedFR") {
      Navigator.pushReplacementNamed(navState.currentContext!, routeSos, arguments: {'emergencyActive': message['notificationType'], 'deviceId': message['deviceId']});
    } else if (message['notificationType'] == "emergencyActive" && notificationCode != message['deviceId']) {
      notificationCode = message['deviceId'];
      Navigator.pushReplacementNamed(navState.currentContext!, routeMap, arguments: {'isShowMap': true, 'lat': message['lat'], 'lon': message['lon'], 'deviceId': message['deviceId']});
    } else if (message['notificationType'] == "answer") {
      Navigator.pushReplacementNamed(navState.currentContext!, routeSurvey, arguments: {
        'answerTitle': message['title'],
        'answerMessage': message['mensaje'],
        'answerButton': message['textoBoton'],
        'answer': message['answer'],
      });
    } else if (message['notificationType'] == "finish" && message['deviceId'] == notificationCode) {
      notificationCode = "";
      Navigator.pushReplacementNamed(navState.currentContext!, routeSos, arguments: {'emergencyActive': message['notificationType'], 'deviceId': message['deviceId']});
    }
  }*/
}


enum AppState { foreground, background, terminated }

