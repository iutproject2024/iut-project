import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:iutapp/page/login_screen.dart';
import 'package:iutapp/page/mainmenu.dart';

import '../widget/custome_button.dart';
import '../widget/text.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileState();
}

class _ProfileState extends State<ProfileScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  // final paymentController = TextEditingController();

  var user;
  String type = "نوع الحساب  :";
  bool add = false;
  @override
  void initState() {
    user = GetStorage().read("user");

    var userType = user['typeuser'];
    if (userType == 1) {
      type += 'مدير النظام';
    } else if (userType == 2) {
      type += 'طبيب';
    } else if (userType == 3) {
      type += 'مريض';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: Center(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomeButton(
          text: "تعديل",
          size: size * .8,
          colors: Color.fromARGB(255, 237, 237, 237),
          textStyle: const TextStyle(
              fontFamily: ArabicFonts.Cairo,
              package: 'google_fonts_arabic',
              fontWeight: FontWeight.bold),
          function: () {
            {
              nameController.text = user['name'];
              phoneController.text = user['phone'];
              // paymentController.text = user['payment'];
              add = !add;
            }
          },
        ),
        !add
            ? Center(
                child: Container(
                  padding:
                      EdgeInsets.only(right: 2, bottom: 5, top: 2, left: 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(user['name'],
                          style: TextStyle(
                              fontFamily: ArabicFonts.Amiri,
                              package: 'google_fonts_arabic',
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                      Text(type,
                          style: TextStyle(
                              fontFamily: ArabicFonts.Amiri,
                              package: 'google_fonts_arabic',
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                      Text(user['email'],
                          style: TextStyle(
                              fontFamily: ArabicFonts.Amiri,
                              package: 'google_fonts_arabic',
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                      Text(user['phone'],
                          style: TextStyle(
                              fontFamily: ArabicFonts.Amiri,
                              package: 'google_fonts_arabic',
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                    ],
                  ),
                ),
              )
            : Row(),
        add
            ? SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                          child: ValidateTextView(
                        enabled: true,
                        textInputType: TextInputType.text,
                        controller: nameController,
                        hintText: 'الاسم',
                        filedSize: r'^.{1,30}$',
                      )),
                    ),
                    ValidateTextView(
                      enabled: true,
                      textInputType: TextInputType.text,
                      controller: phoneController,
                      hintText: 'رقم الهاتف',
                      filedSize: r'^.{1,30}$',
                    ),
                    // ValidateTextView(
                    //   enabled: true,
                    //   textInputType: TextInputType.text,
                    //   controller: paymentController,
                    //   hintText: 'بيانات الدفع',
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MaterialButton(
                          color: Colors.blue,
                          child: Text(
                            'حفظ التعديل',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                          onPressed: () async {
                            setState(() {
                              UpdateUser();
                            });
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        MaterialButton(
                            color: Colors.red,
                            child: Text(
                              'الغاء التعديل',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                            onPressed: () {
                              setState(() {
                                add = !add;
                              });
                            }),
                      ],
                    ),
                  ],
                ),
              )
            : Row(),
      ],
    )));
  }

  void UpdateUser() async {
    var user = GetStorage().read('user');
    String id = user['id'];
    try {
      FirebaseFirestore.instance.collection('users').doc(id).update({
        'name': nameController.text.trim(),
        'phone': phoneController.text.trim(),
        // 'payment': paymentController.text.trim(),
      }).then((value) {
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
        // showSnakbar('خطأ', message, Icons.error, Colors.red);
      }
    } catch (e) {}
    // });
  }
}
