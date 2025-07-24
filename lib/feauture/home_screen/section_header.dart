import 'package:ankh_project/feauture/details_screen/all_Images_screen.dart';
import 'package:ankh_project/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ankh_project/core/constants/color_manager.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final List<String>?  imageUrl ;

  const SectionHeader({super.key, required this.title,this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => AllImagesScreen(imageUrl:imageUrl??[],),
              ),
            );
          },
          child: Text(
            AppLocalizations.of(context)!.viewAll,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: ColorManager.lightprimary,
            ),
          ),
        ),
      ],
    );
  }
}
