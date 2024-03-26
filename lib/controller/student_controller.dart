import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts_arabic/fonts.dart';

class StudentController extends GetxController {
  final pageController = PageController(initialPage: 4);
  ScrollController? scrollController;

  var tabIndex = 0;

  void changeTabIndex(int index) {
    tabIndex = index;
    update();
  }

  int? type;

  var posts = [], reports = [];
  var user = GetStorage().read('user');

  void getPosts(int type) async {
    // type = user['typeuser'];
    posts = [];

    var collection;

    if (type == 2) {
      collection = FirebaseFirestore.instance
          .collection('posts')
          .where('userid', isEqualTo: user['id']);
    } else {
      collection = FirebaseFirestore.instance.collection('posts');
    }
    var querySnapshot = await collection.get();
    var list = [];
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      list.add(data);
    }
    posts = list;
    update();
  }

  void getReport(int type) async {
    // type = user['typeuser'];
    reports = [];

    var collection;

    if (type == 2) {
      collection = FirebaseFirestore.instance
          .collection('reports')
          .where('userid', isEqualTo: user['id']);
    } else {
      collection = FirebaseFirestore.instance.collection('reports');
    }
    var querySnapshot = await collection.get();
    var list = [];
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      list.add(data);
    }
    reports = list;
    update();
  }

  void deletePost(String id) async {
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(id)
        .delete()
        .then((value) {
      getPosts(type!);
      update();
    });
  }

  void deleteReport(String id) async {
    await FirebaseFirestore.instance
        .collection('reports')
        .doc(id)
        .delete()
        .then((value) {
      getReport(type!);
      getPosts(type!);
      update();
    });
  }

  @override
  void onInit() async {
    user = GetStorage().read('user');
    type = user['typeuser'];
    getReport(type!);
    getPosts(type!);
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
