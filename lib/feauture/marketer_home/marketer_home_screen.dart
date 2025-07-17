import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/data/repositries/product_repository_impl.dart';
import 'package:ankh_project/domain/entities/product_details_entity.dart';
import 'package:ankh_project/domain/repositries_and_data_sources/data_sources/remote_data_source/product_remote_data_source.dart';
import 'package:ankh_project/domain/use_cases/get_popular_products_use_case.dart';
import 'package:ankh_project/feauture/home_screen/popular_car_card.dart';
import 'package:ankh_project/feauture/marketer_products/widgets/my_product_car_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../api_service/di/di.dart';
import '../../core/customized_widgets/reusable_widgets/custom_dialog.dart';
import '../../core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import '../../data/data_sources/get_popular_product_remote_data_source_impl.dart' hide ProductRemoteDataSource;
import '../../l10n/app_localizations.dart';
import '../authentication/user_controller/user_cubit.dart';
import '../details_screen/details_screen.dart';
import '../home_screen/header_section.dart';
import '../marketer_products/get_product_controller/states.dart';
import 'assign_product_controller/marketer_product_cubit.dart';
import 'assign_product_controller/states.dart';
import 'controller/marketer_home_product_cubit.dart';
import 'controller/states.dart';

class MarketerHomeScreen extends StatefulWidget {
  MarketerHomeScreen({super.key});

  @override
  State<MarketerHomeScreen> createState() => _MarketerHomeScreenState();
}

class _MarketerHomeScreenState extends State<MarketerHomeScreen> {
  MarketerHomeProductCubit marketerHomeProductCubit = getIt<MarketerHomeProductCubit>();
  MarketerAssignProductCubit marketerAssignProductCubit = getIt<MarketerAssignProductCubit>();
  
  void initState() {
    super.initState();

    Future.microtask(() {
      final user = context.read<UserCubit>().state;
      final userId = user?.id;

      if (userId != null && userId.isNotEmpty) {
        marketerHomeProductCubit.fetchProducts();
      } else {
        // Optional: show error/snackbar if user not found
        debugPrint("User ID is null or empty");
      }
    });
  }

  Future<void> _refreshData() async {
    print("🔄 Marketer Products Refresh triggered!"); // Debug print
    final user = context.read<UserCubit>().state;
    final userId = user?.id;
    print("👤 User ID: $userId"); // Debug print
    if (userId != null && userId.isNotEmpty) {
      await marketerHomeProductCubit.fetchProducts();
    }
    print("✅ Marketer Products Refresh completed!"); // Debug print
  }


  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserCubit>().state;


    return Scaffold(

      body: Column(
        children: [
          HeaderSection(),
          Expanded(
            // ✅ Let the product area take remaining space
            child:BlocConsumer<MarketerAssignProductCubit, MarketerAssignProductState>(
               bloc: marketerAssignProductCubit,
             listener: (context, state) {
               if (state is MarketerAssignProductLoading) {

               CustomDialog.loading(
                   context: context,
                   message: AppLocalizations.of(context)!.loading,
                   cancelable: false);
             }else if (state is MarketerAssignProductSuccess) {
                     Navigator.of(context).pop();
                CustomDialog.positiveButton(
                   context: context,
      title: AppLocalizations.of(context)!.success,
             message: state.message,
    );


  } else if (state is MarketerAssignProductError) {
    Navigator.of(context).pop();
    CustomDialog.positiveAndNegativeButton(
    context: context,

    positiveText:  AppLocalizations.of(context)!.tryAgain,
    negativeText: AppLocalizations.of(context)!.ok,
    positiveOnClick: () {
    Navigator.of(context).pop();
    final storedProductId = marketerAssignProductCubit.currentProductId;

    // Use the stored product ID from the cubit
    if (storedProductId != null) {
      print("🔄 !$storedProductId"); // Debug print
      print("👤 User ID: ${user?.id}"); // Debug print
      marketerAssignProductCubit.assignProduct(
        productId: storedProductId,
        userId: user?.id ?? "");

    }
    },
    title: AppLocalizations.of(context)!.error,
    message: state.error.errorMessage);
    }
              },

    builder: (context, assignState) {
      return BlocBuilder<MarketerHomeProductCubit, MarketerHomeProductState>(
        bloc: marketerHomeProductCubit,
        builder: (context, state) {
          if (state is MarketerHomeProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MarketerHomeProductError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(state.error?.errorMessage ?? ""),
                    CustomizedElevatedButton(
                      bottonWidget: Text(AppLocalizations.of(context)!.tryAgain,
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: ColorManager.white),

                      ),
                      color: ColorManager.lightprimary,
                      borderColor: ColorManager.lightprimary,
                      onPressed: () => marketerHomeProductCubit.fetchProducts(),
                    )
                  ],
                ),
              ),
            );
          } else if (state is MarketerHomeProductEmpty) {
            return RefreshIndicator(
              color: ColorManager.lightprimary,
              onRefresh: _refreshData,
              child: ListView(
                children: [
                  Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.5,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.hourglass_empty,
                            size: 64,
                            color: ColorManager.darkGrey,
                          ),
                          SizedBox(height: 16),
                          Text(
                            AppLocalizations.of(context)!.noProductsFound,
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                              color: ColorManager.darkGrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is MarketerHomeProductSuccess) {
            final allRequests = state.productList;

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 18.h),
              child: RefreshIndicator(
                color: ColorManager.lightprimary,
                onRefresh: _refreshData,
                child: GridView.builder(
                  itemCount: allRequests.length,
                  physics: AlwaysScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 9.w,
                    mainAxisSpacing: 15.h,
                    mainAxisExtent: 310.5.h,

                  ),
                  itemBuilder: (context, index) {
                    final product = allRequests[index];
                    return InkWell(
                      onTap: () =>
                          Navigator.pushNamed(
                            context,
                            DetailsScreen.detailsScreenRouteName,
                            arguments: product.id,
                          ),
                      child: MyProductCarCard(
                        product: product,
                        showAddButton: true,
                        onAddPressed: () {
                          print("👤 User ID: ${user?.id}");
                          marketerAssignProductCubit.assignProduct(
                            productId: product.id??0,
                            userId: user?.id ?? "",
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      );
    }
    )

          ),
        ],
      ),
    );
  }
}
