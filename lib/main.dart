// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'page/OnBoardingScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  SystemChrome.setEnabledSystemUIOverlays([]);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  // await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        locale: const Locale('ar'),
        // initialBinding: MyBindings(),
        home:
            //  StreamBuilder(
            //   stream: FirebaseAuth.instance.authStateChanges(),
            //   builder: (ctx, userSnapshot) {
            //     if (userSnapshot.connectionState == ConnectionState.waiting) {
            //       return OnBoardingScreen();
            //     }
            //     if (userSnapshot.hasData) {
            //       return MainMenu();
            //     }
            //     return
            OnBoardingScreen()
        // ;   },
        // )
        );
  }
}
