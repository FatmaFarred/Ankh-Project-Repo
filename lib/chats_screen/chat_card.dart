import 'package:ankh_project/chats_screen/chating_screen.dart';
import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/constants/assets_manager.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){return ChatingScreen();}));
      },
      child: Container(
        padding: REdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            width: 0.9.w,
            color: const Color(0xFF7d7d7d).withOpacity(0.1),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(child: Image.asset(ImageAssets.carPic4,fit: BoxFit.fill,)),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "#conv-8432",
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: ColorManager.black,
                    ),
                  ),
                  Text(
                    "Would you like to schedule an inspection",
                    style: GoogleFonts.poppins(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff777777),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.w,),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "10:25 Pm",
                  style: GoogleFonts.poppins(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff777777),
                  ),
                ),
                SizedBox(height: 6.h,),
                Container(
                  padding: REdgeInsets.symmetric(vertical: 2,horizontal: 4.5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.r),
                    color: ColorManager.lightprimary,
                  ),
                    child: Text("3", style: GoogleFonts.roboto(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: ColorManager.white,
                    ),))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
