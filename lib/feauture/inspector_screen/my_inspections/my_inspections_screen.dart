import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import 'package:ankh_project/core/customized_widgets/shared_preferences .dart';
import 'package:ankh_project/feauture/inspector_screen/inspection_details/inspection_details_screen.dart';
import 'package:ankh_project/feauture/inspector_screen/my_inspections/my_inspections_cubit.dart';
import 'package:ankh_project/feauture/inspector_screen/my_inspections/my_inspections_state.dart';
import 'package:ankh_project/feauture/marketer_home/home_app_bar.dart';
import 'package:ankh_project/feauture/myrequest/status_handler_widgets.dart';
import 'package:ankh_project/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../domain/entities/all_inpection_entity.dart';
import '../../authentication/user_controller/user_cubit.dart';
import '../../dashboard/inspection_managemnt/ispection_bottom_sheet.dart';
import '../../dashboard/inspection_managemnt/reschedule_cubit.dart';
import '../../home_screen/header_section.dart';
import '../../../api_service/di/di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import 'package:ankh_project/core/customized_widgets/shared_preferences .dart';
import 'package:ankh_project/feauture/inspector_screen/inspection_details/inspection_details_screen.dart';
import 'package:ankh_project/feauture/inspector_screen/my_inspections/my_inspections_cubit.dart';
import 'package:ankh_project/feauture/inspector_screen/my_inspections/my_inspections_state.dart';
import 'package:ankh_project/feauture/marketer_home/home_app_bar.dart';
import 'package:ankh_project/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../domain/entities/all_inpection_entity.dart';
import '../../authentication/user_controller/user_cubit.dart';
import '../../../api_service/di/di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../marketer_Reports/marketer_report_details/report_details.dart';

class MyInspectionsScreen extends StatefulWidget {
  const MyInspectionsScreen({super.key});

  @override
  State<MyInspectionsScreen> createState() => _MyInspectionsScreenState();
}

