import 'package:ankh_project/core/constants/assets_manager.dart';
import 'package:ankh_project/feauture/dashboard/products_management/widgets/car_detail_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/constants/color_manager.dart';
import '../../../core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import '../../../l10n/app_localizations.dart';
import '../../details_screen/widgets/section_title.dart';
import '../../details_screen/widgets/support_team_section.dart';
import '../../home_screen/section_header.dart';

// Dummy product entity
class ProductEntity {
  final String? title;
  final double? rating;
  final String? transmission;
  final String? status;
  final double? price;
  final String? description;
  final String? createdAt;
  final String? lastEditedAt;
  final List<String>? imageUrls;
  final String? odometer;
  final String? color;
  final int? year;
  final String? category;
  final String? ownerName;
  final String? marketerName;

  ProductEntity({
    this.odometer,
    this.color,
    this.year,
    this.category,
    this.ownerName,
    this.marketerName,
    this.title,
    this.rating,
    this.transmission,
    this.status,
    this.price,
    this.description,
    this.createdAt,
    this.lastEditedAt,
    this.imageUrls,
  });
}

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late PageController _pageController;
  int _currentIndex = 0;
  bool isFavorite = false;

  // Dummy product
  final ProductEntity product = ProductEntity(
    title: "BMW M3 GTR",
    rating: 4.5,
    transmission: "Automatic",
    status: "Available",
    price: 1200000,
    color: "gray",
    category: "sedan",
    marketerName: "Ahmed Mohamed",
    odometer: "156000",
    ownerName: "Mohamed Khaled",
    year: 2022,
    description: "A high-performance sports car in excellent condition.",
    createdAt: "2025-07-01",
    lastEditedAt: "2025-07-20",
    imageUrls: [ImageAssets.carPic1, ImageAssets.carPic2, ImageAssets.carPic3],
  );

  List<String> get images => product.imageUrls ?? [];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  Widget _buildSmallText(String text, Color color) => Text(
    text,
    style: GoogleFonts.poppins(
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      color: color,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            // Image Slider
            Stack(
              children: [
                SizedBox(
                  height: 200.h,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: images.length,
                    onPageChanged: (index) =>
                        setState(() => _currentIndex = index),
                    itemBuilder: (context, index) => ClipRRect(
                      borderRadius: BorderRadius.circular(16.r),
                      child: Image.asset(images[index], fit: BoxFit.fitWidth),
                    ),
                  ),
                ),
                if (product.status == "Available")
                  Positioned(
                    right: 13.w,
                    child: Chip(
                      label: Text(
                        AppLocalizations.of(context)!.active,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 14.sp,
                          color: ColorManager.darkGreen,
                        ),
                      ),
                      backgroundColor: ColorManager.lightGreen,
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      shape: const StadiumBorder(),
                    ),
                  ),
                Positioned(
                  left: 13.w,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
                    child: CircleAvatar(
                      radius: 30.r,
                      backgroundColor: ColorManager.white,
                      child: Icon(
                        Iconsax.heart5,
                        color: isFavorite
                            ? ColorManager.lightprimary
                            : ColorManager.grey,
                      ),
                    ),
                  ),
                ),
              ],
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title ?? "",
                        style: GoogleFonts.manrope(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: ColorManager.lightprimary,
                        ),
                      ),
                      Row(
                        children: [
                          RatingBarIndicator(
                            rating: (product.rating ?? 0.0),
                            itemBuilder: (context, index) => const Icon(
                              Icons.star,
                              color: ColorManager.starRateColor,
                            ),
                            itemCount: 5,
                            itemSize: 16.sp,
                          ),
                          _buildSmallText(
                            "  ${product.rating}",
                            ColorManager.hintColor,
                          ),
                        ],
                      ),
                      _buildSmallText(
                        product.transmission ?? "",
                        const Color(0xFF404147),
                      ),
                    ],
                  ),
                ),
                Text(
                  "EGP ${product.price}",
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: ColorManager.lightprimary,
                  ),
                ),
              ],
            ),

            SizedBox(height: 18.h),
            // StatusSection(product: product),
            SizedBox(height: 17.h),
            SectionTitle(title: AppLocalizations.of(context)!.description),
            SizedBox(height: 4.h),
            Text(
              product.description ?? "",
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                color: const Color(0xff404147),
              ),
            ),
            SizedBox(height: 12.h),
            _buildSmallText(
              "Created: ${product.createdAt != null ? DateFormat('dd/MM/yyyy').format(DateTime.parse(product.createdAt!)) : 'N/A'}",
              const Color(0xff6B7280),
            ),
            _buildSmallText(
              "Last Edited: ${product.lastEditedAt != null ? DateFormat('dd/MM/yyyy').format(DateTime.parse(product.lastEditedAt!)) : 'N/A'}",
              const Color(0xff6B7280),
            ),

            SizedBox(height: 24.h),
            SectionTitle(title: AppLocalizations.of(context)!.details),
            SizedBox(height: 12.h),

            CarDetailInfo(),
            SizedBox(height: 16.h),
            SectionHeader(
              title: AppLocalizations.of(context)!.images,
              imageUrl: product.imageUrls,
            ),
            SizedBox(
              height: 115.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: product.imageUrls?.length ?? 0,
                itemBuilder: (context, index) => Container(
                  width: 115.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: const Color(0xFFF9FAFB),
                  ),
                  child: Image.asset(
                    product.imageUrls![index],
                    fit: BoxFit.contain,
                  ),
                ),
                separatorBuilder: (context, index) => SizedBox(width: 20.w),
              ),
            ),

            SizedBox(height: 16.h),
            Padding(
              padding: REdgeInsets.symmetric(horizontal: 16.0),
              child: CustomizedElevatedButton(
                bottonWidget: Text(
                  AppLocalizations.of(context)!.delete,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 16.sp,
                    color: ColorManager.white,
                  ),
                ),
                onPressed: () {
                  // Handle suspend account action
                },
                color: ColorManager.darkGrey,
                borderColor: ColorManager.darkGrey,
              ),
            ),
            SizedBox(height: 6.h),

            Padding(
              padding: REdgeInsets.symmetric(horizontal: 16.0),
              child: CustomizedElevatedButton(
                bottonWidget: Text(
                  AppLocalizations.of(context)!.unassign,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 16.sp,
                    color: ColorManager.white,
                  ),
                ),
                onPressed: () {
                  // Handle suspend account action
                },
                color: ColorManager.lightprimary,
                borderColor: ColorManager.lightprimary,
              ),
            ),

            SizedBox(height: 74.h),
          ],
        ),
      ),
    );
  }
}
