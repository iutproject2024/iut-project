import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts_arabic/fonts.dart' as font;
import 'package:iutapp/page/mainmenu.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../model/boarding.dart';
import 'login_screen.dart';
import '../utils/LocaleString.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  bool isLast = false;

  void submit() {
    // bool isLogin = GetStorage().read("login") != null ? true : false;
    // int usertype = 0;
    Widget screen = MainMenu();
    // if (GetStorage().read("login") != null) {
    //   isLogin = GetStorage().read("login");
    //   var token = GetStorage().read('token');
    //   usertype = int.parse(token[0]['usertype'].toString());
    //   if (usertype == 1) //Admin
    //   {
    //     screen = AdminHomePage();
    //   } else if (usertype == 2) //Doctor
    //   {
    //     screen = DoctorHomePage();
    //   } else if (usertype == 3) //Patient
    //   {
    //     screen = PatientHomePage();
    //   } else if (usertype == 4) //Donor
    //   {
    //     screen = DonorHomePage();
    //   }
    // } else {
    //   isLogin = false;
    //   screen = LoginPage();
    // }
    // GetStorage().write('isFirst', false);
    Get.off(screen);
  }

  @override
  Widget build(BuildContext context) {
    List<BoardingModel> boarding = [
      BoardingModel(
        image: 'assets/icon.png',
        title: 'hello'.tr,
        body: 'appname'.tr,
      ),
      BoardingModel(
        image: 'assets/icon.png',
        title: 'goal'.tr,
        body: 'goaldesc'.tr
      ),
      BoardingModel(
        image: 'assets/icon.png',
        title: 'join',
        body: 'joindesc'.tr
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        actions: [
          TextButton(
            onPressed: () {
              submit();
            },
            child: Text(
              'skip'.tr.toUpperCase(),
              style: TextStyle(
                fontFamily:font.ArabicFonts.Cairo,
                package: 'google_fonts_arabic',
                color: context.theme.cardColor,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardController,
                itemCount: boarding.length,
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                onPageChanged: (int value) {
                  if (value == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Colors.blue,
                    dotWidth: 10,
                    dotHeight: 10,
                    spacing: 5,
                    expansionFactor: 4,
                  ),
                  controller: boardController,
                  count: boarding.length,
                ),
                Spacer(),
                FloatingActionButton(
                  backgroundColor: Colors.blue,
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardController.nextPage(
                          duration: Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image(image: AssetImage('${model.image}'))),
          SizedBox(
            height: 20,
          ),
          Text(
            '${model.title}',
            style: TextStyle(
              fontFamily: font.ArabicFonts.Baloo_Bhaijaan,
              package: 'google_fonts_arabic',
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            '${model.body}',
            style: TextStyle(
              fontFamily: font.ArabicFonts.Cairo,
              package: 'google_fonts_arabic',
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      );
}
