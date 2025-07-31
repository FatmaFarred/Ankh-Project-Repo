import 'package:ankh_project/api_service/di/di.dart';
import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/custom_dialog.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/custom_text_field.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import 'package:ankh_project/core/customized_widgets/shared_preferences .dart';
import 'package:ankh_project/feauture/authentication/user_controller/user_cubit.dart';
import 'package:ankh_project/feauture/dashboard/custom_widgets/custom_bottom_sheet.dart';
import 'package:ankh_project/feauture/dashboard/points_management/cubit/points_cubit.dart';
import 'package:ankh_project/feauture/dashboard/points_management/cubit/points_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/request_point_entitty.dart';
import '../../../l10n/app_localizations.dart';
import '../../myrequest/status_handler_widgets.dart';
import 'package:ankh_project/feauture/dashboard/points_management/point_prices_screen.dart';

class PointsScreen extends StatefulWidget {
  const PointsScreen({Key? key}) : super(key: key);

  @override
  State<PointsScreen> createState() => _PointsScreenState();
}

class _PointsScreenState extends State<PointsScreen> {
  PointsCubit pointsCubit = getIt<PointsCubit>();
  String? userToken;

  @override
  void initState() {
    super.initState();
    _loadTokenAndFetchData();
  }

  Future<void> _loadTokenAndFetchData() async {
    userToken = await SharedPrefsManager.getData(key: 'user_token');
    if (userToken != null) {
      pointsCubit.fetchPointsRequests(context, userToken!);
    }
  }

  Future<void> _refreshData() async {
    print("🔄 Points Refresh triggered!"); // Debug print
    if (userToken != null) {
      await pointsCubit.fetchPointsRequests(context, userToken!);
    }
    print("✅ Points Refresh completed!"); // Debug print
  }

  List<RequestPointEntity> get filteredRequests {
    // This will be handled by the cubit state
    return [];
  }




  void _approveRequest(String requestId) {
    if (userToken != null) {
      pointsCubit.approvePointRequest(userToken!, requestId);
    }
  }

  void _rejectRequest(String requestId, String reason) {
    if (userToken != null) {
      pointsCubit.rejectPointRequest(userToken!, requestId, reason);
    }
  }

  void _showApproveBottomSheet(BuildContext context, String requestId) {
    showModalBottomSheet(
      context: context,
      builder: (context) => CustomBottomSheet(
        title: AppLocalizations.of(context)!.approve,
        description: AppLocalizations.of(context)!.approveSubTitle,
        cancelText: AppLocalizations.of(context)!.cancel,
        confirmText: AppLocalizations.of(context)!.approve,
        onCancel: () => Navigator.pop(context),
        onConfirm: () {
          Navigator.pop(context);
          _approveRequest(requestId);
        },
        icon: Icon(Icons.check_circle, color: ColorManager.darkGreen),
      ),
    );
  }

