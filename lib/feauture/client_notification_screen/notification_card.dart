import 'package:ankh_project/core/constants/assets_manager.dart';
import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/domain/entities/notification_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../l10n/app_localizations.dart';

class NotificationCard extends StatelessWidget {
   NotificationCard({super.key,required this.notification});
  NotificationEntity notification;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          width: 0.9.w,
          color: const Color(0xFF7d7d7d).withOpacity(0.4),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(child: Image.asset(ImageAssets.appLogo)),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "إشعار",
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: ColorManager.black,
                  ),
                ),
                Text(
                  notification.message??"",
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff777777),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 10.w,),
          Text(
    "   ${notification
        .createdAt != null
    ? DateFormat('dd/MM/yyyy HH:mm').format(
    DateTime.parse(notification.createdAt!))
        : AppLocalizations.of(context)!.notAvailable}",
            style: GoogleFonts.poppins(
              fontSize: 11.sp,
              fontWeight: FontWeight.w400,
              color: Color(0xff777777),
            ),
          ),
        ],
      ),
    );
  }
}
