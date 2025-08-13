import 'package:ankh_project/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ankh_project/core/constants/assets_manager.dart';
import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportTeamSection extends StatelessWidget {
  const SupportTeamSection({super.key, this.supportPhoneNumber = '01558780486'});

  final String supportPhoneNumber;

  Future<void> _openDialer(String phoneNumber) async {
    final Uri telUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(telUri)) {
      await launchUrl(telUri);
    } else {
      throw 'Could not launch $telUri';
    }
  }

   Future<void> _openWhatsApp(String phoneNumber) async {
    final String normalized = phoneNumber.replaceAll(RegExp(r'\D'), '');
    final String url = 'https://wa.me/20$normalized'; // Adjust country code as needed
    final Uri whatsappUri = Uri.parse(url);
    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch WhatsApp. Make sure the app is installed or number is valid.';
    }
  }

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
        InkWell(onTap: () { _openWhatsApp(supportPhoneNumber); }, child: _buildActionIcon(Icons.message_rounded)),
        SizedBox(width: 8.w),
        InkWell(onTap: () { _openDialer(supportPhoneNumber); }, child: _buildActionIcon(Icons.call)),
      ],
    );
  }
}
