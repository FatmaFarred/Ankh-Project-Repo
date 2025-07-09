import 'package:ankh_project/core/constants/assets_manager.dart';
import 'package:ankh_project/domain/entities/product_entity.dart';
import 'package:ankh_project/feauture/details_screen/widgets/add_comment_section.dart';
import 'package:ankh_project/feauture/details_screen/widgets/status_section.dart';
import 'package:ankh_project/feauture/request_inspection_screen/request_inspection_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import 'package:ankh_project/feauture/home_screen/section_header.dart';

import '../../l10n/app_localizations.dart';
import 'widgets/car_detail_info.dart';
import 'widgets/section_title.dart';
import 'widgets/support_team_section.dart';

class DetailsScreen extends StatefulWidget {
  final ProductEntity product;

  const DetailsScreen({super.key, required this.product});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final PageController _pageController = PageController();
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
    final product = widget.product;
    final List<String> images = [];

    if (product.image != null && product.image.isNotEmpty) {
      images.add("https://ankhapi.runasp.net/${product.image}");
    } else {
      images.add(ImageAssets.brokenImage); // local asset like assets/images/no_image.png

    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: AppLocalizations.of(context)!.haveADeal,
        backgroundColor: ColorManager.lightprimary,
        child: Icon(Icons.chat_bubble_outline_sharp, color: ColorManager.white),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(AppLocalizations.of(context)!.details),
        centerTitle: true,
        backgroundColor: ColorManager.lightprimary,
      ),
      body: SingleChildScrollView(
        padding: REdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Slider (just the main image shown)
            SizedBox(
              height: 200.h,
              child: PageView.builder(
                controller: _pageController,
                itemCount: images.length,
                onPageChanged: (index) => setState(() => _currentIndex = index),
                itemBuilder: (context, index) => ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: Image.network(
                    images[index],
                    fit: BoxFit.contain,
                    width: double.infinity,
                    errorBuilder: (_, __, ___) =>
                        Image.asset(ImageAssets.brokenImage, fit: BoxFit.scaleDown),
                  ),
                ),
              ),
            ),
            if (images.length > 1)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  images.length,
                  (index) => Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 4.w,
                      vertical: 8.h,
                    ),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentIndex == index
                          ? ColorManager.lightprimary
                          : Colors.grey,
                    ),
                  ),
                ),
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
                        product.title,
                        style: GoogleFonts.manrope(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: ColorManager.lightprimary,
                        ),
                      ),
                      Row(
                        children: [
                          RatingBarIndicator(
                            rating: product.rating,
                            itemBuilder: (context, index) => const Icon(
                              Icons.star,
                              color: ColorManager.starRateColor,
                            ),
                            itemCount: 5,
                            itemSize: 16.sp,
                          ),
                          SizedBox(width: 4),
                          _buildSmallText(
                            "${product.rating}   -",
                            ColorManager.hintColor,
                          ),
                          SizedBox(width: 8),
                          _buildSmallText("3 Ratings", ColorManager.hintColor),
                        ],
                      ),
                      _buildSmallText(
                        product.transmission,
                        const Color(0xFF404147),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Text(
                    "${AppLocalizations.of(context)!.egp} ${product.price}",
                    style: GoogleFonts.poppins(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: ColorManager.lightprimary,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 18.h),
            const StatusSection(),
            SizedBox(height: 17.h),

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

            SizedBox(height: 24.h),
            SectionTitle(title: AppLocalizations.of(context)!.details),
            SizedBox(height: 12.h),
             CarDetailInfo(product: product,),

            SizedBox(height: 16.h),
            SectionHeader(title: AppLocalizations.of(context)!.images),
            SizedBox(
              height: 115.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) => Container(
                  width: 115.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: const Color(0xFFF9FAFB),
                  ),
                  child: Image.network(
                    'https://ankhapi.runasp.net/${product.image}',
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) =>
                        Image.asset(ImageAssets.brokenImage, fit: BoxFit.scaleDown),
                  ),
                ),
                separatorBuilder: (context, index) => SizedBox(width: 20.w),
              ),
            ),

            SizedBox(height: 16.h),
            SectionTitle(title: AppLocalizations.of(context)!.comments),
            SizedBox(height: 12.h),
            const AddCommentSection(),

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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RequestInspectionScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
