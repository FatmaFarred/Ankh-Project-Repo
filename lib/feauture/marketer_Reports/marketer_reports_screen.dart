import 'dart:ui';

import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/core/constants/font_manager/font_style_manager.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/customized_containers/rounded_conatiner_image.dart';
import 'package:ankh_project/domain/entities/marketer_requests_for_inspection_entity.dart';
import 'package:ankh_project/feauture/home_screen/bottom_nav_bar.dart';
import 'package:ankh_project/feauture/myrequest/my_request_details/my_request_details.dart';
import 'package:ankh_project/feauture/myrequest/status_handler_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import '../../api_service/di/di.dart';
import '../../core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import '../../l10n/app_localizations.dart';
import '../authentication/user_controller/user_cubit.dart';
import '../myrequest/controller/cubit.dart';
import '../myrequest/controller/request_states.dart';
import 'marketer_report_details/report_details.dart';

class MarketerReportsScreen extends StatefulWidget {
  const MarketerReportsScreen({super.key});

  @override
  State<MarketerReportsScreen> createState() => _MarketerReportsScreenState();
}

class _MarketerReportsScreenState extends State<MarketerReportsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
  }

  List<MarketerRequestsForInspectionEntity> filterRequests(List<MarketerRequestsForInspectionEntity> all, int index) {
    List<MarketerRequestsForInspectionEntity> filtered = index == 0
        ? all
        : all.where((r) => r.status?.toLowerCase() == getStatusLabelIndex(index).toLowerCase()).toList();
    if (_searchController.text.isNotEmpty) {
      filtered = filtered.where((r) =>
      r.productName!.toLowerCase().contains(_searchController.text.toLowerCase()) ||
          r.clientName!.toLowerCase().contains(_searchController.text.toLowerCase())).toList();
    }
    return filtered;
  }

  String getStatusLabelIndex(int index) {
    switch (index) {
      case 1:
        return 'Pending';
      case 2:
        return 'Completed';
      case 3:
        return 'ClientDidNotRespond';
      case 4:
        return 'Postponed';
      case 5:
        return 'ReturnedToMarketer';
      case 6:
        return 'ClientRejected';


      default:
        return '';
    }
  }

  Future<void> _refreshData() async {
    print("🔄 Refresh triggered!"); // Debug print
    final user = context.read<UserCubit>().state;
    print("👤 User ID: ${user?.id}"); // Debug print
    await context.read<MarketerRequestCubit>().fetchRequests(user?.id ?? "", "roleId");
    print("✅ Refresh completed!"); // Debug print
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserCubit>().state;
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(CupertinoIcons.back),
              color: Colors.white,
              onPressed: () {

                Navigator.pushReplacementNamed(context, BottomNavBar.bottomNavBarRouteName);
              }

          ),
          title: Text(AppLocalizations.of(context)!.reports),
        ),
        body: BlocBuilder<MarketerRequestCubit, MarketerRequestState>(
          builder: (context, state) {
            if (state is MarketerRequestLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MarketerRequestError) {
              return Center(child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(state.error?.errorMessage??"",
                      style: Theme.of(context).textTheme.bodyMedium,

                    ),
                    CustomizedElevatedButton(
                      bottonWidget: Text(AppLocalizations.of(context)!.tryAgain,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(color: ColorManager.white,fontSize: 14.sp),
                      ),
                      color: ColorManager.lightprimary,
                      borderColor: ColorManager.lightprimary,
                      onPressed: () => context.read<MarketerRequestCubit>().fetchRequests(user?.id??"", "roleId"),
                    )
                  ],
                ),
              ));
            } else if (state is MarketerRequestEmpty) {
              return Center(child: Text(AppLocalizations.of(context)!.noRequestsFound));
            } else if (state is MarketerRequestSuccess) {
              final allRequests = state.requests;
              print("All Requests: $allRequests");
              return Column(
                children: [
                 
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 17.w, vertical: 13.h),
                    color: ColorManager.transparent,
                    child: TabBar(
                      controller: _tabController,
                      tabAlignment: TabAlignment.center,
                      dividerColor: ColorManager.transparent,                      isScrollable: true,
                      indicator: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      labelStyle: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.copyWith(color: ColorManager.white),
                      unselectedLabelStyle: Theme.of(context).textTheme.bodyMedium,

                      indicatorSize: TabBarIndicatorSize.tab,
                      tabs:  [
                        Tab(text: AppLocalizations.of(context)!.all),
                        Tab(text: AppLocalizations.of(context)!.pending),
                        Tab(text: AppLocalizations.of(context)!.completed),
                        Tab(text: AppLocalizations.of(context)!.clientDidNotRespond),
                        Tab(text: AppLocalizations.of(context)!.postponed),
                        Tab(text: AppLocalizations.of(context)!.returnedToMarketer),
                        Tab(text: AppLocalizations.of(context)!.clientRejected),
                      ],
                      onTap: (_) => setState(() {}),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: List.generate(7, (tabIndex) {
                        final filteredRequests = filterRequests(allRequests, tabIndex);
                        return RefreshIndicator(
                          color: ColorManager.lightprimary,
                          onRefresh: _refreshData,
                          child: ListView.builder(
                            itemCount: filteredRequests.isEmpty ? 1 : filteredRequests.length,
                            itemBuilder: (context, index) {
                              if (filteredRequests.isEmpty) {
                                return Container(
                                  height: MediaQuery.of(context).size.height * 0.5,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.inbox_outlined,
                                          size: 64,
                                          color: ColorManager.darkGrey,
                                        ),
                                        SizedBox(height: 16),
                                        Text(
                                        AppLocalizations.of(context)!.noRequestsFound,
                                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                            color: ColorManager.darkGrey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                              final request = filteredRequests[index];
                              return CarReportCard(
                                request: request,
                                paddingHorizontal: 20.w,
                                paddingVertical: 12.h,
                              );
                            },
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class CarReportCard extends StatelessWidget {
  CarReportCard({
    super.key,
    required this.request,
    this.showLabel = true,
    required this.paddingVertical,
    required this.paddingHorizontal,
    this.showBotton=true,
  });

  final MarketerRequestsForInspectionEntity request;
  final bool showLabel;
  final double paddingVertical, paddingHorizontal;
  final bool showBotton;

  @override
  Widget build(BuildContext context) {
    print("Request status: ${request.status}"); // Debug print
    return Card(
      color: ColorManager.white,
      elevation: 2,
      margin: EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: paddingVertical),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r), side: BorderSide(color: ColorManager.lightGrey)),
      child: Padding(
        padding: EdgeInsets.symmetric( horizontal: 16.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              request?.productName??"",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 12.h),
            Row(children: [
              Icon(Icons.person_rounded,

              color: ColorManager.lightprimary,
                size: 20.sp,

              ),
              SizedBox(width: 8.w),

              Text(
                request?.clientName??"",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ColorManager.darkGrey,fontSize: 12.sp),
              ),
            ],),
            SizedBox(height: 8.h),

            Row(children: [
              Icon(Icons.visibility,
              color: ColorManager.lightprimary,
                size: 20.sp,

              ),
              SizedBox(width: 8.w),
              Text(
                request?.inspectorName??"",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ColorManager.darkGrey,fontSize: 12.sp),
              ),
            ],),
            SizedBox(height: 8.h),

            Row(children: [
             Icon(Icons.access_time_rounded,
              color: ColorManager.lightprimary,
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                " ${request.preferredDate != null
                    ? DateFormat('MMM dd,  yyyy').format(DateTime.parse(request.preferredDate!))
                    : AppLocalizations.of(context)!.noDataFound}_ ${request.preferredTime != null
                    ? formatTime(request.preferredTime!)
                    : AppLocalizations.of(context)!.noDataFound}",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ColorManager.darkGrey,fontSize: 12.sp),
              ),
            ],),
            SizedBox(height: 8.h),

            Row(children: [
              Icon(Icons.location_on_rounded,
              color: ColorManager.lightprimary,
                size: 20.sp,

              ),
              SizedBox(width: 8.w),
              Text(
                request?.address??"",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ColorManager.darkGrey,fontSize: 12.sp),
              ),
            ],),
            SizedBox(height: 8.h),

            Row(
              children: [
                if (showLabel)
                  Flexible(
                    child: Chip(
                      backgroundColor: getStatusColor(
                        getRequestStatusFromString(request.status) ?? RequestStatus.pending,
                      ),
                      label: Text(
                        getStatusLabel(getRequestStatusFromString(request.status)?? RequestStatus.pending),
                        style: getBoldStyle(
                          fontSize: 10.sp,
                          color: getTextStatusColor(getRequestStatusFromString(request.status)??RequestStatus.pending),
                          context: context,
                        ),
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
                      shape: const StadiumBorder(
                        side: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 12.h),
           showBotton? CustomizedElevatedButton(

              onPressed: () {
                print("request id :${request.id}");
                Navigator.of(context).pushNamed(
                  MarketerReportDetails.reportDetailsRouteName,
                  arguments: request.id,
                );
              },
              color: ColorManager.darkGrey,

              borderColor: ColorManager.darkGrey,
              bottonWidget: Text(
                AppLocalizations.of(context)!.viewReport,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                ),
              ),
            ):SizedBox.shrink() ,
          ],
        ),
      ),
    );
  }
}

String formatTime(String timeStr) {
  try {
    final parts = timeStr.split(':');
    if (parts.length == 2) {
      final hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);

      final now = DateTime.now();
      final dt = DateTime(now.year, now.month, now.day, hour, minute);
      return DateFormat('hh:mm a').format(dt);
    }
  } catch (_) {}
  return timeStr;
}
