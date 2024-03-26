import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts_arabic/fonts.dart';

import '../controller/user_controller.dart';
import '../utils/appcolor.dart';
import '../widget/custome_button.dart';
import '../widget/text.dart';
import 'signin_screen.dart';

class LoginScreen extends StatelessWidget {
  final UserController userController = Get.find();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<UserController>(builder: (controller) {
      return Scaffold(
          body: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: 1,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/icon.png',
                        width: size.width * .8,
                        height: size.height * .5,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: size.height * .01,
                          left: size.height * .03,
                          right: size.height * .03,
                          bottom: size.height * .01),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ValidateTextView(
                            enabled: true,
                            hintText: "البريد الإلكتروني",
                            textInputType: TextInputType.emailAddress,
                            controller: controller.email,
                          ),
                          ValidateTextView(
                            enabled: true,
                            hintText: "كلمة المرور",
                            textInputType: TextInputType.visiblePassword,
                            controller: controller.password,
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "نسيت كلمة المرور؟",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontFamily: ArabicFonts.Cairo,
                                  package: 'google_fonts_arabic',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                        alignment: FractionalOffset.fromOffsetAndSize(
                            Offset.fromDirection(20), size),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(flex: 1, child: Row()),
                            Expanded(
                              flex: 3,
                              child: CustomeButton(
                                text: "الرجوع",
                                size: size * .8,
                                colors: AppColor.buttonColor,
                                textStyle: const TextStyle(
                                    fontFamily: ArabicFonts.Cairo,
                                    package: 'google_fonts_arabic',
                                    // color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                function: () {
                                  Get.back();
                                },
                              ),
                            ),
                            Expanded(flex: 1, child: Row()),
                            Expanded(
                              flex: 3,
                              child: CustomeButton(
                                text: "دخول",
                                size: size * .8,
                                colors: AppColor.buttonColor,
                                textStyle: const TextStyle(
                                    fontFamily: ArabicFonts.Cairo,
                                    package: 'google_fonts_arabic',
                                    // color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                function: () {
                                  {
                                    if (controller.email.text.isNotEmpty &&
                                        controller.password.text.isNotEmpty) {
                                      controller.login();
                                    } else {
                                      controller.showSnakbar(
                                          'تحذير',
                                          'تأكد من إدخال الحقول المطلوبة بشكل صحيح',
                                          Icons.warning_rounded,
                                          Colors.red);
                                    }
                                  }
                                },
                              ),
                            ),
                            Expanded(flex: 1, child: Row())
                          ],
                        ))
                  ],
                );
              }));
    });
  }
}
