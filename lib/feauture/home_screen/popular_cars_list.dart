import 'package:ankh_project/feauture/home_screen/popular_car_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PopularCarsList extends StatelessWidget {
  const PopularCarsList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 208.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        separatorBuilder: (context, index) => SizedBox(width: 20.w),
        itemBuilder: (context, index) => const PopularCarCard(),
      ),
    );
  }
}
