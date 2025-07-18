import 'package:ankh_project/feauture/home_screen/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ankh_project/core/constants/assets_manager.dart';
import '../../details_screen/widgets/section_title.dart';

class PhotoListView extends StatelessWidget {
  const PhotoListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xff777777).withOpacity(0.5)),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: "Product Photos"),
          SizedBox(height: 8.h),
          SizedBox(
            height: 90.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (_, index) => Container(
                width: 120.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: const Color(0xFFF9FAFB),
                ),
                child: Image.asset(ImageAssets.brokenImage),
              ),
              separatorBuilder: (_, __) => SizedBox(width: 10.w),
            ),
          ),
        ],
      ),
    );
  }
}
