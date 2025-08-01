import 'package:ankh_project/api_service/api_constants.dart';
import 'package:ankh_project/core/constants/assets_manager.dart';
import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/customized_search_bar.dart';
import 'package:ankh_project/feauture/dashboard/custom_widgets/custom_bottom_sheet.dart';
import 'package:ankh_project/feauture/dashboard/inspection_managemnt/cubit.dart';
import 'package:ankh_project/feauture/dashboard/inspection_managemnt/reschedule_cubit.dart';
import 'package:ankh_project/feauture/dashboard/inspection_managemnt/reschedule_states.dart';
import 'package:ankh_project/feauture/dashboard/inspection_managemnt/states.dart';
import 'package:ankh_project/feauture/dashboard/users_management/user_details_screen.dart';
import 'package:ankh_project/feauture/inspector_screen/widgets/custom_text_form_field.dart';
import 'package:ankh_project/feauture/myrequest/status_handler_widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../../../api_service/di/di.dart';
import '../../../core/customized_widgets/reusable_widgets/custom_dialog.dart';
import '../../../core/customized_widgets/reusable_widgets/custom_text_field.dart';
import '../../../core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import '../../../domain/entities/all_inpection_entity.dart';
import '../../../l10n/app_localizations.dart';
import '../../marketer_Reports/marketer_report_details/report_details.dart';
import '../users_management/users_management_screen.dart';
import '../widgets/adjust_points_bottom_sheet.dart';
import 'ispection_bottom_sheet.dart';

class InspectionsManagementScreen extends StatefulWidget {
  InspectionsManagementScreen({Key? key}) : super(key: key);

  @override
  State<InspectionsManagementScreen> createState() =>
      _InspectionsManagementScreenState();
}

