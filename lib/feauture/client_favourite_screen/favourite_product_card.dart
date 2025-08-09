
import 'package:ankh_project/core/constants/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../api_service/api_constants.dart';
import '../../core/constants/color_manager.dart';
import '../../domain/entities/product_details_entity.dart';
import '../../l10n/app_localizations.dart';

class FavouriteProductCard extends StatelessWidget {
  ProductDetailsEntity product;
  VoidCallback onDelete;
  
  FavouriteProductCard({
    super.key,
    required this.product,
    required this.onDelete,
  });

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
            flex: 2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Container(
                height: 80.h,
                width: 80.w,
                child: Image.network(
                  '${ApiConstant.imageBaseUrl}${product.image}',
                  height: 80.h,
                  width: 80.w,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      height: 80.h,
                      width: 80.w,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.grey.shade600),
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (_, __, ___) => Container(
                    height: 80.h,
                    width: 80.w,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Image.asset(
                      ImageAssets.brokenImage,
                      height: 80.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 14.w),

          // Info section
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        product.title ?? "No Title",
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: ColorManager.black,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      onPressed: onDelete,
                      icon: Icon(
                        Icons.delete_outline_rounded,
                        color: Colors.red,
                        size: 20.sp,
                      ),
                      tooltip: 'Remove from favorites',
                    ),
                  ],
                ),
                if (product.transmission != null && product.transmission!.isNotEmpty)
                  Text(
                    product.transmission!,
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: ColorManager.hintColor,
                    ),
                  ),
                SizedBox(height: 8.h),
                Text(
                  AppLocalizations.of(context)!.price,
                  style: GoogleFonts.montserrat(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    color: ColorManager.darkGrey,
                  ),
                ),
                Text(
                  product.price ?? "Price not available",
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
    );
  }

}
