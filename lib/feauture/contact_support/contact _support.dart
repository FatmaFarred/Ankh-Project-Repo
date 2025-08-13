import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class CallScreen extends StatelessWidget {
  final String phoneNumber = '+201234567890'; // Replace with your number

  void openDialer() async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);

    // Directly launch without canLaunchUrl
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Call Example')),
      body: Center(
        child: IconButton(
          icon: Icon(Icons.call, size: 50, color: Colors.green),
          onPressed: openDialer, // Directly opens the phone app
        ),
      ),
    );
  }
}
