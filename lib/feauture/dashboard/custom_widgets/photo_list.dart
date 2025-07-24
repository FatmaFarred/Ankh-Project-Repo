import 'package:ankh_project/feauture/home_screen/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../l10n/app_localizations.dart';

class PhotoList extends StatelessWidget {
  final List<String> imageUrls;

  const PhotoList({super.key, required this.imageUrls});

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
          SectionHeader(title: "",imageUrl:imageUrls,),
          SizedBox(height: 8.h),
          if (imageUrls.isEmpty)
            Center(
              child: Text(
                AppLocalizations.of(context)!.noPhotosAvailable,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey,
                ),
              ),
            )
          else
            SizedBox(
              height: 90.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: imageUrls.length,
                itemBuilder: (_, index) => Container(
                  width: 120.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: const Color(0xFFF9FAFB),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: Image.network(
                      "https://ankhapi.runasp.net/${imageUrls[index]}",
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
                    ),
                  ),
                ),
                separatorBuilder: (_, __) => SizedBox(width: 10.w),
              ),
            ),
        ],
      ),
    );
  }
}
