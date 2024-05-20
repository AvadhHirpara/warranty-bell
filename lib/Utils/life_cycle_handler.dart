import 'package:WarrantyBell/Pages/AddProductScreen/add_product_view.dart';
import 'package:WarrantyBell/Utils/routes.dart';
import 'package:WarrantyBell/main.dart';
import 'package:flutter/material.dart';


class LifecycleEventHandler extends WidgetsBindingObserver {
  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        print('Back to app');
        if(userData.userId != '' && isImageCapture == false){
          Navigator.pushNamed(navState.currentContext!, homeScreen);
        }
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
