import 'package:ankh_project/core/constants/assets_manager.dart';
import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AddCommentSection extends StatelessWidget {
  const AddCommentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return             Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [

          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundImage: AssetImage(ImageAssets.profilePic),
                ),
                 SizedBox(width: 8.h),
                Expanded(
                  child: TextField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Add Comment',
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  ),
                ),

              ],
            ),
          ),
           SizedBox(width: 12.h),

          Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  // Handle post
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.lightprimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Post',
                  style: GoogleFonts.cairo(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                    color: ColorManager.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
