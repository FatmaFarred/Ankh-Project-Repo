import 'dart:ui';

import 'package:ankh_project/api_service/api_constants.dart';
import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import 'package:ankh_project/domain/entities/all_inspectors_entity.dart';
import 'package:ankh_project/feauture/dashboard/inspector_management/inspector_management_screen.dart';
import 'package:ankh_project/feauture/home_screen/header_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../core/constants/assets_manager.dart';
import '../../../core/constants/font_manager/font_style_manager.dart';
import '../../../core/customized_widgets/reusable_widgets/customized_containers/rounded_conatiner_image.dart';
import '../../../l10n/app_localizations.dart';
import '../../details_screen/full_image_view_screen.dart';
import '../../inspector_screen/widgets/photo_list_view.dart';
import '../../marketer_Reports/marketer_report_details/report_details.dart';
import '../../marketer_Reports/marketer_reports_screen.dart';
import '../../myrequest/status_handler_widgets.dart';
import '../custom_widgets/photo_list.dart';
import '../../inspector_screen/my_inspections/my_inspections_cubit.dart';
import '../../inspector_screen/my_inspections/my_inspections_state.dart';
import '../../../domain/entities/all_inpection_entity.dart';
import '../../../core/customized_widgets/reusable_widgets/custom_dialog.dart';
import '../custom_widgets/custom_bottom_sheet.dart';
import 'cubit/block_inspector_cubit.dart';
import 'cubit/unblock_inspector_cubit.dart';
import '../cubit/adjust_user_points_cubit.dart';
import '../widgets/adjust_points_bottom_sheet.dart';

class InspectorDetailsScreen extends StatefulWidget {
  static const String routeName = 'InspectorDetailsScreen';

  const InspectorDetailsScreen({Key? key}) : super(key: key);

  @override
  State<InspectorDetailsScreen> createState() => _InspectorDetailsScreenState();
}

class _InspectorDetailsScreenState extends State<InspectorDetailsScreen> {
  MyInspectionsCubit myInspectionsCubit = GetIt.instance<MyInspectionsCubit>();
  BlockInspectorCubit blockInspectorCubit = GetIt.instance<BlockInspectorCubit>();
  UnblockInspectorCubit unblockInspectorCubit = GetIt.instance<UnblockInspectorCubit>();
  AdjustUserPointsCubit adjustUserPointsCubit = GetIt.instance<AdjustUserPointsCubit>();
  late AllInspectorsEntity inspector;

  @override
  void initState() {
    super.initState();

    // Use Future.microtask to delay access to context safely
    Future.microtask(() {
      inspector =
          ModalRoute.of(context)!.settings.arguments as AllInspectorsEntity;
      myInspectionsCubit.fetchAllInspectionsById(
        inspectorId: inspector.id?.toString() ?? "",
      );
    });
  }

