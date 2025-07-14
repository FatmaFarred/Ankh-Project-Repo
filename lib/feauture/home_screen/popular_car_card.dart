import 'package:ankh_project/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/feauture/details_screen/details_screen.dart';

class PopularCarCard extends StatelessWidget {
  final ProductEntity product;

  const PopularCarCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      /*onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  DetailsScreen(product: product,)),
        );
      },*/
      child: Container(
        width: 240.w,
        padding: REdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: const Color(0xFF131313).withOpacity(0.1),
            width: 0.9.w,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.network(
                  "https://ankhapi.runasp.net/${product.image}",
                  width: double.infinity,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) =>
                  Center(child: const Icon(Icons.broken_image, size: 40)),
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                Expanded(
                  child: Text(
                    product.title,
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: ColorManager.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                RatingBarIndicator(
                  rating: product.rating,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: ColorManager.starRateColor,
                  ),
                  itemCount: 1,
                  itemSize: 16.sp,
                  direction: Axis.horizontal,
                ),
                SizedBox(width: 4.w),
                Text(
                  product.rating.toStringAsFixed(1),
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorManager.hintColor,
                  ),
                ),
              ],
            ),
            Text(
              "${product.transmission} - ${product.status}",
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: ColorManager.hintColor,
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
    );
  }
}
