import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseNotifications {
  FirebaseMessaging _firebaseMessaging;
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  void setUpFirebase(BuildContext context) {
    _firebaseMessaging = FirebaseMessaging();

    var initializationSettingsAndroid = AndroidInitializationSettings("app_icon");
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(initializationSettingsAndroid, initializationSettingsIOS);
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    _flutterLocalNotificationsPlugin.initialize(initializationSettings);

    firebaseCloudMessaging_Listeners(context);
  }

  Future _onSelectNotification(String payload, BuildContext context) async {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Payload Title"),
          content: Text("$payload"),
        )
    );
  }

  void showNotification(Map<String, dynamic> message) async {
    var android = new AndroidNotificationDetails("channel_Id", "Channel name", "channelDescription");
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, iOS);

    _flutterLocalNotificationsPlugin.show(0, "title", "body", platform);
  }

  void firebaseCloudMessaging_Listeners(BuildContext context) {
    if (Platform.isIOS) iOS_Permission();

    _firebaseMessaging.getToken().then((token) {
      print("token: " + token);
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        showNotification(message);
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }

  void iOS_Permission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }
}