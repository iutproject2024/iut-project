import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:iutapp/page/login_screen.dart';

class AdminController extends GetxController {
  final pageController = PageController(initialPage: 4);
  var tabIndex = 0;

  void changeTabIndex(int index) {
    tabIndex = index;
    update();
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  final name = TextEditingController();
  final password = TextEditingController();
  final ConfPassword = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  final address = TextEditingController();
  final id = TextEditingController();
  final deptname = TextEditingController();
  int userType = 0;
  bool isDonor = false, isObserve = false, isCharity = false;
  final bool? isActive = true;
  bool? active;
  String? flag = "🇸🇦", phoneCode = "966", hintphoneExam;

  var Department;
  String? observeName;
  List<String> userListItems = ['سائق', 'طالب'];
  List<String> userItems = ['سائق', 'طالب'];
  var userList;
  var user;
  File? pickedImage;
  final ImagePicker _picker = ImagePicker();

  void pickImage(ImageSource source) async {
    final pickImageFile =
        await _picker.getImage(source: source, imageQuality: 50, maxWidth: 150);
    if (pickImageFile != null) {
      //اذا كان المتغير بيك ايمج فايل لا يساوي نول يعني تم اختيار من المعر
      pickedImage = File(pickImageFile.path);
      update();
      // widget.imagePickFn(_pickedImage);
    }
  }

  @override
  void onInit() async {
    // onlniteعند فتح الشاشه ينفذ الاومر
    // getObserve();
    getData(userType);
    user = await GetStorage().read('user');
    getDepartment();
    update();
    super.onInit();
  }

  void changeType(String value) {
    if (value == 'سائق') {
      userType = 2;
    } else if (value == 'طالب') {
      userType = 3;
    }

    update();
  }

  void getData(int type) async {
    var collection;
    userList = [];
    if (type == 0) {
      collection = FirebaseFirestore.instance
          .collection('users')
          .where('typeuser', isNotEqualTo: 1);
    } else {
      collection = await FirebaseFirestore.instance
          .collection('users')
          .where('typeuser', isEqualTo: type);
    }
    var querySnapshot = await collection.get();
    userList = querySnapshot.docs;

    update();
  }

  // void getObserve() async {
  //   Department = [];

  //   var collection = FirebaseFirestore.instance
  //       .collection('users')
  //       .where('typeuser', isEqualTo: 3);
  //   var querySnapshot = await collection.get();

  //   var oblist = [];
  //   for (var queryDocumentSnapshot in querySnapshot.docs) {
  //     Map<String, dynamic> data = queryDocumentSnapshot.data();

  //     oblist.add(data['name']);
  //   }
  //   Department = oblist;
  //   update();
  // }
    
  void getDepartment() async {
    Department = [];

    var collection = FirebaseFirestore.instance.collection('Department');
    var querySnapshot = await collection.get();

    var oblist = [];
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();

      oblist.add(data['name']);
    }
    Department = oblist;
    update();
  }

  void changeObserve(value) {
    observeName = value;
    update();
  }

  void addDepartment() {
    FirebaseFirestore.instance.collection('Department').doc().set({
      'name': deptname.text.trim(),
      // 'createDate': DateTime.now(),
    }).then((value) {
      deptname.clear();
      showSnakbar('حفظ', 'تم إضافة القسم', Icons.login, Colors.green);
    });
  }

  void signin() async {
    auth = await FirebaseAuth.instance;

    try {
      auth
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((value) async {
        if (value.user != null) {
          String? token = await FirebaseMessaging.instance.getToken();

          // final url = await ref.getDownloadURL();
          if (userType == 1)
            await FirebaseFirestore.instance
                .collection('users')
                .doc(value.user!.uid)
                .set({
              'id': value.user!.uid,
              'name': name.text.trim(),
              'password': password.text.trim(),
              'email': email.text.trim(),
              'phone': '966' + phone.text.trim(),
              'token': token,
              'typeuser': userType,
              'address': address.text.trim(),
              'image_url':
                  "https://firebasestorage.googleapis.com/v0/b/masjids-12575.appspot.com/o/user-image%2Fuser.png?alt=media&token=9cebc390-cd59-49f3-8a24-948ee326f4cd",
              'isActive': false
            }).then((value) {
              showSnakbar('نجاح', 'تمت عملية التسجيل ب نجاح', Icons.login,
                  Colors.green);
              name.clear();
              email.clear();
              password.clear(); 
              id.clear();
              ConfPassword.clear();
              phone.clear();
            });

          else
            await FirebaseFirestore.instance
                .collection('users')
                .doc(value.user!.uid)
                .set({
              'id': value.user!.uid,
              'name': name.text.trim(),
              'password': password.text.trim(),
              'email': email.text.trim(),
              'phone': '966' + phone.text.trim(),
              'token': token,
              'studentId': id.text.trim(),
              'address': address.text.trim(),
              'typeuser': userType,
              'image_url':
                  "https://firebasestorage.googleapis.com/v0/b/masjids-12575.appspot.com/o/user-image%2Fuser.png?alt=media&token=9cebc390-cd59-49f3-8a24-948ee326f4cd",
              'isActive': false
            }).then((value) {
              showSnakbar('نجاح', 'تمت عملية التسجيل ب نجاح', Icons.login,
                  Colors.green);
              name.clear();
              email.clear();
              password.clear();
              address.clear();
              id.clear();
              ConfPassword.clear();
              phone.clear();
            });

          int usertype;
          if (GetStorage().read("user") != null) {
            var user = GetStorage().read('user');
            usertype = user['typeuser'];
          } else {
            Get.to(LoginScreen());
          }
        }
      });
    } on FirebaseAuthException catch (e) {
      String message = e.code;
      if (e.code == 'weak-password')
        message = 'The password provided is too weak';
      else if (e.code == 'eamil-already-in-use')
        message = 'The account alrady exists for that email';
      else if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
      } else {
        showSnakbar('خطأ', message, Icons.error, Colors.red);
      }
    } catch (e) {}
  }

  void setUpdate(user) async {
    name.text = user['name'];
    password.text = user['password'];
    phone.text = user['phone'];
    email.text = user['email'];
    active != user['isActive'] as bool;
    update();
  }

  void deleteUser(String id) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .delete()
        .then((value) {
      showSnakbar('حذف', 'تم تعديل بيانات المستخدم', Icons.login, Colors.green);

      getData(userType);
    });
  }

  void changeState(bool state) {
    update();
  }

  void UpdateUser(String id) async {
    auth = await FirebaseAuth.instance;
    try {
      FirebaseFirestore.instance.collection('users').doc(id).update({
        'name': name.text.trim(),
        'password': password.text.trim(),
        'email': email.text.trim(),
        'phone': phone.text.trim(),
        'isActive': active,
        'createDate': Timestamp.now(),
      }).then((value) {
        showSnakbar(
            'تعديل', 'تم تعديل بيانات المستخدم', Icons.login, Colors.green);
        name.clear();
        email.clear();
        password.clear();
        phone.clear();
        getData(0);
        Future.delayed(Duration(seconds: 3), () {
          Get.back();
        });
      });
    } on FirebaseAuthException catch (e) {
      String message = e.code;
      if (e.code == 'weak-password')
        message = 'The password provided is too weak';
      else if (e.code == 'eamil-already-in-use')
        message = 'The account alrady exists for that email';
      else if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
      } else {
        showSnakbar('خطأ', message, Icons.error, Colors.red);
      }
    } catch (e) {}
    // });
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
                deleteUser(id);
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
