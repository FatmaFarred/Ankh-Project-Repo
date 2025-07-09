import 'package:ankh_project/feauture/home_screen/popular_cars_list.dart';
import 'package:ankh_project/feauture/home_screen/recommended_cars_list.dart';
import 'package:ankh_project/feauture/home_screen/section_header.dart';
import 'package:ankh_project/feauture/home_screen/top_brands_list.dart';
import 'package:ankh_project/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'header_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static String homeScreenRouteName = "HomeScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, _) => [
          const SliverToBoxAdapter(child: HeaderSection()),
          SliverToBoxAdapter(child: SizedBox(height: 28.h)),
        ],
        body: SingleChildScrollView(
          padding: REdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SectionHeader(title: AppLocalizations.of(context)!.topBrands),
              SizedBox(height: 8.h),
              const TopBrandsList(),
              SizedBox(height: 20.h),
              SectionHeader(
                title: AppLocalizations.of(context)!.popularNewCars,
              ),
              const SizedBox(height: 8),
              const PopularCarsList(),
              SizedBox(height: 20.h),
              SectionHeader(
                title: AppLocalizations.of(context)!.recommendedCars,
              ),
              const RecommendedCarsList(),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
