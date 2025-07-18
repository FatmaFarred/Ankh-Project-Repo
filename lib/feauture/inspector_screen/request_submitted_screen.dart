import 'package:ankh_project/core/constants/assets_manager.dart';
import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/feauture/inspector_screen/inspector_bottom_nav_bar.dart';
import 'package:ankh_project/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;

import '../../core/customized_widgets/reusable_widgets/customized_elevated_button.dart';

class RequestSubmittedScreen extends StatelessWidget {
  const RequestSubmittedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Reports Screen"),
        centerTitle: true,
        backgroundColor: ColorManager.lightprimary,
      ),
      body: Padding(
        padding:  REdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(ImageAssets.successIcon),
            SizedBox(height: 38.h),
            Text(
              AppLocalizations.of(context)!.requestSubmittedSuccessfully,
              style: GoogleFonts.poppins(
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
                color: ColorManager.lightprimary,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              AppLocalizations.of(context)!.requestSubmittedNote,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: ColorManager.lightprimary,
              ),
            ),
            SizedBox(height: 56.h),

            CustomizedElevatedButton(
              bottonWidget: Text(
                AppLocalizations.of(context)!.goToMyRequests,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: ColorManager.white,
                  fontSize: 16.sp,
                ),
              ),
              color: Theme.of(context).primaryColor,
              borderColor: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context){return InspectorBottomNavBar();}));
              },
            ),
          ],
        ),
      ),
    );
  }
}
