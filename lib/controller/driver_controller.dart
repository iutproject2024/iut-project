import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../notifications.dart';

class DriverController extends GetxController {
  final pageController = PageController(initialPage: 4);
  var tabIndex = 0;

  void changeTabIndex(int index) {
    tabIndex = index;
    update();
  }

  var studentlist;
  File? img;
  bool visblimgon = false;
  File? pickedImage;
  final ImagePicker _picker = ImagePicker();
  final posttext = TextEditingController();
  final reporttext = TextEditingController();
  @override
  void onInit() async {
    super.onInit();
    getUsers();
  }

  var user = GetStorage().read('user');

  void getUsers() async {
    var collection;
    studentlist = [];

    collection = FirebaseFirestore.instance
        .collection('users')
        .where('typeuser', isEqualTo: 3);

    var querySnapshot = await collection.get();
    studentlist = querySnapshot.docs;

    update();
  }

  void addReport() async {
    DocumentReference ref =
        FirebaseFirestore.instance.collection("reports").doc();
    ref.set({
      "id": ref.id,
      'userid': user['id'],
      'userimage': user['image_url'],
      'name': user['name'],
      'text': reporttext.text,
      'date': DateTime.now(),
    }).then((value) {
      reporttext.clear();
      String? title = 'تقرير', body = posttext.text.trim(), token;
      Future.delayed(const Duration(seconds: 1), () async {
        try {
          var collection = FirebaseFirestore.instance
              .collection('users')
              .where('typeuser', isEqualTo: 3);

          var querySnapshot = await collection.get();
          for (var queryDocumentSnapshot in querySnapshot.docs) {
            Map<String, dynamic> data = queryDocumentSnapshot.data();
            SendMessage.sendFcmMessage(title, body, data['token']);
          }
        } catch (e) {
          print(e);
        }
      });

      showSnakbar('نجاح', 'تمت إضافة تقرير ', Icons.login, Colors.green);
    });
    update();
  }

  void addPost() async {
    var imageName = DateTime.now().millisecondsSinceEpoch.toString();
    var storageRef =
        FirebaseStorage.instance.ref().child('post_images/$imageName.jpg');
    var uploadTask =  storageRef.putFile(img!);
    var downloadUrl = await (await uploadTask).ref.getDownloadURL();
    var user = GetStorage().read('user');
    DocumentReference ref =
        FirebaseFirestore.instance.collection("posts").doc();
    ref.set({
      "id": ref.id,
      'userid': user['id'],
      'userimage': user['image_url'],
      'name': user['name'],
      'text': posttext.text,
      'image': downloadUrl,
      'date': DateTime.now(),
    }).then((value) {
      posttext.clear();
      img = null;
      String? title = 'منشور', body = posttext.text.trim(), token;
      Future.delayed(const Duration(seconds: 1), () async {
        try {
          var collection = FirebaseFirestore.instance
              .collection('users')
              .where('typeuser', isEqualTo: 3);

          var querySnapshot = await collection.get();
          for (var queryDocumentSnapshot in querySnapshot.docs) {
            Map<String, dynamic> data = queryDocumentSnapshot.data();
            SendMessage.sendFcmMessage(title, body, data['token']);
          }
        } catch (e) {
          print(e);
        }
      });

      showSnakbar('نجاح', 'تمت إضافة منشور ', Icons.login, Colors.green);
    });
    update();
  }

  Future getImage(ImageSource imageSource) async {
    try {
      final pickImageFile = await _picker.getImage(
          source: imageSource, imageQuality: 50, maxWidth: 150);
      if (pickImageFile != null) {
        img = File(pickImageFile.path);
        visblimgon = true;
        update();
      }
    } on PlatformException catch (e) {}
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
