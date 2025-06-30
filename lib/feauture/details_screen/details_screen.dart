import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:ankh_project/core/constants/assets_manager.dart';
import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import 'package:ankh_project/feauture/home_screen/section_header.dart';

import '../../l10n/app_localizations.dart';
import 'widgets/car_image_slider.dart';
import 'widgets/car_detail_info.dart';
import 'widgets/section_title.dart';
import 'widgets/support_team_section.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final PageController _pageController = PageController();
  final List<String> images = [
    ImageAssets.carPic1,
    ImageAssets.carPic2,
    ImageAssets.carPic3,
    ImageAssets.carPic1,
  ];
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildSmallText(String text, Color color) => Text(
    text,
    style: GoogleFonts.poppins(
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      color: color,
    ),
  );

  Widget _buildSectionDivider() =>
      Divider(thickness: 1, color: const Color(0xff91929526).withOpacity(0.15));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back), // Cupertino back icon
          color: Colors.white, // White color
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(AppLocalizations.of(context)!.details),
        centerTitle: true,
        backgroundColor: ColorManager.lightprimary,
        titleTextStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          fontSize: 20.sp,
        ),
      ),
      body: SingleChildScrollView(
        padding: REdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarImageSlider(
              pageController: _pageController,
              images: images,
              currentIndex: _currentIndex,
              onPageChanged: (index) => setState(() => _currentIndex = index),
            ),
            SizedBox(height: 16.h),

            // Title & Rating
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Toyota EX30",
                        style: GoogleFonts.manrope(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: ColorManager.lightprimary,
                        ),
                      ),
                      Row(
                        children: [
                          RatingBarIndicator(
                            rating: 5,
                            itemBuilder: (context, index) => const Icon(
                              Icons.star,
                              color: ColorManager.starRateColor,
                            ),
                            itemCount: 1,
                            itemSize: 16.sp,
                          ),
                          SizedBox(width: 4),
                          _buildSmallText("5.0", ColorManager.hintColor),
                          SizedBox(width: 8),
                          Icon(
                            Icons.verified_outlined,
                            size: 12.sp,
                            color: ColorManager.lightprimary,
                          ),
                          _buildSmallText(
                            AppLocalizations.of(context)!.verified,
                            const Color(0xFF4B5563),
                          ),
                          SizedBox(width: 8),
                          ImageIcon(
                            AssetImage(ImageAssets.onlineIcon),
                            size: 16,
                          ),
                          _buildSmallText(
                            AppLocalizations.of(context)!.online,
                            const Color(0xFF4B5563),
                          ),
                        ],
                      ),
                      _buildSmallText(
                        "Automatic - Electric",
                        const Color(0xFF404147),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Text(
                    "EGP 1.9M",
                    style: GoogleFonts.poppins(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: ColorManager.lightprimary,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 34.h),
            _buildSectionDivider(),

            SectionTitle(title: AppLocalizations.of(context)!.description),
            SizedBox(height: 4.h),
            Text(
              "Electric sedan with autopilot features and long-range battery. Full service history, low mileage, excellent condition. Premium sound system, leather seats, and advanced driver assistance.",
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                color: const Color(0xff404147),
              ),
            ),
            SizedBox(height: 12.h),
            _buildSmallText(
              "${AppLocalizations.of(context)!.created}: 6/20/2025",
              const Color(0xff6B7280),
            ),
            _buildSmallText(
              "${AppLocalizations.of(context)!.lastEdited}: 6/20/2025",
              const Color(0xff6B7280),
            ),
            _buildSectionDivider(),

            SizedBox(height: 24.h),
            SectionTitle(title: AppLocalizations.of(context)!.details),
            SizedBox(height: 12.h),
            const CarDetailInfo(),

            SizedBox(height: 16.h),
            SectionHeader(title: AppLocalizations.of(context)!.images),
            SizedBox(
              height: 115.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: images.length,
                itemBuilder: (context, index) => Container(
                  width: 115.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: const Color(0xFFF9FAFB),
                  ),
                  child: Image.asset(images[index], fit: BoxFit.contain),
                ),
                separatorBuilder: (context, index) => SizedBox(width: 20.w),
              ),
            ),

            SizedBox(height: 16.h),
            SectionTitle(title: AppLocalizations.of(context)!.supportTeam),
            SizedBox(height: 12.h),
            const SupportTeamSection(),

            SizedBox(height: 74.h),
            CustomizedElevatedButton(
              bottonWidget: Text(
                AppLocalizations.of(context)!.requestInspection,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: ColorManager.white,
                  fontSize: 16.sp,
                ),
              ),
              color: Theme.of(context).primaryColor,
              borderColor: Theme.of(context).primaryColor,
              onPressed: () {
                // TODO: Navigate to inspection screen
              },
            ),
          ],
        ),
      ),
    );
  }
}
