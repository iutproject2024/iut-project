import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts_arabic/fonts.dart';
 import 'package:iutapp/page/profile.dart';
import 'package:iutapp/utils/appcolor.dart';
import 'package:iutapp/widget/custome_button.dart';

import '../../chat/chat.dart';
import '../../controller/admin_controller.dart';
import '../login_screen.dart'; 
import '../signin_screen.dart'; 
import 'user_list_page.dart';

class AdminHome extends StatelessWidget {
  final AdminController adminController = Get.find();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var user = GetStorage().read('user');

    return GetBuilder<AdminController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
           
            // Image.asset(
            //   'assets/icon.png',
            //   height: size.width * .1,
            // ),
           InkWell(
              child: Icon(
                Icons.person,
                color: Colors.black,
              ),
              onTap: () {
                Get.to(ProfileScreen());
              },
            ),  IconButton(
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
             
              UserList(),
               SignInScreen(),
              AllChats(type: user['typeuser']),
              
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
              icon: Icons.group,
              label: 'المستخدمين',
            ),
             _bottomNavigationBarItem(
              icon: Icons.add,
              label: 'المستخدمين',
            ),
           
            _bottomNavigationBarItem(
              icon: Icons.chat,
              label: 'دردشة',
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