  void _showRejectBottomSheet(BuildContext context, String requestId) {
    final TextEditingController reasonController = TextEditingController();
    
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
                  Icon(Icons.cancel, color: ColorManager.error, size: 24.sp),
                  SizedBox(width: 12.w),
                  Text(
                    AppLocalizations.of(context)!.reject,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              
              // Description
              Text(
                AppLocalizations.of(context)!.rejectSubTitle,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 14.sp,
                  color: ColorManager.textBlack,
                ),
              ),
              SizedBox(height: 20.h),
              
              // Reason input field
              Text(
                AppLocalizations.of(context)!.rejectReason,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: ColorManager.textBlack,
                ),
              ),
              SizedBox(height: 8.h),
              CustomTextField(
                controller: reasonController,
                hintText: AppLocalizations.of(context)!.enterRejectReason,
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
                        AppLocalizations.of(context)!.reject,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: ColorManager.white,
                        ),
                      ),
                      onPressed: () {
                        final reason = reasonController.text.trim();
                        if (reason.isEmpty) {
                          // Show error for empty reason
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(AppLocalizations.of(context)!.enterRejectReason),
                              backgroundColor: ColorManager.error,
                            ),
                          );
                          return;
                        }
                        Navigator.pop(context);
                        _rejectRequest(requestId, reason);
                      },
                      color: ColorManager.error,
                      borderColor: ColorManager.error,
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
    return BlocListener<PointsCubit, PointsState>(
      bloc: pointsCubit,
      listener: (context, state) {
        if (state is ApprovePointLoading) {
          CustomDialog.loading(
            context: context,
            message: AppLocalizations.of(context)!.loading,
            cancelable: false,
          );
        } else if (state is RejectPointLoading) {
          CustomDialog.loading(
            context: context,
            message: AppLocalizations.of(context)!.loading,
            cancelable: false,
          );
        } else if (state is ApprovePointSuccess) {
          Navigator.of(context).pop(); // Close loading dialog
          CustomDialog.positiveButton(
            context: context,
            title: AppLocalizations.of(context)!.success,
            message: state.response ?? '',
            positiveOnClick: () {
              Navigator.of(context).pop();
              // Refresh the data
              if (userToken != null) {
                pointsCubit.fetchPointsRequests( context,userToken!);
              }
            },
          );
        } else if (state is RejectPointSuccess) {
          Navigator.of(context).pop(); // Close loading dialog
          CustomDialog.positiveButton(
            context: context,
            title: AppLocalizations.of(context)!.success,
            message: state.response ?? '',
            positiveOnClick: () {
              Navigator.of(context).pop();
              // Refresh the data
              if (userToken != null) {
                pointsCubit.fetchPointsRequests(context,userToken!);
              }
            },
          );
        } else if (state is ApprovePointError) {
          Navigator.of(context).pop(); // Close loading dialog
          CustomDialog.positiveButton(
            context: context,
            title: AppLocalizations.of(context)!.error,
            message: state.error.errorMessage ??"",
            positiveOnClick: () {
              Navigator.of(context).pop();
            },
          );
        } else if (state is RejectPointError) {
          Navigator.of(context).pop(); // Close loading dialog
          CustomDialog.positiveButton(
            context: context,
            title: AppLocalizations.of(context)!.error,
            message: state.error.errorMessage ?? "",
            positiveOnClick: () {
              Navigator.of(context).pop();
            },
          );
        }
      },
      child: Scaffold(
        backgroundColor: ColorManager.white,
        body: Column(
          children: [
            SizedBox(height: 20.h),

            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.pointsRequest,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18.sp),
                ),
              ],
            ),
            SizedBox(height: 20.h),

            // Point Prices Management Button
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PointPricesScreen(),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                  decoration: BoxDecoration(

                    color: ColorManager.lightprimary,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.monetization_on_outlined,
                        color: ColorManager.white,
                        size: 18.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        AppLocalizations.of(context)!.pointPrice,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: ColorManager.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),

          // Points Requests List
          Expanded(
            child: BlocBuilder<PointsCubit, PointsState>(
              bloc: pointsCubit,
              builder: (context, state) {
                if (state is PointsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is PointsError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(state.error.errorMessage  ?? 'An error occurred'),
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
                                pointsCubit.fetchPointsRequests(context,userToken!);
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  );
                } else if (state is PointsEmpty) {
                  return Center(
                    child: Text(
                      state.message ?? 'No points requests found',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  );
                } else if (state is PointsSuccess) {
                  final allRequests = state.pointsRequests;

                  if (allRequests.isEmpty) {
                    return Center(
                      child: Text(
                        'No requests found',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    );
                  }

                  return RefreshIndicator(
                    color: ColorManager.lightprimary,
                    onRefresh: _refreshData,
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      itemCount: allRequests.length,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final request = allRequests[index];
                        final isPending = request.status == 0;
                
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
                      // Header with name, role, and status
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  request.userName ?? '',
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: ColorManager.textBlack,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  request.roleName ?? '',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontSize: 12.sp,
                                    color: ColorManager.textBlack,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                            decoration: BoxDecoration(
                              color:  getStatusColor(getRequestStatusFromString(request?.status)??RequestStatus.pending ),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              request.status ?? '',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color:  getTextStatusColor(getRequestStatusFromString(request?.status)??RequestStatus.pending ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: 16.h),
                      
                      // Points amount
                      Text(
                        '+${request.points ?? 0}${AppLocalizations.of(context)!.points}',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: ColorManager.lightprimary,
                        ),
                      ),
                      
                      SizedBox(height: 8.h),
                      
                      // Description
                      Text(
                        request.description ?? 'No description provided',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 14.sp,
                          color: ColorManager.textBlack,
                        ),
                      ),
                      
                      SizedBox(height: 12.h),
                      
                      // Request ID and Date
                      Row(
                        children: [

                          Icon(
                            Icons.calendar_today,
                            size: 14.sp,
                            color: ColorManager.textBlack,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                                                DateFormat('MMM DD yyyy hh:mm a').format(
                                                request.createdAt != null
                                                ? DateTime.parse(request.createdAt!)
                                                    : DateTime.now(),
                                                ),
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: 12.sp,
                              color: ColorManager.textBlack,
                            ),
                          ),
                        ],
                      ),

                      // Action buttons for pending requests
                      if (request.status=="Pending") ...[
                        SizedBox(height: 16.h),
                        Row(
                          children: [
                            Expanded(
                              child: CustomizedElevatedButton(
                                bottonWidget: Text(
                                  'Reject',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: ColorManager.white,
                                  ),
                                ),
                                onPressed: () => _showRejectBottomSheet(context, request.id ?? ''),
                                color: ColorManager.error,
                                borderColor: ColorManager.error,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: CustomizedElevatedButton(
                                bottonWidget: Text(
                                  'Approve',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: ColorManager.white,
                                  ),
                                ),
                                onPressed: () => _showApproveBottomSheet(context, request.id ?? ''),
                                color: ColorManager.lightprimary,
                                borderColor: ColorManager.lightprimary,
                              ),
                            ),
                          ],
                        ),
                      ],
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