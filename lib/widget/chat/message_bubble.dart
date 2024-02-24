import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;

  MessageBubble(this.message, this.isMe);
  var user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    // isMe = user.uid == senderId ? true : false;
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              !isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: !isMe ? Colors.grey[300] : Colors.green[300],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14),
                  topRight: Radius.circular(14),
                  bottomLeft: isMe ? Radius.circular(0) : Radius.circular(14),
                  bottomRight: !isMe ? Radius.circular(0) : Radius.circular(14),
                ),
              ),
              // width: size.width * .7,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Column(
                crossAxisAlignment:
                    !isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    message,
                    style: TextStyle(
                      color: !isMe
                          ? Colors.black
                          : Theme.of(context).accentTextTheme.headline6!.color,
                    ),
                    textAlign: !isMe ? TextAlign.end : TextAlign.start,
                  ),
                ],
              ),
            )
          ],
        ),
      ],
      // overflow: Overflow.visible,
    );
  }
}
