import 'package:ankh_project/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ankh_project/core/constants/assets_manager.dart';
import 'package:ankh_project/core/constants/color_manager.dart';

class SupportTeamSection extends StatelessWidget {
  const SupportTeamSection({super.key});

  Widget _buildActionIcon(IconData icon) => Container(
    height: 36,
    width: 36,
    decoration: BoxDecoration(
      color: const Color(0xffF9FAFB),
      borderRadius: BorderRadius.circular(30),
    ),
    child: Icon(icon, color: ColorManager.lightprimary, size: 18.sp),
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(ImageAssets.supportTeamIcon),
        SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.supportTeam,
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: ColorManager.black,
                )),
            Text(AppLocalizations.of(context)!.chatNow,
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff9E9E9E),
                )),
          ],
        ),
        const Spacer(),
        InkWell(onTap: () {}, child: _buildActionIcon(Icons.message_rounded)),
        SizedBox(width: 8.w),
        InkWell(onTap: () {}, child: _buildActionIcon(Icons.call)),
      ],
    );
  }
}
