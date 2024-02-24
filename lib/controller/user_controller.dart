import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iutapp/page/admin/home_admin.dart';
import 'package:iutapp/page/login_screen.dart';
// import 'package:masjids/page/Observe/add_musque_request.dart';
// import 'package:masjids/page/Observe/observe_home.dart';

// import '../page/Admin/admin_home.dart';
// import '../page/Charity/charity_home.dart';
// import '../page/Donor/donor_home.dart';
import '../page/mainmenu.dart'; 
 
class UserController extends GetxController {
  UserCredential? _authresult;
  FirebaseAuth? auth;

  final name = TextEditingController();
  final password = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  final bool? isActive = true;
  bool? active;
  // UserController(this.data);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    //  bool isLogin = GetStorage().read("login") != null ? true : false;
    // // int usertype = 0;
    // Widget screen = MainMenu();
    // if (GetStorage().read("login") != null) {
    // bool  isLogin = GetStorage().read("login");
    //   var token = GetStorage().read('token');
    // int  usertype = int.parse(token[0]['usertype'].toString());
    //   if (usertype == 1) //Admin
    //   {
    //     screen = AdminHome();
    //   } else if (usertype == 2) //Doctor
    //   {
    //     screen = DoctorHome();
    //   } 
    //   // else if (usertype == 3) //Patient
    //   // {
    //   //   screen = PatientHomePage();
    //   // } else if (usertype == 4) //Donor
    //   // {
    //   //   screen = DonorHomePage();
    //   // }
    // } else {
    //   isLogin = false;
    //   // screen = LoginScreen();
    // }
    // GetStorage().write('isFirst', false);
    // Get.off(screen);
    // // if (data != null) {
    // //   name.text = data['name'];
    // //   password.text = data['password'];
    // //   phone.text = data['phone'];
    // //   email.text = data['email'];
    // // }
  }

  void UpdateUser(String id) async {
    auth = await FirebaseAuth.instance;
    try {
      FirebaseFirestore.instance.collection('users').doc(id).update({
        'name': name.text.trim(),
        'password': password.text.trim(),
        'email': email.text.trim(),
        'phone': phone.text.trim(),
        'isActive': isActive,
        // 'createDate': Timestamp.now(),
      }).then((value) {
        showSnakbar(
            'تعديل', 'تم تعديل بيانات المستخدم', Icons.login, Colors.green);
        name.clear();
        email.clear();
        password.clear();
        phone.clear();
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

   void resetPassword() async {
  auth = await FirebaseAuth.instance;
  await auth!
        .sendPasswordResetEmail(email: email.text.trim())
        .then((value) {

      showSnakbar('تنبية', 'يرجى التحقق من بريدك الإلكتروني', Icons.error, Colors.red);
      // print(value);
          //if(value)
        })
        .catchError((e)  {
          
        }); 
  }
//async and await is
  void login() async {
    try {
      FirebaseAuth auth = await FirebaseAuth.instance;
      await auth
          .signInWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((value) async {
        var user;

        Widget screen = MainMenu();
        if (value.user != null) {
          var collection = FirebaseFirestore.instance
              .collection('users')
              .where("id", isEqualTo: auth.currentUser!.uid);
          var querySnapshot = await collection.get();
          for (var queryDocumentSnapshot in querySnapshot.docs) {
            Map<String, dynamic> data = queryDocumentSnapshot.data();
            user = data;
            GetStorage().write("user", data);
            GetStorage().write("login", true);
          }
     
         int? usertype = user['typeuser'];
          if (usertype == 1) //Admin
          {
            screen = AdminHome();
          } 
          else if (usertype == 2) //Donor
          {
            
          } else if (usertype == 3) 
          {
            // screen = ObserveHome();
          }
          //  else if (usertype == 4) {
          //   screen = CharityHome();
          // }
          email.clear();
          password.clear();
        }
        Get.to(screen);
      });
    } catch (x) {
      showSnakbar('خطأ', x.toString(), Icons.error, Colors.red);
    }
  }

  void rest() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      auth.sendPasswordResetEmail(email: email.text.trim());
      Get.back();
    } catch (x) {
      showSnakbar('خطأ', x.toString(), Icons.error, Colors.red);
    }
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

  void showDialog(String msg, Color color) async {
    await Future.delayed(Duration(seconds: 0));
    Get.defaultDialog(
        barrierDismissible: false,
        content: Stack(
          alignment: AlignmentDirectional.topCenter,
          clipBehavior: Clip.none,
          children: [
            Card(
              color: Colors.green.shade50,
              child: Padding(
                  padding: EdgeInsets.fromLTRB(32, 56, 32, 33),
                  child: Text(
                    msg,
                    style: TextStyle(fontSize: 32),
                  )),
            ),
            Positioned(
                top: -40,
                child: Container(
                  child: Icon(
                    Icons.gpp_good,
                    color: color,
                    size: 84,
                  ),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.green.shade50, width: 4),
                      shape: BoxShape.circle),
                ))
          ],
        ));
    await Future.delayed(Duration(seconds: 2));

    Get.back();
  }
}
