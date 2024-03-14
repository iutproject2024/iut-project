import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts_arabic/fonts.dart';

class DriverController extends GetxController {
  final pageController = PageController(initialPage: 4);
  var tabIndex = 0;

  void changeTabIndex(int index) {
    tabIndex = index;
    update();
  }

  @override
  void onInit() async {
    super.onInit();
  }

  void showSnakbar(String head, String body, IconData icon, Color color) {
    Get.snackbar(
      head,
      body,
      snackStyle: SnackStyle.FLOATING,
      icon: Icon(icon, color: Colors.white),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: color,
      borderRadius: 20,
      margin: EdgeInsets.all(15),
      colorText: Colors.white,
      duration: Duration(seconds: 1),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  void showDialog(String id, String username) async {
    //يعرض ShowDialog النموذج بشكل مشروط ، مما يعني أنه لا يمكنك الانتقال إلى النموذج الأصل
    await Future.delayed(Duration(seconds: 0));
    Get.defaultDialog(
        title: "حذف",
        middleText: "هل تريد حذف المستخدم " + username,
        middleTextStyle: TextStyle(
            fontFamily: ArabicFonts.Cairo,
            package: 'google_fonts_arabic',
            fontSize: 16,
            fontWeight: FontWeight.bold),
        backgroundColor: Colors.white,
        titleStyle: TextStyle(
            fontFamily: ArabicFonts.Cairo,
            package: 'google_fonts_arabic',
            fontSize: 18,
            color: Colors.red,
            fontWeight: FontWeight.bold),
        actions: [
          TextButton(
              onPressed: () {
                // deleteUser(id);
              },
              child: Text(
                'نعم',
                style: TextStyle(
                    fontFamily: ArabicFonts.Cairo,
                    package: 'google_fonts_arabic',
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              )),
          TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(
                'لا',
                style: TextStyle(
                    fontFamily: ArabicFonts.Cairo,
                    package: 'google_fonts_arabic',
                    fontSize: 16,
                    color: Colors.green,
                    fontWeight: FontWeight.bold),
              ))
        ],
        radius: 30);
    // await Future.delayed(Duration(seconds: 2));

    // Get.back();
  }
}
