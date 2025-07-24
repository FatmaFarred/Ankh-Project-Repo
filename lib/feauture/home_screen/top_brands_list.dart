import 'package:ankh_project/core/constants/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ankh_project/feauture/home_screen/car_brand_item.dart';

class TopBrandsList extends StatelessWidget {
   TopBrandsList({super.key});
  final List<String> brandImages = [
    ImageAssets.carBrandLogo, // replace with multiple logos
    ImageAssets.carBrandLogo2,
    ImageAssets.carBrandLogo3,
    ImageAssets.carBrandLogo4,
    ImageAssets.carBrandLogo5,
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 59,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        separatorBuilder: (context, index) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          return CarBrandItem(imagePath: brandImages[index]);
        },
      ),
    );
  }
}
