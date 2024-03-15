import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:http/http.dart';

class SendMessage {
  static Future<bool> sendFcmMessage(
      String title, String message, String fcmToken) async {
    try {
      var url = 'https://fcm.googleapis.com/fcm/send';
      var header = {
        "Content-Type": "application/json",
        "Authorization":
            "key=AAAAxF6GXHk:APA91bHf92CEpZhMuWX0YKxZgU2GOCRp18qpTKKUFfRAqiPFrWH96cuOeUF_IajP0HaFuHlOe3kxhQb0Kw-q9FAVucrKQo3WJbIiw09KSi2hbLvhiFeDjool8yAxaDjKL7E8SMMcjSg",
      };
      var request = {
        'notification': {'title': title, 'body': message},
        'data': {
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'type': 'COMMENT'
        },
        'to': "all",
      };

      var client = Client();
      await client.post(Uri.parse(url),
          headers: header, body: json.encode(request));
      return true;
    } catch (e, s) {
      print(e);
      return false;
    }
  }

  static void notifiy(String title, String message) async {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
      id: 1,
      channelKey: 'key1',
      title: title,
      body: message,
      icon: '@mipmap/ic_launcher',
      displayOnForeground: true,
      displayOnBackground: true,
      largeIcon: '@mipmap/ic_launcher',
    ));
  }
}
