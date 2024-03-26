import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iutapp/utils/appcolor.dart';

import '../../chat/userchat.dart';

class Online extends StatelessWidget {
  final int type;

  const Online({super.key, required this.type});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Stream<QuerySnapshot<Object?>> stream;

    if (type == 1)
      stream = FirebaseFirestore.instance.collection('users').snapshots();
    else
      stream = FirebaseFirestore.instance
          .collection('users')
          .where('typeuser', isEqualTo: type)
          .snapshots();

    return Container(
      height: size.height * .1,
      color:AppColor.buttonColor,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: StreamBuilder<QuerySnapshot>(
          stream: stream,
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: SizedBox(
                  height: size.height * .1,
                  width: size.width * .2,
                  child: CircularProgressIndicator(
                    color: Color.fromARGB(121, 206, 129, 51),
                  ),
                ),
              );
            }
            final docs = snapshot.data!.docs;
            final user = FirebaseAuth.instance.currentUser;
            return SizedBox(
              height: 70,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: docs.length,
                  itemBuilder: (contex, index) {
                    if (user!.uid != docs[index]['id']) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 15, left: 15),
                        child: Column(
                          children: [
                            InkWell(
                              child: CircleAvatar(
                                radius: 21.0,
                                backgroundImage:
                                    NetworkImage(docs[index]['image_url']),
                              ),
                              onTap: () async {
                                String? reciverId, chatId = '';
                                var chat1 = await FirebaseFirestore.instance
                                    .collection('chat')
                                    .where('person1', isEqualTo: user.uid)
                                    .where('person2',
                                        isEqualTo: docs[index]['id'])
                                    .get();
                                var chat2 = await FirebaseFirestore.instance
                                    .collection('chat')
                                    .where('person1',
                                        isEqualTo: docs[index]['id'])
                                    .where('person2', isEqualTo: user.uid)
                                    .get();
                                if (chat1.docs.length > 0) {
                                  chatId = chat1.docs.first.id;
                                  if (chat1.docs.first['person1'] == user.uid) {
                                    reciverId = chat1.docs.first['person2'];
                                  } else if (chat1.docs.first['person2'] ==
                                      user.uid) {
                                    reciverId = chat1.docs.first['person1'];
                                  }
                                } else if (chat2.docs.length > 0) {
                                  chatId = chat2.docs.first.id;
                                  if (chat2.docs.first['person1'] == user.uid) {
                                    reciverId = chat2.docs.first['person2'];
                                  } else if (chat2.docs.first['person2'] ==
                                      user.uid) {
                                    reciverId = chat2.docs.first['person1'];
                                  }
                                } else {
                                  reciverId = docs[index]['id'];
                                }
                                Get.to(UserChat(docs[index]['image_url'],
                                    docs[index]['name'], reciverId!, chatId));
                              },
                            ),
                            // Text(docs[index]['name']),
                          ],
                        ),
                      );
                    } else {
                      return Row();
                    }
                  }),
            );
          }),
    );
  }
}
