import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/data/repositries/product_repository_impl.dart';
import 'package:ankh_project/domain/repositries_and_data_sources/data_sources/remote_data_source/product_remote_data_source.dart';
import 'package:ankh_project/domain/use_cases/get_recommended_brands_use_case.dart';
import 'package:ankh_project/feauture/home_screen/cubit/recommended_brands_cubit.dart';
import 'package:ankh_project/feauture/home_screen/recommended_car_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ankh_project/data/data_sources/get_popular_product_remote_data_source_impl.dart' hide ProductRemoteDataSource;

class RecommendedCarsList extends StatelessWidget {
  const RecommendedCarsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RecommendedBrandsCubit(
        GetRecommendedBrandsUseCase(
          ProductRepositoryImpl(ProductRemoteDataSourceImpl() as ProductRemoteDataSource),
        ),
      )..fetchRecommendedBrands(),
      child: BlocBuilder<RecommendedBrandsCubit, RecommendedBrandsState>(
        builder: (context, state) {
          if (state is RecommendedBrandsLoading) {
            return SizedBox(
              height: 140.h,
              child:  Center(child: CircularProgressIndicator(color: ColorManager.lightprimary,)),
            );
          } else if (state is RecommendedBrandsLoaded) {
            final products = state.products;

            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: products.length,
              separatorBuilder: (_, __) => SizedBox(height: 10.h),
              itemBuilder: (context, index) {
                return RecommendedCarCard(product: products[index]);
              },
            );
          } else if (state is RecommendedBrandsError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
