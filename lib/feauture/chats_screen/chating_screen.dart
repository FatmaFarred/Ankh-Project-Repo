import 'package:ankh_project/core/constants/assets_manager.dart';
import 'package:ankh_project/feauture/chats_screen/widgets/input_field.dart';
import 'package:ankh_project/feauture/chats_screen/widgets/message_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/color_manager.dart';
import '../../l10n/app_localizations.dart';

class ChatMessage {
  final String text;
  final bool isMe;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isMe,
    required this.timestamp,
  });
}

class ChatingScreen extends StatefulWidget {
  const ChatingScreen({super.key});

  @override
  State<ChatingScreen> createState() => _ChatingScreenState();
}

class _ChatingScreenState extends State<ChatingScreen> {
  final List<ChatMessage> _messages = [
    ChatMessage(
      text: "Hello !",
      isMe: false,
      timestamp: DateTime.now().subtract(Duration(minutes: 5)),
    ),
    ChatMessage(
      text: "Hello !",
      isMe: true,
      timestamp: DateTime.now().subtract(Duration(minutes: 4)),
    ),
    ChatMessage(
      text: "Yes, it's available. Would you like to schedule an inspection",
      isMe: false,
      timestamp: DateTime.now().subtract(Duration(minutes: 3)),
    ),
  ];

  void _handleMessageSent(String message) {
    setState(() {
      _messages.add(ChatMessage(
        text: message,
        isMe: true,
        timestamp: DateTime.now(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          color: ColorManager.lightprimary,
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_horiz_rounded,
              color: ColorManager.lightprimary,
            ),
          ),
        ],
        title: Text(
          AppLocalizations.of(context)!.message,
          style: TextStyle(color: ColorManager.lightprimary),
        ),
        centerTitle: true,
        backgroundColor: ColorManager.white,
      ),
      body: Container(
        decoration: BoxDecoration(color: ColorManager.white),
        child: Column(
          children: [
            Padding(
              padding: REdgeInsets.all(25.0),
              child: Row(
                children: [
                  CircleAvatar(child: Image.asset(ImageAssets.profilePic)),
                  SizedBox(width: 16.w,),
                  Text(
                    "#conv-8432",
                    style: GoogleFonts.roboto(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: ColorManager.lightprimary,
                    ),
                  ),
                  Spacer(),
                  IconButton(onPressed: (){}, icon: Icon(Icons.phone,color: ColorManager.lightprimary,))
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return Massage(
                    text: message.text,
                    IsMe: message.isMe,
                    timestamp: message.timestamp,
                  );
                },
              ),
            ),
            InputField(onMessageSent: _handleMessageSent),
          ],
        ),
      ),
    );
  }
}
