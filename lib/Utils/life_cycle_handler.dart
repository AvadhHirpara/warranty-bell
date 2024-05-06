import 'package:flutter/material.dart';


class LifecycleEventHandler extends WidgetsBindingObserver {
  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        print('Back to app');
        // if (remoteData.isNotEmpty) {
        //   remoteData = {};
        //   forceLogoutDialog();
        // }
        break;
      case AppLifecycleState.paused:
        print('App minimised or Screen locked');
        break;
      case AppLifecycleState.inactive:
        print('App minimised or Screen inactive');
        break;
      case AppLifecycleState.detached:
        print('App minimised or Screen detached');
        // if (mqttClientManager.getClientIsConnected() == true) {
        //   mqttClientManager.disconnect();
        // }
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }
}
