import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/feauture/client_notification_screen/notification_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' ;

import '../../l10n/app_localizations.dart';

class ClientNotificationScreen extends StatelessWidget {
  const ClientNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(AppLocalizations.of(context)!.notifications),
        centerTitle: true,
        backgroundColor: ColorManager.lightprimary,
      ),
      body:Padding(
        padding: REdgeInsets.all(20.0),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: 6,
          separatorBuilder: (context, index) => SizedBox(height: 10.h),
          itemBuilder: (context, index) {
            return NotificationCard();
          },
        ),
      ),
    );
  }
}
