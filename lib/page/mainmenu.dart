import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:iutapp/page/login_screen.dart';
import 'package:iutapp/page/signin_screen.dart';

import '../widget/custome_button.dart';

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(      
      // backgroundColor: Colors.blue[200],
      // appBar: AppBar(
      //     backgroundColor: Colors.white,
      //     title: Text('إبصار',
      //         style: TextStyle(
      //             fontFamily: ArabicFonts.Cairo,
      //             package: 'google_fonts_arabic',
      //             color: Colors.black,
      //             fontWeight: FontWeight.bold,
      //             fontSize: 20))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: size.height * .4,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/icon.png'), fit: BoxFit.fill)),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: size.height * .01,
                  left: size.height * .03,
                  right: size.height * .03,
                  bottom: size.height * .01),
              child: Column(
                children: [
                  Text(
                    'hello'.tr,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: ArabicFonts.Cairo,
                        package: 'google_fonts_arabic',
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CustomeButton(
                    text: "تسجيل دخول",
                    size: size,
                    textStyle: const TextStyle(
                        fontFamily: ArabicFonts.Cairo,
                        package: 'google_fonts_arabic',
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    function: () {
                      {
                        Get.to(LoginScreen());
                      }
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CustomeButton(
                    text: "تسجيل جديد",
                    size: size,
                    textStyle: const TextStyle(
                        fontFamily: ArabicFonts.Cairo,
                        package: 'google_fonts_arabic',
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    function: () {
                      {
                        Get.to(SignInScreen());
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
