import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/data/repositries/product_repository_impl.dart';
import 'package:ankh_project/domain/repositries_and_data_sources/data_sources/remote_data_source/product_remote_data_source.dart';
import 'package:ankh_project/domain/use_cases/get_popular_products_use_case.dart';
import 'package:ankh_project/feauture/home_screen/popular_car_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/data_sources/get_popular_product_remote_data_source_impl.dart' hide ProductRemoteDataSource;
import 'cubit/popular_product_cubit.dart';

class PopularCarsList extends StatelessWidget {
  const PopularCarsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PopularProductsCubit(
        GetPopularProductsUseCase(
          ProductRepositoryImpl(ProductRemoteDataSourceImpl() as ProductRemoteDataSource),
        ),
      )..fetchPopularProducts(),
      child: BlocBuilder<PopularProductsCubit, PopularProductsState>(
        builder: (context, state) {
          if (state is PopularProductsLoading) {
            return SizedBox(
              height: 180.h,
              child:  Center(child: CircularProgressIndicator(color: ColorManager.lightprimary,)),
            );
          } else if (state is PopularProductsLoaded) {
            final products = state.products;

            return SizedBox(
              height: 260.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Padding(
                    padding: EdgeInsets.only(right: 12.w),
                    child: PopularCarCard(product: product),
                  );
                },
              ),
            );
          } else if (state is PopularProductsError) {
            return SizedBox(
              height: 180.h,
              child: Center(child: Text(state.message)),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