class _InspectionsManagementScreenState
    extends State<InspectionsManagementScreen> {
  final TextEditingController _searchController = TextEditingController();
  InspectionManagementCubit inspectionManagementCubit =
      getIt<InspectionManagementCubit>();
  RescheduleCubit reschedulingCubit = getIt<RescheduleCubit>();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      inspectionManagementCubit.fetchInspections();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _refreshData() async {
    await inspectionManagementCubit.fetchInspections();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RescheduleCubit, RescheduleStates>(
      bloc: reschedulingCubit,
      listener: (context, state) {
        if (state is RescheduleInspectionLoading) {
          CustomDialog.loading(
            context: context,
            message: AppLocalizations.of(context)!.loading,
            cancelable: false,
          );
        } else if (state is RescheduleInspectionError) {
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
        } else if (state is RescheduleInspectionSuccess) {
          Navigator.of(context).pop();
          CustomDialog.positiveButton(
            context: context,
            title: AppLocalizations.of(context)!.success,
            message: state.message ?? AppLocalizations.of(context)!.success,
            positiveOnClick: () {
              Navigator.of(context).pop();
              // Refresh the marketers list
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
                  AppLocalizations.of(context)!.insepectionManagement,
                  style: Theme.of(
                    context,
                  ).textTheme.headlineLarge!.copyWith(fontSize: 18.sp),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomizedSearchBar(
                onSearch: (keyword) {
                  if (keyword.isNotEmpty) {
                    inspectionManagementCubit.searchInspections(keyword);
                  } else {
                    inspectionManagementCubit.fetchInspections();
                  }
                },
                hintText: AppLocalizations.of(context)!.search,
                outlineInputBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: BorderSide(
                    color: ColorManager.lightGreyShade2,
                    width: 2,
                  ),
                ),
              ),
            ),
            Expanded(
              child:
                  BlocBuilder<
                    InspectionManagementCubit,
                    InspectionManagementState
                  >(
                    bloc: inspectionManagementCubit,
                    builder: (context, state) {
                      if (state is InspectionManagementLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is InspectionManagementError) {
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
                                    style: Theme.of(context).textTheme.bodyLarge
                                        ?.copyWith(color: ColorManager.white),
                                  ),
                                  color: ColorManager.lightprimary,
                                  borderColor: ColorManager.lightprimary,
                                  onPressed: () => inspectionManagementCubit
                                      .fetchInspections(),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else if (state is InspectionManagementEmpty) {
                        return RefreshIndicator(
                          color: ColorManager.lightprimary,
                          onRefresh: _refreshData,
                          child: ListView(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                child: Center(
                                  child: Text(
                                    AppLocalizations.of(context)!.noDataFound,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else if (state is InspectionManagementSuccess) {
                        final inspections = state.inspectionsList;
                        return RefreshIndicator(
                          color: ColorManager.lightprimary,
                          onRefresh: _refreshData,
                          child: ListView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            itemCount: inspections.length,
                            itemBuilder: (context, index) {
                              final inspection = inspections[index];
                              return InspectionCard(
                                inspection: inspection,
                                onRescheduleButton: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    builder: (_) =>
                                        RescheduleInspectionBottomSheet(
                                          inspectionId: inspection.id ?? 0,
                                          onConfirm: (id, date, time, reason) {
                                            reschedulingCubit
                                                .rescheduleInspection(
                                                  inspectionId: id,
                                                  date: date,
                                                  time: time,
                                                  adminNote: reason,
                                                );
                                          },
                                        ),
                                  );
                                },
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

class InspectionCard extends StatelessWidget {
  final AllInpectionEntity inspection;
  final VoidCallback onRescheduleButton;

  const InspectionCard({
    Key? key,
    required this.inspection,
    required this.onRescheduleButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: ColorManager.white,
      margin: EdgeInsets.symmetric(vertical: 8.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
        side: BorderSide(color: ColorManager.lightGrey),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      "${ApiConstant.imageBaseUrl}${inspection.productImage}",
                      width: 64.w,
                      height: 64.h,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 64.w,
                          height: 64.h,
                          decoration: BoxDecoration(
                            color: ColorManager.lightGrey,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Image.asset(ImageAssets.brokenImage),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              inspection.productName ?? "",
                              style: Theme.of(context).textTheme.bodyLarge!
                                  .copyWith(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: getStatusColor(
                                getRequestStatusFromString(
                                      inspection?.status,
                                    ) ??
                                    RequestStatus.pending,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              inspection.status ?? "",
                              style: TextStyle(
                                color: getTextStatusColor(
                                  getRequestStatusFromString(
                                        inspection?.status,
                                      ) ??
                                      RequestStatus.pending,
                                ),
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            ImageAssets.userIcon,
                            height: 18.h,
                            width: 18.w,
                          ),
                          SizedBox(width: 6.w),
                          Expanded(
                            child: Text(
                              inspection.clientName ?? "",
                              style: Theme.of(context).textTheme.bodyLarge!
                                  .copyWith(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          Icon(
                            Icons.visibility,
                            size: 18.sp,
                            color: ColorManager.lightprimary,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            inspection.inspectorName ?? "",
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 18.sp,
                            color: ColorManager.lightprimary,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            inspection.address ?? "",
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          SvgPicture.asset(
                            ImageAssets.calenderIcon,
                            height: 18.h,
                            width: 18.w,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            (inspection.preferredDate != null &&
                                    inspection.preferredTime != null)
                                ? "${DateFormat('MMMM d, yyyy').format(DateTime.parse(inspection.preferredDate!))} – ${inspection.preferredTime}"
                                : AppLocalizations.of(context)!.noDataFound,
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(children: []),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: ColorManager.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: ColorManager.darkGrey),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      MarketerReportDetails.reportDetailsRouteName,
                      arguments: inspection.id,
                    );
                  },

                  icon: Icon(
                    Icons.visibility,
                    color: Color(0xffD4AF37),
                    size: 20.sp,
                  ),
                  label: Text(
                    AppLocalizations.of(context)!.viewReport,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 12.sp,
                      color: ColorManager.lightprimary,
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: ColorManager.darkGrey),
                    ),
                  ),
                  onPressed: onRescheduleButton,

                  icon: Icon(
                    Icons.restore_outlined,
                    color: ColorManager.lightprimary,
                    size: 20.sp,
                  ),
                  label: Text(
                    AppLocalizations.of(context)!.reschedule,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 12.sp,
                      color: ColorManager.lightprimary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
