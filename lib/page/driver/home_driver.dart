import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:iutapp/chat/chat.dart';
import 'package:iutapp/page/driver/Create_posts.dart';
import 'package:iutapp/page/driver/student_list_page.dart';
import 'package:iutapp/page/profile.dart';
import 'package:iutapp/page/student/postlist.dart';
import 'package:iutapp/page/student/reportlist.dart';
import 'package:iutapp/utils/appcolor.dart';

import '../../controller/driver_controller.dart';
import '../../controller/student_controller.dart';
import '../login_screen.dart';
import 'create_report.dart';

class DriverHome extends StatelessWidget {
  final DriverController driverController = Get.find();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DriverController>(builder: (controller) {
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
              CreatePost(),              
              PostList(),
              CreateReport(),
              ReportList(),
              StudentList(), 
              AllChats(type:controller.user['typeuser'] ,),
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
              icon: Icons.add_box_outlined,
              label: 'منشور جديد',
            ),
            _bottomNavigationBarItem(
              icon: Icons.newspaper,
              label: 'الاخبار',
            ),
            _bottomNavigationBarItem(
              icon: Icons.notification_add,
              label: 'تقرير',
            ),
            _bottomNavigationBarItem(
              icon: Icons.newspaper_rounded,
              label: 'التقارير',
            ),
            _bottomNavigationBarItem(
              icon: Icons.list_outlined,
              label: 'قائمة الطلاب',
            ), _bottomNavigationBarItem(
              icon: Icons.message,
              label: 'الدردشات',
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
