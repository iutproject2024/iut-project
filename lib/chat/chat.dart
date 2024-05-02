import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/scroll_controller.dart';
import '../widget/chat/online.dart';
import 'chatitem.dart';

class AllChats extends StatelessWidget {
  final int type;

  AllChats({super.key, required this.type});
  final ScrollToTopController sController = Get.put(ScrollToTopController());

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Expanded(flex: 2, child: Online(type: type)),
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
                        controller: sController.msgScroll,
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
