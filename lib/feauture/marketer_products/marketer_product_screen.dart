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
import '../../core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import '../../data/data_sources/get_popular_product_remote_data_source_impl.dart' hide ProductRemoteDataSource;
import '../../l10n/app_localizations.dart';
import '../details_screen/details_screen.dart';
import '../home_screen/header_section.dart';

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
      body: Column(
        children: [
          HeaderSection(),
          Expanded( // ✅ Let the product area take remaining space
            child: BlocBuilder<MarketerProductCubit, MarketerProductState>(
              bloc: marketerProductCubit,
              builder: (context, state) {
                if (state is MarketerProductLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MarketerProductError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(state.error?.errorMessage ?? ""),
                          CustomizedElevatedButton(
                            bottonWidget: Text(AppLocalizations.of(context)!.tryAgain),
                            color: ColorManager.lightprimary,
                            borderColor: ColorManager.lightprimary,
                            onPressed: () => marketerProductCubit.fetchProducts("1ad0f91f-5bcb-450d-92cf-105b88792d9b"),
                          )
                        ],
                      ),
                    ),
                  );
                } else if (state is MarketerProductEmpty) {
                  return Center(child: Text(AppLocalizations.of(context)!.message));
                } else if (state is MarketerProductSuccess) {
                  final allRequests = state.requestList;

                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 24.h),
                    child: GridView.builder(
                      itemCount: allRequests.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 9.w,
                        mainAxisExtent: 248.h,
                      ),
                      itemBuilder: (context, index) {
                        final product = allRequests[index];
                        return InkWell(
                          onTap: () => Navigator.pushNamed(
                            context,
                            DetailsScreen.detailsScreenRouteName,
                            arguments: product.id,
                          ),
                          child: MyProductCarCard(product: product),
                        );
                      },
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
