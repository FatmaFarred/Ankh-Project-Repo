import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'chat_card.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          color: Colors.white,
          onPressed: () {
            // Navigate to home screen (index 0) instead of popping
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              // If we're in the bottom nav bar, navigate to home
              Navigator.pushReplacementNamed(context, 'BottomNavBar');
            }
          },
        ),
        title: Text(AppLocalizations.of(context)!.chats),
        centerTitle: true,
        backgroundColor: ColorManager.lightprimary,
      ),
      body: Padding(
        padding: REdgeInsets.all(20.0),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: 6,
          separatorBuilder: (context, index) => SizedBox(height: 10.h),
          itemBuilder: (context, index) {
            return ChatCard();
          },
        ),
      ),
    );
  }
}
