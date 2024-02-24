// @dart=2.9
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

Future<void> _firebadeMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase
      .initializeApp(); // options: DefaultFirebaseConfig.platformOptions
  print('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebadeMessagingBackgroundHandler);

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
