import 'package:ankh_project/feauture/home_screen/recommended_car_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecommendedCarsList extends StatelessWidget {
  const RecommendedCarsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 4,
      separatorBuilder: (context, index) => SizedBox(height: 20.h),
      itemBuilder: (context, index) => const RecommendedCarCard(),
    );
  }
}
