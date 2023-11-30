import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProviderInternet extends GetxController {
  final Connectivity _connectivity = Connectivity();

  RxBool isOnline = false.obs;
 // RxBool get isOnline => _isOnline.obs;

  startMonitoring() async {
    await initConnectivity();
    _connectivity.onConnectivityChanged.listen((result) async {
      if (result == ConnectivityResult.none) {
        //isOnline.value = false;
        isOnline(false);
        update();
        // notifyListeners();
      } else {
        await _updateConnectionStatus().then((bool isconnected) {
        //  isOnline.value = isconnected;
           isOnline(isconnected);
          update();
         // notifyListeners();
        
        });
      }
    });
  }

  Future<void> initConnectivity() async {
    try {
      var status = await _connectivity.checkConnectivity();

      if (status == ConnectivityResult.none) {
       // isOnline.value = false;
         isOnline(false);
      } else {
       // isOnline.value = true;
         isOnline(true);
        update();
       // notifyListeners();
      }
    } on PlatformException {}
  }

  Future<bool> _updateConnectionStatus() async {
    bool? isconnected;
    try {
      final List<InternetAddress> result =
          await InternetAddress.lookup("google.com");
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isconnected = true;
      }
    } on SocketException catch (_) {
      isconnected = false;
    }
    return isconnected!;
  }
}
