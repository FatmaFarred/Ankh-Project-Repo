import 'package:ankh_project/core/constants/assets_manager.dart';
import 'package:ankh_project/feauture/chats_screen/widgets/input_field.dart';
import 'package:ankh_project/feauture/chats_screen/widgets/message_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/color_manager.dart';
import '../../l10n/app_localizations.dart';


class ChatingScreen extends StatelessWidget {
  const ChatingScreen({super.key});

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
              child: ListView(
                children: [
                  Massage(text: "Hello !", IsMe: false),
                  Massage(text: "Hello !", IsMe: true),
                  Massage(
                    text:
                        "Yes, it's available. Would you like to schedule an inspection",
                    IsMe: false,
                  ),
                ],
              ),
            ),
            InputField(),
          ],
        ),
      ),
    );
  }
}
