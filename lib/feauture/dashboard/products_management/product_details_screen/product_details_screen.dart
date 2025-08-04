import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import 'package:ankh_project/feauture/dashboard/products_management/product_details_screen/cubit/product_details_cubit.dart';
import 'package:ankh_project/feauture/dashboard/products_management/product_details_screen/cubit/product_details_state.dart';
import 'package:ankh_project/feauture/dashboard/products_management/product_details_screen/delete_product/delete_product_cubit.dart';
import 'package:ankh_project/feauture/dashboard/products_management/widgets/car_detail_info.dart';
import 'package:ankh_project/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../../../details_screen/widgets/section_title.dart';
import '../../../home_screen/section_header.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int productId;

  const ProductDetailsScreen({super.key, required this.productId});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late PageController _pageController;
  int _currentIndex = 0;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    context.read<ProductDetailsCubit>().fetchProductDetails(widget.productId);
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
      body: BlocConsumer<DeleteProductCubit, DeleteProductState>(
        listener: (context, state) {
          if (state is DeleteProductSuccess) {
            Navigator.pop(context, true); // Go back to the previous screen
          } else if (state is DeleteProductFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, deleteState) {
          return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
            builder: (context, state) {
              if (state is ProductDetailsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ProductDetailsError) {
                return Center(child: Text(state.message));
              } else if (state is ProductDetailsLoaded) {
                final product = state.product;
                final images = product.imageUrls;

                return SingleChildScrollView(
                  padding: REdgeInsets.all(22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --- Product Image Carousel & Favorite ---
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
                                child: Image.network(
                                  "https://ankhapi.runasp.net/${images[index]}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          if (product.status == "0")
                            Positioned(
                              right: 13.w,
                              child: Chip(
                                label: Text(
                                  AppLocalizations.of(context)!.active,
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
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

                      // --- Product Title, Price, Rating ---
                      Row(
                        children: [
                          Expanded(
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
                                      rating: product.rating.toDouble(),
                                      itemBuilder: (context, index) =>
                                          const Icon(
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
                                  product.transmission,
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

                      // --- Description ---
                      SectionTitle(
                        title: AppLocalizations.of(context)!.description,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        product.description,
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          color: const Color(0xff404147),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      _buildSmallText(
                        "${AppLocalizations.of(context)!.created}: ${DateFormat('yyyy-MM-dd ').format(product.createdAt)}",
                        const Color(0xff6B7280),
                      ),
                      _buildSmallText(
                        "${AppLocalizations.of(context)!.lastEdited}: ${DateFormat('yyyy-MM-dd ').format(product.lastEditedAt)}",
                        const Color(0xff6B7280),
                      ),
                      SizedBox(height: 24.h),

                      // --- Product Details Section ---
                      SectionTitle(
                        title: AppLocalizations.of(context)!.details,
                      ),
                      SizedBox(height: 12.h),
                      CarDetailInfo(
                        batteryCapacity: product.batteryCapacity,
                        horsepower: product.horsepower.toString(),
                        odometer: product.mileage.toString(),
                        year: product.year.toString(),
                        transmission: product.transmission,
                        engineType: product.engineType,
                        color: product.color,
                        category: product.category,
                      ),
                      SizedBox(height: 16.h),

                      // --- Images Section ---
                      SectionHeader(
                        title: AppLocalizations.of(context)!.images,
                        imageUrl: product.imageUrls,
                      ),
                      SizedBox(
                        height: 115.h,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: product.imageUrls.length,
                          itemBuilder: (context, index) => Container(
                            width: 115.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                              color: const Color(0xFFF9FAFB),
                            ),
                            child: Image.network(
                              "https://ankhapi.runasp.net/${product.imageUrls[index]}",
                              fit: BoxFit.contain,
                            ),
                          ),
                          separatorBuilder: (context, index) =>
                              SizedBox(width: 20.w),
                        ),
                      ),
                      SizedBox(height: 16.h),

                      // --- Delete Button ---
                      Padding(
                        padding: REdgeInsets.symmetric(horizontal: 16.0),
                        child: CustomizedElevatedButton(
                          bottonWidget: deleteState is DeleteProductLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  AppLocalizations.of(context)!.delete,
                                  style: Theme.of(context).textTheme.bodyLarge!
                                      .copyWith(
                                        fontSize: 16.sp,
                                        color: ColorManager.white,
                                      ),
                                ),
                          onPressed: deleteState is DeleteProductLoading
                              ? null
                              : () {
                                  context
                                      .read<DeleteProductCubit>()
                                      .deleteProduct(widget.productId);
                                },
                          color: ColorManager.darkGrey,
                          borderColor: ColorManager.darkGrey,
                        ),
                      ),
                      SizedBox(height: 6.h),

                      // --- Unassign Button (not implemented) ---
                      Padding(
                        padding: REdgeInsets.symmetric(horizontal: 16.0),
                        child: CustomizedElevatedButton(
                          bottonWidget: Text(
                            AppLocalizations.of(context)!.edit,
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(
                                  fontSize: 16.sp,
                                  color: ColorManager.white,
                                ),
                          ),
                          onPressed: () {},
                          color: ColorManager.lightprimary,
                          borderColor: ColorManager.lightprimary,
                        ),
                      ),
                      SizedBox(height: 74.h),
                    ],
                  ),
                );
              } else {
                return const Center(child: Text("No data available"));
              }
            },
          );
        },
      ),
    );
  }
}
