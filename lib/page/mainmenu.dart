import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:iutapp/page/login_screen.dart';
import 'package:iutapp/page/signin_screen.dart';
import 'package:iutapp/page/signin_screen.dart';

// import '../controller/main_controller.dart';
import '../utils/appcolor.dart';
import '../widget/custome_button.dart';
// import 'Doctors/doctor_home.dart';
import 'admin/home_admin.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
Future.delayed(Duration.zero, () async {
  checkUser();
});
   
  }
  void checkUser(){
 int usertype;
    Widget screen = MainMenu();
    if (GetStorage().read("user") != null) {
      var user = GetStorage().read('user');
      usertype = user['typeuser'];
      if (usertype == 1) //Admin
      {
        screen = AdminHome();
      } else if (usertype == 2) //Donor
      {
        // screen = DoctorHome();
      }
      // else if (usertype == 3) //Observe
      // {
      //   screen = ObserveHome();
      // }
      Get.off(screen);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // return GetBuilder<MainController>(builder: (controller) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
                children: [
                  Text(
                    'مرحبا',
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
                    text: "دخول",
                    size: size,
                    colors: AppColor.buttonColor,
                    textStyle: const TextStyle(
                        fontFamily: ArabicFonts.Cairo,
                        package: 'google_fonts_arabic',
                        color: Colors.black,
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
                    text: "تسجيل",
                    size: size,
                    colors: AppColor.buttonColor,
                    textStyle: const TextStyle(
                        fontFamily: ArabicFonts.Cairo,
                        package: 'google_fonts_arabic',
                        color: Colors.black,
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
    // });
  }
}
