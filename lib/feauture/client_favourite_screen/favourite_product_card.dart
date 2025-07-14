import 'package:ankh_project/core/constants/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/color_manager.dart';

class FavouriteProductCard extends StatelessWidget {
  const FavouriteProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          width: 0.9.w,
          color: const Color(0xFF7d7d7d).withOpacity(0.4),
        ),
      ),
      child: Row(
        children: [
          // Image section
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.asset(ImageAssets.carPic1, fit: BoxFit.cover),

              // child: Image.network(
              //   'https://ankhapi.runasp.net/${product.image}',
              //   height: 80.h,
              //   fit: BoxFit.contain,
              //   errorBuilder: (_, __, ___) => Center(child: const Icon(Icons.broken_image)),
              // ),
            ),
          ),
          SizedBox(width: 14.w),

          // Info section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "product.title",
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: ColorManager.black,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.delete_outline_rounded,
                        color: Colors.red,
                        size: 20.sp,
                      ),
                    ),
                  ],
                ),
                Text(
                  "product.transmission",
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorManager.hintColor,
                  ),
                ),
                SizedBox(height: 13.h),
                Text(
                  "Price",
                  style: GoogleFonts.montserrat(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    color: ColorManager.darkGrey,
                  ),
                ),
                Text(
                  "5000 EGP ",
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: ColorManager.lightprimary,
                  ),
                ),
              ],
            ),
          ),
          // IconButton(
          //   onPressed: () {},
          //   icon: Icon(
          //     Icons.delete_outline_rounded,
          //     color: Colors.red,
          //     size: 20.sp,
          //   ),
          // ),
        ],
      ),
    );
  }
}
