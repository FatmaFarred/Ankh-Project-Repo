import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/data/repositries/product_repository_impl.dart';
import 'package:ankh_project/domain/entities/all_products_entity.dart';
import 'package:ankh_project/domain/repositries_and_data_sources/data_sources/remote_data_source/product_remote_data_source.dart';
import 'package:ankh_project/domain/use_cases/get_popular_products_use_case.dart';
import 'package:ankh_project/feauture/home_screen/popular_car_card.dart';
import 'package:ankh_project/feauture/marketer_products/controller/marketer_product_cubit.dart';
import 'package:ankh_project/feauture/marketer_products/controller/states.dart';
import 'package:ankh_project/feauture/marketer_products/widgets/my_product_car_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../api_service/di/di.dart';
import '../../data/data_sources/get_popular_product_remote_data_source_impl.dart' hide ProductRemoteDataSource;
import '../../l10n/app_localizations.dart';
import '../details_screen/details_screen.dart';

class MarketerProductScreen extends StatefulWidget {
  MarketerProductScreen({super.key});

  @override
  State<MarketerProductScreen> createState() => _MarketerProductScreenState();
}

class _MarketerProductScreenState extends State<MarketerProductScreen> {
  MarketerProductCubit marketerProductCubit = getIt<MarketerProductCubit>();
  @override
  void initState() {
    super.initState();
    // Replace with actual user ID (from auth or shared prefs)
    marketerProductCubit.fetchProducts("1ad0f91f-5bcb-450d-92cf-105b88792d9b");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(AppLocalizations.of(context)!.myProducts),
      ),

      body: BlocBuilder<MarketerProductCubit, MarketerProductState>(
        bloc: marketerProductCubit,
        builder: (context, state) {
          if (state is MarketerProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MarketerProductError) {
            return Center(child: Text(state.error?.errorMessage ?? ""));
          } else if (state is MarketerProductEmpty) {
            return Center(child: Text("No requests found"));
          } else if (state is MarketerProductSuccess) {
            final allRequests = state.requestList;
            return
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 24.h),
                child: Column(
                  children: [
                    SizedBox(
                      height: 260.h,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,

                          crossAxisSpacing: 9.w,
                          //mainAxisSpacing: 16.h,
                          childAspectRatio: 198 / 248, // width / height of each card
                          mainAxisExtent: 248.h
                        ),
                        scrollDirection: Axis.vertical,
                        itemCount: allRequests.length,
                        itemBuilder: (context, index) {
                          final product = allRequests[index];
                          return InkWell(
                            onTap: ()=>Navigator.pushNamed(context, DetailsScreen.detailsScreenRouteName,arguments:product.id ),
                              child: MyProductCarCard(product: product));
                        },
                      ),
                    ),
                  ],
                ),
              );
          }
          return const SizedBox.shrink();
        },

      ),
    );
  }
}
