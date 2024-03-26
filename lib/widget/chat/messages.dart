import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'message_bubble.dart';

class Messages extends StatelessWidget {
  final String reciverId, senderId, chatId;
  Messages(this.senderId, this.reciverId, this.chatId);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('messages')
            // .where('chatId', isEqualTo: chatId)
            .orderBy('createdAt', descending: false)
            .snapshots(),
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
          var user = FirebaseAuth.instance.currentUser;
          if (user!.uid == senderId || user.uid == reciverId) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (docs[index]['chatId'] == chatId) {
                      var isMe;
                      isMe = docs[index]['senderId'] == user.uid ? true : false;
                      return MessageBubble(docs[index]['text'], isMe);
                    } else {
                      return Row();
                    }
                  }),
            );
          } else {
            return Row();
          }
        });
  }
}
