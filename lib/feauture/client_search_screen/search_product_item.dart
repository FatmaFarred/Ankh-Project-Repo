import 'package:ankh_project/core/constants/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/color_manager.dart';
import '../../../../domain/entities/all_products_entity.dart';
import '../details_screen/details_screen.dart';

class SearchProductItem extends StatelessWidget {
  final AllProductsEntity product;

  const SearchProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final imageUrl = product.image?.isNotEmpty == true
        ? 'https://ankhapi.runasp.net/${product.image}'
        : null;

    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          DetailsScreen.detailsScreenRouteName,
          arguments: product.id,
        );
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
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: imageUrl != null
                        ? Center(
                          child: Image.network(
                              imageUrl,
                              height: 80.h,
                              fit: BoxFit.contain,
                              errorBuilder: (_, _, _) => _placeholderImage(),
                            ),
                        )
                        : _placeholderImage(),
                  ),
                  Positioned(
                    right: 2.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(9.r),
                          color: ColorManager.rateContainer
                      ),
                      child: Row(
                        children: [
                          RatingBarIndicator(

                            rating: (product.rating ?? 0).toDouble(),
                            itemBuilder: (context, _) =>  Icon(
                              Icons.star,
                              color: ColorManager.rateColor,

                            ),
                            itemCount: 1,
                            itemSize: 16.sp,
                            direction: Axis.horizontal,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                              product.rating?.toStringAsFixed(1) ?? "0.0",
                              style: Theme.of(context).textTheme.labelSmall
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(width: 13.w),
            Expanded(flex: 3, child: _buildProductDetails()),
          ],
        ),
      ),
    );
  }

  Widget _placeholderImage() {
    return Center(child: Image.asset(ImageAssets.brokenImage, height: 90.h));
  }

  Widget _buildProductDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.title ?? '',
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: ColorManager.black,
          ),
        ),
        SizedBox(height: 13.h),
        Text(
          product.transmission ?? '',
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
          "EGP ${product.price ?? ''}",
          style: GoogleFonts.poppins(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: ColorManager.lightprimary,
          ),
        ),
      ],
    );
  }
}
