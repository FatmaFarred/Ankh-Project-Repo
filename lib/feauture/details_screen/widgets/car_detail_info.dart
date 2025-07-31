import 'package:ankh_project/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ankh_project/core/constants/assets_manager.dart';
import 'package:ankh_project/core/constants/color_manager.dart';

import '../../../domain/entities/product_details_entity.dart';
import '../../../domain/entities/product_entity.dart';

class CarDetailInfo extends StatelessWidget {
  final ProductDetailsEntity product;

  const CarDetailInfo({super.key, required this.product});

  Widget _buildDetailItem(String iconPath, String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(iconPath, width: 40.w, height: 40.h),
        SizedBox(width: 16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(fontSize: 12.sp, color: Colors.grey),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4.h),
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: [
              _buildDetailItem(ImageAssets.batteryIcon, AppLocalizations.of(context)!.batteryCapacity,
                "${product?.batteryCapacity ?? ""} kwh",),
              SizedBox(height: 16.h),
              _buildDetailItem(ImageAssets.hpIcon, AppLocalizations.of(context)!.horsepower,
                "${product?.horsepower ?? 0} bhp",),
            ],
          ),
        ),
        SizedBox(width: 20.w),
        Expanded(
          child: Column(
            children: [
              _buildDetailItem(ImageAssets.transIcon, AppLocalizations.of(context)!.transmission, product?.transmission??"",),
              SizedBox(height: 16.h),
              _buildDetailItem(ImageAssets.engineIcon, AppLocalizations.of(context)!.engineType,  product?.engineType??"",),
            ],
          ),
        ),
      ],
    );
  }
}