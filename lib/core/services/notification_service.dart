import 'dart:convert';

import 'package:http/http.dart' as http;

void sendPushMessage({
  required String token,
  required String body,
  required String title,
}) async {
  await http.post(
    Uri.parse('https://fcm.googleapis.com/fcm/send'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization':
          'key=AAAAYMmNBZc:APA91bFlaa-06JOI7rIoZZntje6bLWA0n315qk4gRNuqHHSg9dMR0aLANtdzQ1bfAyStvainSPbkMkYAC8ggwuiMW9WEfUmUqiVwqn7RezOC6fXB-4MdBF80zBg4qpv0t4JkKKo03Exn',
    },
    body: jsonEncode(<String, dynamic>{
      'to':token,
      'priority': "high",
      'data': <String, dynamic>{
        'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        'status': 'done',
        'body': body,
        'title': title,
      },
      'notification': <String, dynamic>{
        'body': body,
        'title': title,
      },
    }),
  );
}
