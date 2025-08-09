import 'package:ankh_project/api_service/api_constants.dart';
import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/domain/entities/all_products_entity.dart';
import 'package:ankh_project/feauture/details_screen/details_screen.dart';
import 'package:ankh_project/feauture/home_screen/top_brands/cubit/products_by_brand_cubit.dart';
import 'package:ankh_project/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

class CarsBybrandScreen extends StatelessWidget {
  final int id;
  const CarsBybrandScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance<ProductsByBrandCubit>()..getProductsByBrandId(id),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.topBrands),
          centerTitle: true,
        ),
        body: BlocBuilder<ProductsByBrandCubit, ProductsByBrandState>(
          builder: (context, state) {
            if (state is ProductsByBrandLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductsByBrandLoaded) {
              return _buildProductsList(context, state.products);
            } else if (state is ProductsByBrandEmpty) {
              return Center(
                child: Text(AppLocalizations.of(context)!.noProductsFound),
              );
            } else if (state is ProductsByBrandError) {
              return Center(
                child: Text('Error: ${state.message}'),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }

  Widget _buildProductsList(BuildContext context, List<AllProductsEntity> products) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 16.w,
          mainAxisSpacing: 16.h,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return _buildProductCard(context, product);
        },
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, AllProductsEntity product) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          DetailsScreen.detailsScreenRouteName,
          arguments: product.id,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                topRight: Radius.circular(12.r),
              ),
              child: Image.network(
                '${ApiConstant.imageBaseUrl}${product.image}',
                height: 120.h,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 120.h,
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: Icon(Icons.broken_image, size: 40.sp),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      RatingBar.builder(
                        initialRating: product.rating?.toDouble() ?? 0,
                        minRating: 0,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 1,
                        itemSize: 16.sp,
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: ColorManager.rateColor,
                        ),
                        onRatingUpdate: (_) {},
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '${product.rating?.toStringAsFixed(1) ?? "0.0"}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    product.title ?? '',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${product.transmission ?? ''} - ${product.status ?? ''}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: ColorManager.darkGrey,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (product.marketerPoints != null) ...[  
                    SizedBox(height: 4.h),
                    Text(
                      '${AppLocalizations.of(context)!.points}: ${product.marketerPoints}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: ColorManager.darkGrey,
                          ),
                    ),
                  ],
                  SizedBox(height: 4.h),
                  Text(
                    '${AppLocalizations.of(context)!.price}: ${product.price ?? ''}',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: ColorManager.lightprimary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