  @override
  void dispose() {
    myInspectionsCubit.close();
    blockInspectorCubit.close();
    unblockInspectorCubit.close();
    adjustUserPointsCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Use a fallback if inspector is not initialized yet
    final inspectorArg = ModalRoute.of(context)?.settings.arguments;
    if (inspectorArg is AllInspectorsEntity) {
      inspector = inspectorArg;
    }

    return MultiBlocListener(
      listeners: [
        BlocListener<BlockInspectorCubit, BlockInspectorState>(
          bloc: blockInspectorCubit,
          listener: (context, state) {
            if (state is BlockInspectorLoading) {
              CustomDialog.loading(
                context: context,
                message: AppLocalizations.of(context)!.loading,
                cancelable: false,
              );
            } else if (state is BlockInspectorFailure) {
              Navigator.of(context).pop();
              CustomDialog.positiveAndNegativeButton(
                context: context,
                positiveText: AppLocalizations.of(context)!.tryAgain,
                positiveOnClick: () {
                  Navigator.of(context).pop();
                  // Re-trigger the block action
                  _showBlockInspectorBottomSheet();
                },
                title: AppLocalizations.of(context)!.error,
                message: state.error.errorMessage,
              );
            } else if (state is BlockInspectorSuccess) {
              Navigator.of(context).pop();
              CustomDialog.positiveButton(
                context: context,
                title: AppLocalizations.of(context)!.success,
                message: state.response,
                positiveOnClick: () {
                  // Refresh the screen or navigate back
                },
              );
            }
          },
        ),
        BlocListener<UnblockInspectorCubit, UnblockInspectorState>(
          bloc: unblockInspectorCubit,
          listener: (context, state) {
            if (state is UnblockInspectorLoading) {
              CustomDialog.loading(
                context: context,
                message: AppLocalizations.of(context)!.loading,
                cancelable: false,
              );
            } else if (state is UnblockInspectorFailure) {
              Navigator.of(context).pop();
              CustomDialog.positiveAndNegativeButton(
                context: context,
                positiveText: AppLocalizations.of(context)!.tryAgain,
                positiveOnClick: () {
                  Navigator.of(context).pop();
                  _showUnblockInspectorBottomSheet();
                },
                title: AppLocalizations.of(context)!.error,
                message: state.error.errorMessage,
                negativeText: AppLocalizations.of(context)!.cancel,
                negativeOnClick: () => Navigator.of(context).pop(),
              );
            } else if (state is UnblockInspectorSuccess) {
              Navigator.of(context).pop();
              CustomDialog.positiveButton(
                context: context,
                title: AppLocalizations.of(context)!.success,
                message: state.response ?? "User unblocked successfully",
                positiveText: AppLocalizations.of(context)!.ok,
                positiveOnClick: () {
                },
              );
            }
          },
        ),
        BlocListener<AdjustUserPointsCubit, AdjustUserPointsState>(
          bloc: adjustUserPointsCubit,
          listener: (context, state) {
            if (state is AdjustUserPointsLoading) {
              CustomDialog.loading(
                context: context,
                message: AppLocalizations.of(context)!.loading,
                cancelable: false,
              );
            } else if (state is AdjustUserPointsFailure) {
              Navigator.of(context).pop();
              CustomDialog.positiveButton(
                context: context,
                title: AppLocalizations.of(context)!.error,
                message: state.failure.errorMessage,
                positiveText: AppLocalizations.of(context)!.ok,
                positiveOnClick: () => Navigator.of(context).pop(),
              );
            } else if (state is AdjustUserPointsSuccess) {
              Navigator.of(context).pop();
              CustomDialog.positiveButton(
                context: context,
                title: AppLocalizations.of(context)!.success,
                message: state.message ?? "Points adjusted successfully",
                positiveText: AppLocalizations.of(context)!.ok,
                positiveOnClick: () {},
              );
            }
          },
        ),
      ],
      child: Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.inspectionDetails),
        backgroundColor: ColorManager.lightprimary,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              InspectorCard(inspector: inspector, showBottons: false),
              SizedBox(height: 16.h),
              
              // Inspector Images Section
              if (inspector.licenseImage != null && inspector.licenseImage!.isNotEmpty || 
                  inspector.vehicleImage != null && inspector.vehicleImage!.isNotEmpty) ...[
                Row(
                  children: [
                    Icon(
                      Icons.image,
                      color: ColorManager.lightprimary,
                      size: 18.sp,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      AppLocalizations.of(context)!.inspectorDocuments,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 16.sp),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                
                // License Image
                if (inspector.licenseImage != null && inspector.licenseImage!.isNotEmpty) ...[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.licenseImage,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FullImageViewScreen(images: [  "${ApiConstant.imageBaseUrl}${inspector.licenseImage}"], initialIndex: 0,

                                )
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          height: 150.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(color: ColorManager.lightGrey),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.r),
                            child: Image.network(
                              "${ApiConstant.imageBaseUrl}${inspector.licenseImage}",
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: ColorManager.lightGrey,
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.broken_image,
                                          color: ColorManager.darkGrey,
                                          size: 32.sp,
                                        ),
                                        SizedBox(height: 8.h),
                                        Text(
                                          AppLocalizations.of(context)!.thereIsNoImages,
                                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                            color: ColorManager.darkGrey,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                ],
                
                // Vehicle Image
                if (inspector.vehicleImage != null && inspector.vehicleImage!.isNotEmpty) ...[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.vehicleImage,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FullImageViewScreen(images: [ "${ApiConstant.imageBaseUrl}${inspector.vehicleImage}"], initialIndex: 0,

                              )
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          height: 150.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(color: ColorManager.lightGrey),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.r),
                            child: Image.network(
                              "${ApiConstant.imageBaseUrl}${inspector.vehicleImage}",
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: ColorManager.lightGrey,
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.broken_image,
                                          color: ColorManager.darkGrey,
                                          size: 32.sp,
                                        ),
                                        SizedBox(height: 8.h),
                                        Text(
                                         AppLocalizations.of(context)!.thereIsNoImages,
                                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                            color: ColorManager.darkGrey,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                ],
              ],
              
              Row(
                children: [
                  SvgPicture.asset(
                    ImageAssets.carIcon2,
                    height: 18.h,
                    width: 18.w,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    "${AppLocalizations.of(context)!.inspectionHistory} ",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge!.copyWith(fontSize: 16.sp),
                  ),
                ],
              ),
              SizedBox(height: 12),
              BlocBuilder<MyInspectionsCubit, MyInspectionsState>(
                bloc: myInspectionsCubit,
                builder: (context, state) {
                  if (state is MyInspectionsLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: ColorManager.lightprimary,
                      ),
                    );
                  } else if (state is MyInspectionsError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(state.error?.errorMessage ?? ""),
                          SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              myInspectionsCubit.fetchAllInspectionsById(
                                inspectorId: inspector.id?.toString() ?? "",
                              );
                            },
                            child: Text(AppLocalizations.of(context)!.tryAgain),
                          ),
                        ],
                      ),
                    );
                  } else if (state is MyInspectionsEmpty) {
                    return Center(
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
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(color: ColorManager.darkGrey),
                          ),
                        ],
                      ),
                    );
                  } else if (state is MyInspectionsLoaded) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.inspections.length,
                      itemBuilder: (context, index) {
                        final inspection = state.inspections[index];
                        return InspectionHistoryCard(inspection: inspection);
                      },
                    );
                  }
                  return SizedBox.shrink();
                },
              ),

              SizedBox(height: 50.h),
              CustomizedElevatedButton(
                bottonWidget: Text(
                  AppLocalizations.of(context)!.blockUser,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 16.sp,
                    color: ColorManager.white,
                  ),
                ),
                onPressed: () {
                  _showBlockInspectorBottomSheet();
                },
                color: ColorManager.error,
                borderColor: ColorManager.error,
              ),
              SizedBox(height: 16.h),
              CustomizedElevatedButton(
                bottonWidget: Text(
                  AppLocalizations.of(context)!.sendPoints,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 16.sp,
                    color: ColorManager.white,
                  ),
                ),
                onPressed: () {
                  _showAdjustPointsBottomSheet();
                },
                color: ColorManager.lightprimary,
                borderColor: ColorManager.lightprimary,
              ),
              SizedBox(height: 16.h),
              CustomizedElevatedButton(
                bottonWidget: Text(
                  AppLocalizations.of(context)!.unblockUser,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 16.sp,
                    color: ColorManager.white,
                  ),
                ),
                onPressed: () {
                  _showUnblockInspectorBottomSheet();
                },
                color: ColorManager.lightprimary,
                borderColor: ColorManager.lightprimary,
              ),
            ],
          ),
        ),
      ),
    ));
  }

  void _showBlockInspectorBottomSheet() {
    final TextEditingController reasonController = TextEditingController();
    final TextEditingController daysController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          padding: EdgeInsets.all(20.w),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Row(
                  children: [
                    Icon(
                      Icons.block,
                      size: 24.h,
                      color: ColorManager.error,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      AppLocalizations.of(context)!.blockUser,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  AppLocalizations.of(context)!.blockUserSubtitle,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp,color: ColorManager.darkGrey),
                ),
                SizedBox(height: 20.h),
                Text(
                  AppLocalizations.of(context)!.reasonForBlocking,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                ),
                SizedBox(height: 8.h),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return AppLocalizations.of(context)!.fieldRequired;
                    }
                    return null;
                  },
                  controller: reasonController,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.enterReasonForBlocking,
                    hintStyle: Theme.of(context).textTheme.bodySmall,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(color: ColorManager.lightGrey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(color: ColorManager.lightGrey),
                    ),
                  ),
                  maxLines: 3,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: 16.h),
                Text(
                  AppLocalizations.of(context)!.blockDaysCount,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: 8.h),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return AppLocalizations.of(context)!.fieldRequired;
                    }
                    return null;
                  },
                  controller: daysController,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.enterBlockDaysCount,
                    hintStyle: Theme.of(context).textTheme.bodySmall,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(color: ColorManager.lightGrey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(color: ColorManager.lightGrey),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.white,
                          side: BorderSide(color: ColorManager.lightGrey),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.cancel,
                          style: TextStyle(color: ColorManager.darkGrey),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            Navigator.pop(context);
                            blockInspectorCubit.blockInspector(
                              inspector.id?.toString() ?? '',
                              reasonController.text,
                              int.parse(daysController.text),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.error,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.block,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  void _showUnblockInspectorBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => CustomBottomSheet(
        title: AppLocalizations.of(context)!.unblockUser,
        description: AppLocalizations.of(context)!.unblockUserSubtitle,
        cancelText: AppLocalizations.of(context)!.cancel,
        confirmText: AppLocalizations.of(context)!.unblock,
        onCancel: () => Navigator.pop(context),
        onConfirm: () {
          Navigator.pop(context);
          unblockInspectorCubit.unblockInspector(inspector.id?.toString() ?? '');
        },
        icon: Icon(Icons.lock_open, color: ColorManager.lightprimary),
      ),
    );
  }

  void _showAdjustPointsBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: AdjustPointsBottomSheet(
          userId: inspector.id?.toString() ?? '',
          userName: inspector.fullName ?? 'Inspector',
          onAdjustPoints: (userId, points, reason) {
            adjustUserPointsCubit.adjustUserPoints(userId, points, reason);
          },
        ),
      ),
    );
  }
}


