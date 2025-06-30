import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ankh_project/feauture/home_screen/car_brand_item.dart';

class TopBrandsList extends StatelessWidget {
  const TopBrandsList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 59,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        separatorBuilder: (context, index) => SizedBox(width: 12.w),
        itemBuilder: (context, index) => const CarBrandItem(),
      ),
    );
  }
}
