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
import 'package:intl/intl.dart';
import '../../api_service/di/di.dart';
import '../../core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import '../../l10n/app_localizations.dart';
import '../authentication/user_controller/user_cubit.dart';
import 'controller/cubit.dart';
import 'controller/request_states.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
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
        return 'Done';
      case 3:
        return 'Delayed';
      case 4:
        return 'Not Responded';
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
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(CupertinoIcons.back),
            color: Colors.white,
            onPressed: () {

                Navigator.pushReplacementNamed(context, BottomNavBar.bottomNavBarRouteName);
              }

          ),
          title: Text(AppLocalizations.of(context)!.myRequests),
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
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 26.h, horizontal: 20.w),
                    child: TextFormField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: '${AppLocalizations.of(context)!.searchRequest}...',
                        hintStyle: getRegularStyle(color: ColorManager.darkGrey, fontSize: 14, context: context),
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.r),
                            borderSide: BorderSide(color: ColorManager.lightGrey, width: 1.w)),
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                  ),
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
                      tabs: const [
                        Tab(text: 'All'),
                        Tab(text: 'Pending'),
                        Tab(text: 'Done'),
                        Tab(text: 'Delayed'),
                        Tab(text: 'Not Responded'),
                      ],
                      onTap: (_) => setState(() {}),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: List.generate(5, (tabIndex) {
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
                                          "No requests found",
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
                              return InkWell(
                                onTap: () => Navigator.of(context).pushNamed(
                                  MyRequestDetails.myRequestDetailsRouteName,
                                  arguments: request.id,
                                ),
                                child: CarRequestCard(
                                  request: request,
                                  paddingHorizontal: 20.w,
                                  paddingVertical: 12.h,
                                ),
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

class CarRequestCard extends StatelessWidget {
  CarRequestCard({
    super.key,
    required this.request,
    this.showLabel = true,
    required this.paddingVertical,
    required this.paddingHorizontal,
  });

  var  request;
  final bool showLabel;
  final double paddingVertical, paddingHorizontal;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorManager.white,
      elevation: 2,
      margin: EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: paddingVertical),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r), side: BorderSide(color: ColorManager.lightGrey)),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RoundedContainerWidget(
              width: 138.w,
              height: 114.h,
              imagePath: request.productImage ?? '',
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 4.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            request?.productName??"",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
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
                                  overflow: TextOverflow.ellipsis, // ✅ Optional: adds "..." if still too long
                                  softWrap: false,


                                ),
                                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),

                                shape: const StadiumBorder(
                                  side: BorderSide(
                                    color: Colors.transparent, // ✅ Remove border completely
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),

                      Text("${AppLocalizations.of(context)!.client}: ${request.clientName}",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ColorManager.darkGrey,fontSize: 12.sp),

                      ),

                      Text(
                        "${AppLocalizations.of(context)!.created}: ${request.preferredDate != null
                            ? DateFormat('dd MMM yyyy, hh:mm a').format(DateTime.parse(request.preferredDate!))
                            : AppLocalizations.of(context)!.noDataFound} ${request.preferredTime != null
                            ? formatTime(request.preferredTime!)
                            : AppLocalizations.of(context)!.noDataFound}",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ColorManager.darkGrey,fontSize: 12.sp),

                      ),
                      Text(AppLocalizations.of(context)!.price,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ColorManager.darkGrey,fontSize: 12.sp),),

                      Text("Not specified",
                        style: Theme.of(context).textTheme.bodyLarge,

                      ),
                    ],
                  ),
                ],
              ),
            ),
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
      return DateFormat('hh:mm a').format(dt); // --> "03:00 AM"
    }
  } catch (_) {}
  return timeStr; // fallback to original if something goes wrong
}