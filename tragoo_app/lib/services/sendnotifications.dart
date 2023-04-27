import 'dart:convert';
import 'package:http/http.dart' as http;

class SendPushNotification {
  static String serverKey =
      'key=AAAAIINLaqY:APA91bH3nc7ZfnqzRKv2fXkN-vxiONYGUW2lxIiZAGbyWbduugq-OJO6tUPbYWMmcU3WZkapVcWSlvMmL03qqJfrYRYOZlYA9ePfgiqsE1Ll8FZ_YOgCtmB5EIK-qHhhOhwJKh4yPr15';

  void sendOrderPushNotificationsToAdmins(
      String body, String title, String token, orderid, orderamount) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': serverKey,
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': body,
              'title': title,
            },
            'priority': 'high',
            "data": {"order_id": orderid, "order_amount": orderamount},
            "to": token,
          },
        ),
      );
    } catch (e) {
      print(e);
    }
  }
}
