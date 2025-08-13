import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/feauture/home_screen/bottom_nav_bar.dart';
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

              // If we're in the bottom nav bar, navigate to home
              Navigator.pushReplacementNamed(context, BottomNavBar.bottomNavBarRouteName);

          },
        ),
        title: Text(AppLocalizations.of(context)!.chats),
        centerTitle: true,
        backgroundColor: ColorManager.lightprimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 100.sp,
            color: ColorManager.lightprimary,
          ),
          Text(AppLocalizations.of(context)!.notAvailableNow,
            style: Theme.of(context).textTheme.titleMedium,

          )
        ],),
      ),
    );
  }
}