class InspectionHistoryCard extends StatelessWidget {
  final AllInpectionEntity inspection;

  final VoidCallback? onViewReport;

  const InspectionHistoryCard({
    required this.inspection,
    this.onViewReport,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorManager.white,
      elevation: 0,
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: ColorManager.lightGrey),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Image, Car Name, Status
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child:

                      Image.network(
                          "${ApiConstant.imageBaseUrl}${inspection.productImage}",
                          width: 64.w,
                          height: 64.h,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 64.w,
                              height: 64.h,
                              decoration: BoxDecoration(
                                color: ColorManager.lightGrey,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Image.asset(
                                ImageAssets.brokenImage,
                              ),
                            );
                          },
                        )

                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        inspection.productName ?? '',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          SvgPicture.asset(
                            ImageAssets.userIcon,
                            width: 18.w,
                            height: 18.h,
                          ),
                          SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              inspection.clientName?? '',
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 4),
                      Row(
                        children: [
                          SvgPicture.asset(
                            ImageAssets.calenderIcon,
                            width: 18.w,
                            height: 18.h,
                          ),
                          SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              (inspection.preferredDate != null &&
                                  inspection.preferredTime != null)
                                  ? "${DateFormat('MMMM d, yyyy').format(DateTime.parse(inspection.preferredDate!))}–${inspection.preferredTime}"
                                  : AppLocalizations.of(context)!.noDataFound,
                              style: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w300,
                                color: ColorManager.textBlack,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor(inspection.status),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    inspection.status ?? '',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 14.sp,
                      color: _getStatusTextColor(inspection.status),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            CustomizedElevatedButton(
              bottonWidget: Text(
                AppLocalizations.of(context)!.viewReport,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 14.sp,
                  color: ColorManager.white,
                ),
              ),
              color: ColorManager.darkGrey,
              borderColor: ColorManager.darkGrey,
              onPressed: () {
                Navigator.of(context).pushNamed(
                  MarketerReportDetails.reportDetailsRouteName,
                  arguments: inspection.id,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'completed':
      case 'done':
        return Color(0xFFD5FCDB);
      case 'pending':
        return Color(0xFFFFEDD5);
      case 'rejected':
      case 'cancelled':
        return Color(0xFFFFE5E5);
      default:
        return Color(0xFFE5E7EB);
    }
  }

  Color _getStatusTextColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'completed':

      case 'done':
        return Color(0xff166534);
      case 'pending':
        return Color(0xFF9A3412);
      case 'rejected':
      case 'cancelled':
        return Color(0xFFDC2626);
      default:
        return Color(0xFF6B7280);
    }
  }
}
