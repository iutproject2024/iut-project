import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts_arabic/fonts.dart';

import '../page/login_screen.dart';
// import '../page/profile.dart';
// import '../widget/chat/online.dart';
import '../widget/chat/online.dart';
import 'chatitem.dart';

class AllChats extends StatefulWidget {
  final int type;

  const AllChats({super.key, required this.type});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<AllChats> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Expanded(flex: 2, child: Online(type: widget.type)),
          Expanded(
            flex: 15,
            child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('chat').snapshots(),
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
                  final user = FirebaseAuth.instance.currentUser;
                  final docs = snapshot.data!.docs;
                  return SizedBox(
                    width: size.width * .9,
                    child: ListView.builder(
                        itemCount: docs.length,
                        itemBuilder: (contex, index) {
                          String? reciver;
                          if (docs[index]['person1'] == user!.uid ||
                              docs[index]['person2'] == user.uid) {
                            if (docs[index]['person1'] == user.uid) {
                              reciver = docs[index]['person2'];
                            } else if (docs[index]['person2'] == user.uid) {
                              reciver = docs[index]['person1'];
                            }
                            return ChatItem(user.uid, reciver!, docs[index].id);
                          } else {
                            return Row();
                          }
                        }),
                  );
                }),
          )
        ],
      ),
    );
  }
}
