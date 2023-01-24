import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;

Future<bool> callOnFcmApiSendPushNotifications(
    {required String title, required String body}) async {
  const postUrl = 'https://fcm.googleapis.com/fcm/send';
  final data = {
    "to": "/topics/Penukaran",
    "notification": {
      "title": title,
      "body": body,
    },
    "data": {
      "type": '0rder',
      "id": '28',
      "click_action": 'FLUTTER_NOTIFICATION_CLICK',
    }
  };

  final headers = {
    'content-type': 'application/json',
    'Authorization':
        'key=AAAAqIUqR8c:APA91bHO0V18yMmdWLzx73WzpWJloJ4bckYNcoku-vNRyACF7Y39ou72HygFQirihkWY0ri_xGvnx9NtAy-MQhIGRuobSg4zS5_M7Swjr-vx1VMrD4AOl2InWIriaS5TrHRS_P2sEkcm' // 'key=YOUR_SERVER_KEY'
  };

  final response = await http.post(Uri.parse(postUrl),
      body: json.encode(data),
      encoding: Encoding.getByName('utf-8'),
      headers: headers);

  if (response.statusCode == 200) {
    // on success do sth
    print('test ok push CFM');
    return true;
  } else {
    print(' CFM error');
    // on failure do sth
    return false;
  }
}
