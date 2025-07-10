import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/domain/entities/product_entity.dart';
import 'package:ankh_project/feauture/details_screen/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class RecommendedCarCard extends StatelessWidget {
  final ProductEntity product;

  const RecommendedCarCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) =>  DetailsScreen(product: product,)));
      },
      child: Container(
        padding: REdgeInsets.symmetric(vertical: 18, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            width: 0.9.w,
            color: const Color(0xFF131313).withOpacity(0.1),
          ),
        ),
        child: Row(
          children: [
            // Image section
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.network(
                  'https://ankhapi.runasp.net/${product.image}',
                  height: 80.h,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => Center(child: const Icon(Icons.broken_image)),
                ),
              ),
            ),
            SizedBox(width: 13.w),

            // Info section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: ColorManager.black,
                    ),
                  ),
                  SizedBox(height: 13.h),
                  Text(
                    product.transmission,
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
                    "EGP ${product.price}",
                    style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: ColorManager.lightprimary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
