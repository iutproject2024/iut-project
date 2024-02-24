import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:iutapp/chat/chatitem.dart';
import 'package:iutapp/utils/appcolor.dart';
// import 'package:iutapp/controller/admin_controller.dart';
// import 'package:iutapp/page/Admin/edit_user.dart';

import '../chat/userchat.dart';
import '../page/admin/edit_user.dart';
import '../utils/utils.dart';
// import '../utils/utils.dart';

UserCard(
    Size size, dynamic data, BuildContext context,   controller) {
  return Center(
    child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: AppColor.cardColor,
        child: Container(
            width: size.width * .95,
            height: size.height * .15,
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customeText('الاسم : ' + data['name']!),
                    customeText('الهاتف : ' + data['phone']!),
                    customeText('البريد : ' + data['email']!),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                        onTap: () {
                          print(data);
                          controller.user = data;
                          controller.setUpdate(controller.user);
                          Get.to(EditUser());
                        },
                        child: Icon(
                          // size: 25,
                          Icons.edit,
                          color: AppColor.buttonColor,
                        )),
                    InkWell(
                      onTap: () async {
                        final currentUser = FirebaseAuth.instance.currentUser;
                        String? reciverId, chatId;
                        var chat1 = await FirebaseFirestore.instance
                            .collection('chat')
                            .where('person1', isEqualTo: currentUser!.uid)
                            .where('person2', isEqualTo: data['id'])
                            .get();
                        var chat2 = await FirebaseFirestore.instance
                            .collection('chat')
                            .where('person1', isEqualTo: data['id'])
                            .where('person2', isEqualTo: currentUser.uid)
                            .get();

                        if (chat1.docs.length > 0) {
                          chatId = chat1.docs.first.id;
                          if (chat1.docs.first['person1'] == currentUser.uid) {
                            reciverId = chat1.docs.first['person2'];
                          } else if (chat1.docs.first['person2'] ==
                              currentUser.uid) {
                            reciverId = chat1.docs.first['person1'];
                          }
                        } else if (chat2.docs.length > 0) {
                          chatId = chat2.docs.first.id;
                          if (chat2.docs.first['person1'] == currentUser.uid) {
                            reciverId = chat2.docs.first['person2'];
                          } else if (chat2.docs.first['person2'] ==
                              currentUser.uid) {
                            reciverId = chat2.docs.first['person1'];
                          }
                        } else {
                          reciverId = data['id'];
                          chatId = '';
                        }
                        Get.to(UserChat(data['image_url'], data['name'],
                            reciverId!, chatId));
                      },
                      child: Icon(
                        Icons.message,
                        color: Colors.blue,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.user = data;
                        controller.showDialog(data['id'], data['name']);
                        controller.deleteUser(controller.user['id']);
                        // Get.to(EditUser());
                      },
                      child: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
              ],
            ))),
  );
}
