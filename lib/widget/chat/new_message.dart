import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iutapp/utils/appcolor.dart';

class NewMessage extends StatefulWidget {
  final String reciverId, chatId;
  NewMessage(this.reciverId, this.chatId);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();
  String _enteredMessage = "";

  _sendMessage() async {
    FocusScope.of(context).unfocus();
    var user = FirebaseAuth.instance.currentUser;
    var title, body, token;
    if (widget.chatId.length == 0) {
      var chat = FirebaseFirestore.instance.collection('chat').add({
        'person1': user!.uid,
        'person2': widget.reciverId,
      }).then((value) async {
        var sender = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        var reciver = await FirebaseFirestore.instance
            .collection('users')
            .doc(widget.reciverId)
            .get();

        FirebaseFirestore.instance.collection('messages').add({
          'chatId': value.id,
          'text': _enteredMessage,
          'createdAt': Timestamp.now(),
          'senderName': sender['name'],
          'reciverName': reciver['name'],
          'senderId': sender['id'],
          'reciverId': reciver['id'],
          'reciverImage': reciver['image_url'],
          'senderImage': sender['image_url'],
        }).then((value) {
          body = sender['username'] + ' send message to you ';
          FirebaseFirestore.instance.collection('notifications').add({
            'senderName': sender['name'],
            'reciverId': reciver['id'],
            'time': Timestamp.now(),
            'userImage': sender['image_url'],
            'senderId': sender['id'],
            'reciverImage': reciver['image_url'],
          }).then((value) {
            title = sender['name'] + ' send message to you ';
            body = _enteredMessage;
            token = reciver['token'];

            // SendMessage.sendFcmMessage(title, body, token);
          });
        });
      });
    } else {
      var chat = FirebaseFirestore.instance
          .collection('chat')
          .doc(widget.chatId)
          .get()
          .then((value) async {
        var sender = await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .get();
        var reciver = await FirebaseFirestore.instance
            .collection('users')
            .doc(widget.reciverId)
            .get();

        FirebaseFirestore.instance.collection('messages').add({
          'chatId': value.id,
          'text': _enteredMessage,
          'createdAt': Timestamp.now(),
          'senderName': sender['name'],
          'reciverName': reciver['name'],
          'senderId': sender['id'],
          'reciverId': reciver['id'],
          'reciverImage': reciver['image_url'],
          'senderImage': sender['image_url'],
        }).then((value) {
          FirebaseFirestore.instance.collection('notifications').add({
            'senderName': sender['name'],
            'reciverId': reciver['id'],
            'time': Timestamp.now(),
            'userImage': sender['image_url'],
            'senderId': sender['id'],
            'reciverImage': reciver['image_url'],
          }).then((value) {
            title = sender['name'] + ' send message to you ';
            body = _enteredMessage;
            token = reciver['token'];

            // SendMessage.sendFcmMessage(title, body, token);
          });
        });
      });
    }
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(top: 8),
      child: Row(children: [
        Expanded(
          child: TextField(
              autocorrect: true,
              enableSuggestions: true,
              textCapitalization: TextCapitalization.sentences,
              controller: _controller,
              style: TextStyle(
                color: AppColor.buttonColor,
              ),
              decoration: InputDecoration(
                  hintText: 'إرسال',
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: AppColor.buttonColor,
                  ))),
              onChanged: (val) {
                setState(() {
                  _enteredMessage = val;
                });
              }),
        ),
        IconButton(
            icon: Icon(
              Icons.send,
              color: AppColor.buttonColor,
            ),
            color: AppColor.buttonColor,
            onPressed: () {
              setState(() {
                _enteredMessage.trim().isEmpty ? null : _sendMessage();
              });
            })
      ]),
    );
  }
}
