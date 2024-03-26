// @dart=2.9
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
 import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:iutapp/page/mainmenu.dart';
import 'package:iutapp/utils/binding.dart';
 
import 'page/OnBoardingScreen.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  AwesomeNotifications().initialize('resource://drawable/res_app_icon', [
    NotificationChannel(
        channelKey: 'key1',
        channelName: 'Proto Coders Point',
        channelDescription: "Notification Swap",
        defaultColor: Color(0XFF9050DD),
        ledColor: Colors.white,
        playSound: true,
        enableLights: true,
        enableVibration: true,
        importance: NotificationImportance.High)
  ]);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await GetStorage.init();
  SystemChrome.setEnabledSystemUIOverlays([]);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        locale: Locale('ar'),
        initialBinding: MyBindings(),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return OnBoardingScreen();
            }
           else  {
              return MainMenu();
            }
             
          },
        ));
  }
}
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  AwesomeNotifications().createNotification(
      actionButtons: [
        NotificationActionButton(
          key: 'key',
          label: 'Open',
          // actionType: ActionType.InputField,
        )
      ],
      content: NotificationContent(
        id: 1,
        channelKey: 'key1',
        title: message.data["title"],
        body: message.data["body"],
      ));
  AwesomeNotifications().createNotificationFromJsonData(message.data);
}
