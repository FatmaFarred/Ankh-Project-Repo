
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'car_brand_item.dart';
import 'cubit/top_brand_cubit.dart';

class TopBrandsList extends StatelessWidget {
  const TopBrandsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopBrandCubit, TopBrandState>(
      builder: (context, state) {
        if (state is TopBrandLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TopBrandLoaded) {
          final brands = state.brands;
          return SizedBox(
            height: 59,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: brands.length,
              separatorBuilder: (_, __) => SizedBox(width: 12.w),
              itemBuilder: (context, index) {
                final brand = brands[index];
                return CarBrandItem(
                  imageUrl: 'https://ankhapi.runasp.net${brand.imageUrl}',
                );
              },
            ),
          );
        } else if (state is TopBrandError) {
          return Center(child: Text(state.message));
        }
        return const SizedBox.shrink();
      },
    );
  }
}
