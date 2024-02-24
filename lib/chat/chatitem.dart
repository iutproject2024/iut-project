import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iutapp/chat/userchat.dart';

class ChatItem extends StatefulWidget {
  //شاشة الدردشة
  final String senderId, reciverId, chatId;

  ChatItem(this.senderId, this.reciverId, this.chatId);

  @override
  _ChatItemState createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  String? userImage, userName, lastMsg;
  int? counter;
  void getData() {
    var user = FirebaseAuth.instance.currentUser;

    FirebaseFirestore.instance
        .collection('messages')
        .where('chatId', isEqualTo: widget.chatId)
        .get()
        .then((value) {
      // setState(() {
      if (user!.uid == value.docs[0]['senderId']) {
        userImage = value.docs[0]['reciverImage'];
        userName = value.docs[0]['reciverName'];
      } else {
        userImage = value.docs[0]['senderImage'];
        userName = value.docs[0]['senderName'];
      }
      counter = value.docs.length;
      lastMsg = value.docs[counter! - 1]['text'];
      // });
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListTile(
        contentPadding: EdgeInsets.all(0),
        leading: Stack(
          children: <Widget>[
            InkWell(
              child: userImage != null
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(
                        "${userImage}",
                      ),
                      radius: 25,
                    )
                  : Text('No Image'),
              onTap: () {
                // ProfileScreen();
              },
            ),
            Positioned(
              bottom: 0.0,
              left: 6.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                height: 11,
                width: 11,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    height: 7,
                    width: 7,
                  ),
                ),
              ),
            ),
          ],
        ),
        title: Text(
          "${userName}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text("${lastMsg}"),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            SizedBox(height: 5),
            counter == 0
                ? SizedBox()
                : Container(
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 11,
                      minHeight: 11,
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 1, left: 5, right: 5),
                      child: Text(
                        "${counter.toString()}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
          ],
        ),
        onTap: () {
          Get.to(
              UserChat(userImage!, userName!, widget.reciverId, widget.chatId));
        },
      ),
    );
  }
}
