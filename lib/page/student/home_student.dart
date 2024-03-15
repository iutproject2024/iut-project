import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:iutapp/page/profile.dart';
import 'package:iutapp/page/student/postlist.dart';
import 'package:iutapp/page/student/reportlist.dart';
import 'package:iutapp/utils/appcolor.dart';
import 'package:iutapp/chat/chat.dart';

import '../../controller/student_controller.dart';
import '../login_screen.dart';

class StudentHome extends StatelessWidget {
  final StudentController studentController = Get.find();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            InkWell(
              child: Icon(
                Icons.person,
                color: Colors.black,
              ),
              onTap: () {
                Get.to(ProfileScreen());
              },
            ),
            IconButton(
              onPressed: () {
                GetStorage().remove('user');
                Get.off(LoginScreen());
              },
              icon: Icon(Icons.close),
            )
          ]),
        ),
        body: SafeArea(
          child: IndexedStack(
            index: controller.tabIndex,
            children: [
              PostList(),
              ReportList(),
             
              AllChats(type:controller.user['typeuser'] ),
              Container(),
            ],
          ),
        ),
        extendBody: true,
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.black,
          onTap: controller.changeTabIndex,
          currentIndex: controller.tabIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          fixedColor: AppColor.buttonColor,
          elevation: 0,
          items: [
            _bottomNavigationBarItem(
              icon: Icons.newspaper,
              label: 'الاخبار',
            ),
            _bottomNavigationBarItem(
              icon: Icons.lightbulb_sharp,
              label: 'التقارير',
            ),
            _bottomNavigationBarItem(
              icon: Icons.message,
              label: 'دردشة',
            ),
            _bottomNavigationBarItem(
              icon: Icons.notification_important_outlined,
              label: 'اشعارات الوصول',
            ),
          ],
        ),
      );
    });
  }
}

_bottomNavigationBarItem({IconData? icon, String? label}) {
  return BottomNavigationBarItem(
    icon: Icon(icon),
    label: label,
  );
}
