import 'package:ankh_project/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ankh_project/core/constants/assets_manager.dart';
import 'package:ankh_project/core/constants/color_manager.dart';

import '../../../domain/entities/product_entity.dart';

class CarDetailInfo extends StatelessWidget {
  final ProductEntity product;

  const CarDetailInfo({super.key, required this.product});

  Widget _buildDetailItem(String iconPath, String title, String value) {
    return Row(
      children: [
        Image.asset(iconPath),
        SizedBox(width: 16.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(fontSize: 12.sp, color: Colors.grey),
            ),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
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
              _buildDetailItem(ImageAssets.batteryIcon, AppLocalizations.of(context)!.batteryCapacity, "75 KWh"),
              SizedBox(height: 16.h),
              _buildDetailItem(ImageAssets.hpIcon, AppLocalizations.of(context)!.horsepower, "184 bhp"),
            ],
          ),
        ),
        SizedBox(width: 20.w),
        Expanded(
          child: Column(
            children: [
              _buildDetailItem(ImageAssets.transIcon, AppLocalizations.of(context)!.transmission, product.transmission,),
              SizedBox(height: 16.h),
              _buildDetailItem(ImageAssets.engineIcon, AppLocalizations.of(context)!.engineType, "Petrol"),
            ],
          ),
        ),
      ],
    );
  }
}