class _MyInspectionsScreenState extends State<MyInspectionsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late MyInspectionsCubit myInspectionsCubit;
  final TextEditingController _searchController = TextEditingController();
  String? token;
  RescheduleCubit reschedulingCubit = getIt<RescheduleCubit>();


  final List<String> filters = [
    'today',
    'tomorrow',
    'Pending',
    'Completed',
    'ClientDidNotRespond',
    'Postponed',
    'ReturnedToMarketer',
    'ClientRejected',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 8, vsync: this);
    myInspectionsCubit = getIt<MyInspectionsCubit>();
    _loadTokenAndFetch();

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;
      _fetchForTab(_tabController.index);
    });
  }

  Future<void> _loadTokenAndFetch() async {
    final fetchedToken = await SharedPrefsManager.getData(key: 'user_token');
    setState(() {
      token = fetchedToken;
    });
    if (token != null) {
      myInspectionsCubit.fetchInspections(token: token!, filter: filters[0]);
    }
  }

  void _fetchForTab(int index) {
    if (token != null && index < filters.length) {
      myInspectionsCubit.fetchInspections(
        token: token!,
        filter: filters[index],
      );
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    myInspectionsCubit.close();
    super.dispose();
  }

  Future<void> _refreshData(int index) async {
    print("🔄 MyInspections Refresh triggered!");
    if (token != null && index < filters.length) {
      await myInspectionsCubit.fetchInspections(
        token: token!,
        filter: filters[index],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, _) => [
          SliverToBoxAdapter(
            child: HomeAppBar(
              onSearch: (keyword) {
                if (keyword.isNotEmpty) {
                  myInspectionsCubit.searchProducts(
                    keyword: keyword,
                    token: token!,
                  );
                } else {
                  myInspectionsCubit.fetchInspections(
                    token: token!,
                    filter: filters[_tabController.index],
                  );
                }
              },
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 12.h)),
        ],
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 17.w, vertical: 13.h),
              child: TabBar(
                controller: _tabController,
                tabAlignment: TabAlignment.center,
                dividerColor: ColorManager.transparent,
                isScrollable: true,
                indicator: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                labelStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: ColorManager.white,
                ),
                unselectedLabelStyle: Theme.of(context).textTheme.bodyMedium,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [
                  Tab(text: localizations.today),
                  Tab(text: localizations.tomorrow),
                  Tab(text: localizations.pending),
                  Tab(text: localizations.completed),
                  Tab(text: localizations.clientDidNotRespond),
                  Tab(text: localizations.postponed),
                  Tab(text: localizations.returnedToMarketer),
                  Tab(text: localizations.clientRejected),
                ],
                onTap: (index) => _fetchForTab(index),
              ),
            ),
            Expanded(
              child: BlocBuilder<MyInspectionsCubit, MyInspectionsState>(
                bloc: myInspectionsCubit,
                builder: (context, state) {
                  if (state is MyInspectionsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is MyInspectionsError) {
                    print('--- MyInspectionsError State ---');
                    print(state.error.errorMessage);
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(state.error.errorMessage ?? 'Error'),
                            SizedBox(height: 16),
                            CustomizedElevatedButton(
                              bottonWidget: Text(
                                localizations.tryAgain,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(color: ColorManager.white),
                              ),
                              color: ColorManager.lightprimary,
                              borderColor: ColorManager.lightprimary,
                              onPressed: () {
                                print('--- Try Again Button Pressed ---');
                                _fetchForTab(_tabController.index);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  } else if (state is MyInspectionsEmpty) {
                    print('--- MyInspectionsEmpty State ---');
                    return RefreshIndicator(
                      onRefresh: () => _refreshData(_tabController.index),
                      child: ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: [
                          Center(
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
                                  localizations.noInspectionsFound,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(color: ColorManager.darkGrey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (state is MyInspectionsLoaded) {
                    final inspections = state.inspections;
                    return RefreshIndicator(
                      onRefresh: () => _refreshData(_tabController.index),
                      child: Padding(
                        padding: REdgeInsets.symmetric(horizontal: 16),
                        child: ListView.separated(
                          itemCount: inspections.length,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 12.h),
                          itemBuilder: (context, index) {
                            final inspection = inspections[index];
                            return _buildInspectionCard(context, inspection);
                          },
                        ),
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

  Widget _buildInspectionCard(BuildContext context, AllInpectionEntity inspection) {
    return Container(
      padding: REdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF777777).withOpacity(0.5)),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                inspection.clientName ?? '',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: getStatusColor(getRequestStatusFromString(inspection.status)??RequestStatus.pending),
                ),
                child: Text(
                  inspection.status ?? '',
                  style: GoogleFonts.inter(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    color: getTextStatusColor(getRequestStatusFromString(inspection.status)??RequestStatus.pending),
                  ),
                ),
              ),
            ],
          ),
          Text(
            inspection.productName ?? '',
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w300,
              color: Color(0xFF4f4f4f),
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Icon(
                Icons.access_time_rounded,
                size: 14,
                color: ColorManager.lightprimary,
              ),
              SizedBox(width: 6.w),
              Text(
                (inspection.preferredDate != null &&
                    inspection.preferredTime != null)
                    ? "${DateFormat('MMMM d, yyyy').format(DateTime.parse(inspection.preferredDate!))} – ${inspection.preferredTime}"
                    : AppLocalizations.of(context)!.noDataFound,
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w300,
                  color: Color(0xFF4f4f4f),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.location_on_rounded,
                size: 14,
                color: ColorManager.lightprimary,
              ),
              SizedBox(width: 6.w),
              Text(
                inspection.address ?? '',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w300,
                  color: Color(0xFF4f4f4f),
                ),
              ),
            ],
          ),
          SizedBox(height: 26.h),
          switch (inspection.status) {
            "Postponed" => CustomizedElevatedButton(
              bottonWidget: Text(
                "Reschedule",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: ColorManager.white,
                  fontSize: 16.sp,
                ),
              ),
              color: Theme.of(context).primaryColor,
              borderColor: Theme.of(context).primaryColor,
              onPressed: () {
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
            ),
            "Completed" => CustomizedElevatedButton(
              bottonWidget: Text(
                AppLocalizations.of(context)!.viewReport,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: ColorManager.white,
                  fontSize: 16.sp,
                ),
              ),
              color: ColorManager.darkGrey,
              borderColor: ColorManager.darkGrey,
              onPressed: () {
                Navigator.pushNamed(context, MarketerReportDetails.reportDetailsRouteName,
                  arguments: inspection.id,

                );
              },
            ),
            "Pending" => CustomizedElevatedButton(
              bottonWidget: Text(
                AppLocalizations.of(context)!.startInspect,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: ColorManager.white,
                  fontSize: 16.sp,
                ),
              ),
              color: Theme.of(context).primaryColor,
              borderColor: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        InspectionDetailsScreen(requestId: inspection.id),
                  ),
                );
              },
            ),
            "ClientDidNotRespond" || "ClientRejected" || "ReturnedToMarketer" => Row(
              children: [
                Expanded(
                  child:CustomizedElevatedButton(
                    bottonWidget: Text(
                      "View Report",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: ColorManager.white,
                        fontSize: 16.sp,
                      ),
                    ),
                    color: ColorManager.darkGrey,
                    borderColor: ColorManager.darkGrey,
                    onPressed: () {
                      Navigator.pushNamed(context, MarketerReportDetails.reportDetailsRouteName,
                        arguments: inspection.id,

                      );
                    },
                  ),
                ),
              ],
            ),
          // Safely handle any unknown or null status
            null || String() => () {
              // Optional: Log unexpected statuses during development
              // debugPrint('⚠️ Unknown inspection status: ${inspection.status}');
              return const SizedBox.shrink();
            }(),
          },
        ],
      ),
    );
  }
}