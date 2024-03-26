import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iutapp/utils/appcolor.dart';

import '../controller/scroll_controller.dart';
import '../widget/chat/messages.dart';
import '../widget/chat/new_message.dart';

class UserChat extends StatelessWidget {
  // شاشة عرض الدردشات السابقة مع المستخدمين
  final String userimage, userName, reciver, chatId;
  UserChat(this.userimage, this.userName, this.reciver, this.chatId);
  final ScrollToTopController sController = Get.put(ScrollToTopController());

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.buttonColor,
        elevation: 3,
        leading: IconButton(
            icon: Icon(
              Icons.keyboard_backspace,
            ),
            onPressed: () => Get.back()),
        titleSpacing: 0,
        title: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 0.0, right: 10.0),
              child: InkWell(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    userimage,
                  ),
                ),
                onTap: () {},
              ),
            ),
            SizedBox(
              width: 50,
            ),
            Text(
              userName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
      body: SizedBox(
        child: Column(
          children: [
            Expanded(
                flex: 8,
                child: ListView(
                    shrinkWrap: true,
                    controller: sController.msgScroll,
                    children: <Widget>[Messages(user!.uid, reciver, chatId)])),
            Expanded(flex: 2, child: NewMessage(reciver, chatId))
          ],
        ),
      ),
    );
  }
}
