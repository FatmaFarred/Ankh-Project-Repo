import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import 'package:ankh_project/feauture/inspector_screen/inspection_report_details.dart';
import 'package:ankh_project/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../api_service/di/di.dart';
import '../../../core/customized_widgets/shared_preferences .dart';
import '../../../domain/entities/all_inpection_entity.dart';
import '../../../domain/entities/inspection_request_details_entity.dart';
import '../../home_screen/bottom_nav_bar.dart';
import '../../marketer_Reports/marketer_report_details/report_details.dart';
import '../my_inspections/my_inspections_cubit.dart';
import '../my_inspections/my_inspections_state.dart';
import 'package:ankh_project/feauture/marketer_Reports/marketer_report_details/report_details/report_details_cubit.dart';
import 'package:ankh_project/feauture/marketer_Reports/marketer_report_details/report_details/report_details_state.dart';

class InspectorReportsScreen extends StatefulWidget {
  const InspectorReportsScreen({super.key});

  @override
  State<InspectorReportsScreen> createState() => _InspectorReportsScreenState();
}

class _InspectorReportsScreenState extends State<InspectorReportsScreen> {
  final List<String> filters = [
    'Completed',
    'ClientDidNotRespond',
    'Postponed',
    'ReturnedToMarketer',
    'ClientRejected',
  ];

  late MyInspectionsCubit myInspectionsCubit;
  String? fetchedToken;

  @override
  void initState() {
    super.initState();
    myInspectionsCubit = getIt<MyInspectionsCubit>();
    _loadTokenAndFetch();
  }

  Future<void> _loadTokenAndFetch() async {
    fetchedToken = await SharedPrefsManager.getData(key: 'user_token');
    if (fetchedToken != null) {
      myInspectionsCubit.fetchReports(token: fetchedToken!, filters: filters);
    }
  }

  Future<void> _onRefresh() async {
    if (fetchedToken != null) {
      await myInspectionsCubit.fetchReports(token: fetchedToken!, filters: filters);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          color: Colors.white,
          onPressed: () {
            Navigator.pushReplacementNamed(context, BottomNavBar.bottomNavBarRouteName);
          },
        ),
        title:  Text(AppLocalizations.of(context)!.reports),
        centerTitle: true,
        backgroundColor: ColorManager.lightprimary,
      ),
      body: BlocProvider.value(
        value: myInspectionsCubit,
        child: BlocBuilder<MyInspectionsCubit, MyInspectionsState>(
          builder: (context, state) {
            if (state is MyInspectionsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MyInspectionsError) {
              return Center(child: Text(state.error.toString()));
            } else if (state is MyInspectionsEmpty) {
              return Center(child: Text(AppLocalizations.of(context)!.noDataFound));
            } else if (state is MyInspectionsLoaded) {
              return RefreshIndicator(
                color: ColorManager.lightprimary,
                onRefresh: _onRefresh,
                child: Padding(
                  padding: REdgeInsets.symmetric(horizontal: 14, vertical: 20),
                  child: ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: state.inspections.length,
                    itemBuilder: (context, index) {
                      final inspection = state.inspections[index];
                      return _buildReportCard(context, inspection);
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 12.h),
                  ),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildReportCard(BuildContext context, AllInpectionEntity inspection) {
    return Container(
      padding: REdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFF777777).withOpacity(0.5),
        ),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name & Date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                inspection.clientName ?? "",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                inspection.time?.split("T").first ?? "",
                style: GoogleFonts.inter(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF279C07),
                ),
              ),
            ],
          ),

          // Product
          Text(
            inspection.productName ?? "",
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w300,
              color: const Color(0xFF4f4f4f),
            ),
          ),

          // Time
          Row(
            children: [
              Icon(Icons.access_time_rounded, size: 14, color: ColorManager.lightprimary),
              SizedBox(width: 6.w),
              Text(
                inspection.preferredTime ?? "",
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w300,
                  color: const Color(0xFF4f4f4f),
                ),
              ),
            ],
          ),

          // Address
          Row(
            children: [
              Icon(Icons.location_on_rounded, size: 14, color: ColorManager.lightprimary),
              SizedBox(width: 6.w),
              Text(
                inspection.address ?? "",
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w300,
                  color: const Color(0xFF4f4f4f),
                ),
              ),
            ],
          ),

          SizedBox(height: 26.h),

          // Status
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              color: const Color(0xFFE5E7EB),
            ),
            child: Text(
              inspection.status ?? AppLocalizations.of(context)!.completed,
              style: GoogleFonts.inter(
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF279C07),
              ),
            ),
          ),

          SizedBox(height: 26.h),

          // Button
          CustomizedElevatedButton(
            bottonWidget: Text(
              AppLocalizations.of(context)!.viewReport,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: ColorManager.white,
                fontSize: 16.sp,
              ),
            ),
            color: const Color(0xff777777),
            borderColor: Theme.of(context).primaryColor,
            onPressed: () {
              Navigator.pushNamed(context, MarketerReportDetails.reportDetailsRouteName,
                arguments: inspection.id,

              );
            },
          ),

        ],
      ),
    );
  }
}
