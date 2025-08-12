import 'package:ankh_project/api_service/di/di.dart';
import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/custom_dialog.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/custom_text_field.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import 'package:ankh_project/core/customized_widgets/shared_preferences .dart';
import 'package:ankh_project/feauture/dashboard/points_management/cubit/point_prices_cubit.dart';
import 'package:ankh_project/feauture/dashboard/points_management/cubit/point_prices_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import '../../../domain/entities/all_point_price_entity.dart';
import '../../../l10n/app_localizations.dart';
import 'cubit/commission_rate_cubit.dart';
import 'cubit/commission_rate_states.dart';

class CommissiomManagmentScreen extends StatefulWidget {
  const CommissiomManagmentScreen({Key? key}) : super(key: key);

  @override
  State<CommissiomManagmentScreen> createState() => _CommissiomManagmentScreenState();
}

class _CommissiomManagmentScreenState extends State<CommissiomManagmentScreen> {
  String selectedFilter = '';
  PointPricesCubit pointPricesCubit = getIt<PointPricesCubit>();
  CommissionRateCubit commissionRateCubit = getIt<CommissionRateCubit>();
  String? userToken;

  List<String> filterOptions = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    selectedFilter= AppLocalizations.of(context)!.all;
    filterOptions = [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.marketer,
      AppLocalizations.of(context)!.inspector,
      AppLocalizations.of(context)!.leaderMarketer,



    ];
  }

  @override
  void initState() {
    super.initState();
    _loadTokenAndFetchData();
  }

  Future<void> _loadTokenAndFetchData() async {
    userToken = await SharedPrefsManager.getData(key: 'user_token');
    if (userToken != null) {
      pointPricesCubit.fetchPointPrices(context);
    }
  }

  Future<void> _refreshData() async {
    print("🔄 Point Prices Refresh triggered!"); // Debug print
    if (userToken != null) {
      await pointPricesCubit.fetchPointPrices(context);
    }
    print("✅ Point Prices Refresh completed!"); // Debug print
  }

  List<AllPointPriceEntity> get filteredPrices {
    // This will be handled by the cubit state
    return [];
  }

  void _showAdjustCommissionBottomSheet(BuildContext context, AllPointPriceEntity roleData) {
    final TextEditingController rateControler = TextEditingController(

    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Icon(Icons.edit, color: ColorManager.lightprimary, size: 24.sp),
                  SizedBox(width: 12.w),
                  Text(
                    AppLocalizations.of(context)!.editCommissionRate,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              // Role info
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: ColorManager.lightGrey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.person, color: ColorManager.lightprimary, size: 20.sp),
                    SizedBox(width: 8.w),
                    Text(
                      '${roleData.roleName}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: ColorManager.textBlack,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),

              // Price input field
              Text(
                '${AppLocalizations.of(context)!.commissionRate}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: ColorManager.textBlack,
                ),
              ),
              SizedBox(height: 8.h),
              CustomTextField(
                controller: rateControler,
                hintText: AppLocalizations.of(context)!.enterCommissionRate,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 24.h),

              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: CustomizedElevatedButton(
                      bottonWidget: Text(
                        AppLocalizations.of(context)!.cancel,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: ColorManager.textBlack,
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                      color: ColorManager.white,
                      borderColor: ColorManager.lightGrey,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: CustomizedElevatedButton(
                      bottonWidget: Text(
                        AppLocalizations.of(context)!.update,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: ColorManager.white,
                        ),
                      ),
                      onPressed: () {
                        final newRate = num.tryParse(rateControler.text.trim());
                        if (newRate == null || newRate <= 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(AppLocalizations.of(context)!.enterPointPrice),
                              backgroundColor: ColorManager.error,
                            ),
                          );
                          return;
                        }
                        if (userToken != null) {
                          roleData.roleName == 'Leadermarketer'
                              ?  commissionRateCubit.editRateForTeamLeader(userToken!, newRate)
                              : commissionRateCubit.editRateForRoles(userToken!, newRate, roleData.roleName!);

                        }
                        Navigator.pop(context);
                      },
                      color: ColorManager.lightprimary,
                      borderColor: ColorManager.lightprimary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CommissionRateCubit, CommissionRateStates>(
      bloc: commissionRateCubit,
      listener: (context, state) {
        if (state is CommissionRateLoading) {
          CustomDialog.loading(
            context: context,
            message: AppLocalizations.of(context)!.loading,
            cancelable: false,
          );
        } else if (state is CommissionRateSuccess) {
          Navigator.of(context).pop(); // Close loading dialog
          CustomDialog.positiveButton(
            context: context,
            title: AppLocalizations.of(context)!.success,
            message: state.response,
            positiveOnClick: () {
              // Refresh the data
              if (userToken != null) {
                pointPricesCubit.fetchPointPrices(context);
              }
            },
          );
        } else if (state is CommissionRateError) {
          Navigator.of(context).pop(); // Close loading dialog
          CustomDialog.positiveButton(
            context: context,
            title: AppLocalizations.of(context)!.error,
            message: state.error.errorMessage,
            positiveOnClick: () {
              Navigator.of(context).pop();
            },
          );
        }
      },
      child: Scaffold(
        backgroundColor: ColorManager.white,
        appBar: AppBar(
          backgroundColor: ColorManager.lightprimary,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
              AppLocalizations.of(context)!.commissionRateManagement,

            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontSize: 18.sp,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            SizedBox(height: 20.h),

            // Filter Tabs
            Container(
              height: 50.h,
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: filterOptions.length,
                itemBuilder: (context, index) {
                  final filter = filterOptions[index];
                  final isSelected = selectedFilter == filter;

                  return Container(
                    margin: EdgeInsets.only(right: 12.w),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedFilter = filter;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                        decoration: BoxDecoration(
                          color: isSelected ? ColorManager.lightprimary : ColorManager.white,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: isSelected ? ColorManager.lightprimary : ColorManager.lightGrey,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          filter,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 14.sp,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                            color: isSelected ? ColorManager.white : ColorManager.textBlack,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 16.h),

            // Point Prices List
            Expanded(
              child: BlocBuilder<PointPricesCubit, PointPricesState>(
                bloc: pointPricesCubit,
                builder: (context, state) {
                  if (state is PointPricesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is PointPricesError) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(state.error.errorMessage ?? ''),
                            CustomizedElevatedButton(
                              bottonWidget: Text(
                                AppLocalizations.of(context)!.tryAgain,
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: ColorManager.white,
                                ),
                              ),
                              color: ColorManager.lightprimary,
                              borderColor: ColorManager.lightprimary,
                              onPressed: () {
                                if (userToken != null) {
                                  pointPricesCubit.fetchPointPrices(context);
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    );
                  } else if (state is PointPricesEmpty) {
                    return RefreshIndicator(
                      color: ColorManager.lightprimary,
                      onRefresh: _refreshData,
                      child: ListView(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.price_change,
                                    size: 64,
                                    color: ColorManager.darkGrey,
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                      AppLocalizations.of(context)!.noDataFound,

                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
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
                  } else if (state is PointPricesSuccess) {
                    final allPrices = state.pointPrices;
                    final filteredPrices = selectedFilter == AppLocalizations.of(context)!.all
                        ? allPrices
                        : allPrices.where((price) {
                            // Map localized filter names to actual role names
                            if (selectedFilter == AppLocalizations.of(context)!.marketer) {
                              return price.roleName?.toLowerCase() == 'marketer';
                            } else if (selectedFilter == AppLocalizations.of(context)!.inspector) {
                              return price.roleName?.toLowerCase() == 'inspector';
                            } else if (selectedFilter == AppLocalizations.of(context)!.leaderMarketer) {
                              return price.roleName?.toLowerCase() == 'leadermarketer';
                            }
                            return false;
                          }).toList();

                    if (filteredPrices.isEmpty) {
                      return Center(
                        child: Text(
                          AppLocalizations.of(context)!.noDataFound,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      );
                    }

                    return RefreshIndicator(
                      color: ColorManager.lightprimary,
                      onRefresh: _refreshData,
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        itemCount: filteredPrices.length,
                        physics: AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final roleData = filteredPrices[index];

                          return Container(
                            margin: EdgeInsets.only(bottom: 16.h),
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              color: ColorManager.white,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: ColorManager.lightGrey,
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: ColorManager.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Header with role and status
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            roleData.roleName??"",
                                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                              color: ColorManager.textBlack,
                                            ),
                                          ),
                                          SizedBox(height: 4.h),
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                                            decoration: BoxDecoration(
                                               color: ColorManager.darkGreen.withOpacity(0.1),
                                              borderRadius: BorderRadius.circular(12.r),
                                            ),
                                            child: Text(
                                               AppLocalizations.of(context)!.active,
                                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                fontSize: 12.sp,
                                                color: ColorManager.darkGreen
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () => _showAdjustCommissionBottomSheet(context, roleData),
                                      icon: Icon(
                                        Icons.edit,
                                        color: ColorManager.lightprimary,
                                        size: 20.sp,
                                      ),
                                    ),
                                  ],
                                ),


                                // Price display


                                // Additional info
                              ],
                            ),
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
      ),
    );
  }
}