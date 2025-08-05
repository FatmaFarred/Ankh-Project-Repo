import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@injectable
class FirebaseMessagingService {
  Future<void> sendNotification({
    required String targetFcmToken,
    required String title,
    required String body,
  }) async {
    try {
      // 🔐 Load the service account credentials from the JSON file in assets
      final serviceAccountJson = await rootBundle.loadString(
        'assets/ankh-project-firebase-adminsdk-fbsvc-fd74501130.json',
      );

      final credentials = ServiceAccountCredentials.fromJson(serviceAccountJson);

      // 🔭 Define the required scope for Firebase Cloud Messaging
      final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];

      // 🔄 Obtain a client that manages access tokens automatically
      final client = await clientViaServiceAccount(credentials, scopes);

      // ✅ Access token info for debugging/logging
      final accessToken = client.credentials.accessToken;
      print('✅ Access Token: ${accessToken.data}');
      print('📆 Expires at: ${accessToken.expiry}');

      // 🔧 Set the FCM v1 endpoint with your Firebase project ID
      final projectId = "ankh-project";
      final url = Uri.parse(
        'https://fcm.googleapis.com/v1/projects/$projectId/messages:send',
      );

      // ✉️ Construct the notification payload
      final message = {
        'message': {
          'token': targetFcmToken,
          'notification': {
            'title': title,
            'body': body,
          },
          'android': {
            'priority': 'high',
          },
        },
      };

      // 🚀 Send the HTTP POST request with the message
      final response = await client.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(message),
      );

      // 📝 Log the response
      print('📦 Response status: ${response.statusCode}');
      print('📨 Response body: ${response.body}');
    } catch (e, stackTrace) {
      print('❌ Failed to send notification: $e');
      print('🔍 StackTrace: $stackTrace');
    }
  }
}
