import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
class FirebaseMessagingService {
  static Future<void> sendNotification({
    required String targetFcmToken,
    required String title,
    required String body,
  }) async {
    // Path to the downloaded service account JSON file
    final serviceAccountJson = await rootBundle.loadString(
      'assets/ankh-project-firebase-adminsdk-fbsvc-3a01e97de6.json',
    );

    final credentials = ServiceAccountCredentials.fromJson(serviceAccountJson);

    final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];

    final client = await clientViaServiceAccount(credentials, scopes);

    final projectId = "ankh-project";

    final url = Uri.parse(
        'https://fcm.googleapis.com/v1/projects/$projectId/messages:send');

    final message = {
      'message': {
        'token': targetFcmToken,
        'notification': {
          'title': title,
          'body': body,
        },
        'android': {
          'priority': 'high',
        }
      }
    };

    final response = await client.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(message),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}
