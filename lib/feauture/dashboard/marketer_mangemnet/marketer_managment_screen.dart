import 'package:ankh_project/core/constants/assets_manager.dart';
import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/customized_search_bar.dart';
import 'package:ankh_project/feauture/dashboard/custom_widgets/custom_bottom_sheet.dart';
import 'package:ankh_project/feauture/dashboard/users_management/user_details_screen.dart';
import 'package:ankh_project/feauture/inspector_screen/widgets/custom_text_form_field.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';

import '../../../api_service/di/di.dart';
import '../../../core/customized_widgets/reusable_widgets/custom_dialog.dart';
import '../../../core/customized_widgets/reusable_widgets/custom_text_field.dart';
import '../../../core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import '../../../l10n/app_localizations.dart';
import '../users_management/users_management_screen.dart';
import 'cubit/marketer_management_cubit.dart';
import 'cubit/marketer_management_states.dart';
import 'cubit/update_marketer_status_cubit.dart';
import 'cubit/update_marketer_status_states.dart';
import 'marketer_details_screen.dart';
import 'widgets/marketer_card.dart';

class MarketersManagementScreen extends StatefulWidget {
  MarketersManagementScreen({Key? key}) : super(key: key);

  @override
  State<MarketersManagementScreen> createState() => _MarketersManagementScreenState();
}

class _MarketersManagementScreenState extends State<MarketersManagementScreen> {
  MarketerManagementCubit marketerManagementCubit = getIt<MarketerManagementCubit>();
  UpdateMarketerStatusCubit updateMarketerStatusCubit = getIt<UpdateMarketerStatusCubit>();
  final TextEditingController _searchController = TextEditingController();
  


  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      marketerManagementCubit.fetchMarketers();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _refreshData() async {
    await marketerManagementCubit.fetchMarketers();
  }



  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateMarketerStatusCubit, UpdateMarketerStatusState>(
      bloc: updateMarketerStatusCubit,
      listener: (context, state) {
        if (state is UpdateMarketerStatusLoading) {
          CustomDialog.loading(
            context: context,
            message: AppLocalizations.of(context)!.loading,
            cancelable: false,
          );
        } else if (state is UpdateMarketerStatusFailure) {
          Navigator.of(context).pop();
          CustomDialog.positiveAndNegativeButton(
            context: context,
            positiveText: AppLocalizations.of(context)!.tryAgain,
            positiveOnClick: () {
              _refreshData();
            },
            title: AppLocalizations.of(context)!.error,
            message: state.error.errorMessage,
          );
        } else if (state is UpdateMarketerStatusSuccess) {
          Navigator.of(context).pop();
          CustomDialog.positiveButton(
            context: context,
            title: AppLocalizations.of(context)!.success,
            message: state.response ?? AppLocalizations.of(context)!.success,
            positiveOnClick: () {
              Navigator.of(context).pop();
              // Refresh the marketers list
              marketerManagementCubit.fetchMarketers();
            },
          );
        }
      },
      child: Scaffold(
        body: Column(
        children: [
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.marketerManagement,
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: 18.sp),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomizedSearchBar(
              onSearch: (keyword) {
                if (keyword.isNotEmpty) {
                  marketerManagementCubit.searchMarketers(keyword);
                } else {
                  marketerManagementCubit.fetchMarketers();
                }
              },
              hintText: AppLocalizations.of(context)!.search,
              outlineInputBorder: OutlineInputBorder(
           borderRadius: BorderRadius.circular(16.r),
    borderSide:  BorderSide(
    color: ColorManager.lightGreyShade2,
    width: 2,
    ))


            )
            ),

          Expanded(
            child: BlocBuilder<MarketerManagementCubit, MarketerManagementState>(
              bloc: marketerManagementCubit,
              builder: (context, state) {
                if (state is MarketerManagementLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MarketerManagementError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(state.error?.errorMessage ?? ""),
                          CustomizedElevatedButton(
                            bottonWidget: Text(
                              AppLocalizations.of(context)!.tryAgain,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: ColorManager.white,
                              ),
                            ),
                            color: ColorManager.lightprimary,
                            borderColor: ColorManager.lightprimary,
                            onPressed: () => marketerManagementCubit.fetchMarketers(),
                          )
                        ],
                      ),
                    ),
                  );
                } else if (state is MarketerManagementEmpty) {
                  return RefreshIndicator(
                    color: ColorManager.lightprimary,
                    onRefresh: _refreshData,
                    child: ListView(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.noDataFound,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (state is MarketerManagementSuccess) {
                  final marketers = state.marketersList;
                  return RefreshIndicator(
                    color: ColorManager.lightprimary,
                    onRefresh: _refreshData,
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      itemCount: marketers.length,
                      itemBuilder: (context, index) {
                        final marketer = marketers[index];
                        return MarketerCard(
                          marketer: marketer,
                          updateMarketerStatusCubit: updateMarketerStatusCubit,
                          onViewPressed: () {
                            Navigator.of(context).pushNamed(
                              MarketerDetailsScreen.routeName,
                              arguments: marketer,
                            );
                          },
                          onRefresh: () => marketerManagementCubit.fetchMarketers(),
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
    ));
  }
}




