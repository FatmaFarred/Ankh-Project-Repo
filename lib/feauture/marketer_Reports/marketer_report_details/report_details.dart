import 'package:ankh_project/core/constants/assets_manager.dart';
import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import 'package:ankh_project/feauture/inspector_screen/request_submitted_screen.dart';

import 'package:ankh_project/feauture/inspector_screen/widgets/CustomRadioGroup.dart';
import 'package:ankh_project/feauture/inspector_screen/widgets/client_product_info_card.dart';
import 'package:ankh_project/feauture/inspector_screen/widgets/custom_text_form_field.dart';
import 'package:ankh_project/feauture/inspector_screen/widgets/custom_upload_take_photo_row.dart';
import 'package:ankh_project/feauture/inspector_screen/widgets/photo_list_view.dart';
import 'package:ankh_project/feauture/marketer_Reports/marketer_report_details/report_details/report_details_cubit.dart';
import 'package:ankh_project/feauture/marketer_Reports/marketer_report_details/report_details/report_details_state.dart';
import 'package:ankh_project/feauture/marketer_Reports/marketer_reports_screen.dart';
import 'package:ankh_project/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ankh_project/domain/entities/inspection_report_details_entity.dart';
import 'package:ankh_project/api_service/di/di.dart';
import 'package:get_it/get_it.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/font_manager/font_style_manager.dart';
import '../../../domain/entities/marketer_requests_for_inspection_entity.dart';
import '../../authentication/user_controller/user_cubit.dart';
import '../../home_screen/bottom_nav_bar.dart';
import '../../myrequest/status_handler_widgets.dart';

class MarketerReportDetails extends StatefulWidget {
  static const String reportDetailsRouteName = "MarketerReportDetails";

  const MarketerReportDetails({super.key, });

  @override
  State<MarketerReportDetails> createState() => _MarketerReportDetailsState();
}

class _MarketerReportDetailsState extends State<MarketerReportDetails> {
  String? selectedStatus;
  MarketerReportDetailsCubit getMarketerReportDetailsCubit = getIt<MarketerReportDetailsCubit>();
  final List<String> statusOptions = [
    'Completed',
    'Client did not respond',
    'Postponed',
    'Returned to marketer',
    'Client rejected',
  ];

  num? requestId;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final user = context.read<UserCubit>().state;
      final userId = user?.id;
      final args = ModalRoute.of(context)?.settings.arguments as num?;
      if (args != null) {
        setState(() {
          requestId = args;
        });

        getMarketerReportDetailsCubit.fetchReportDetails(requestId: requestId ?? 0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(AppLocalizations.of(context)!.inspectionReport,),
        centerTitle: true,
        backgroundColor: ColorManager.lightprimary,
      ),
      body: BlocBuilder<MarketerReportDetailsCubit, MarketerReportDetailsState>(
        bloc: getMarketerReportDetailsCubit,
        builder: (context, state) {
          if (state is MarketerReportDetailsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is MarketerReportDetailsError) {
            return Center(
                child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(state.error?.errorMessage ?? "",
                      style: Theme.of(context).textTheme.bodyMedium),
                  CustomizedElevatedButton(
                    bottonWidget: Text(AppLocalizations.of(context)!.tryAgain,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: ColorManager.white, fontSize: 14.sp)),
                    color: ColorManager.lightprimary,
                    borderColor: ColorManager.lightprimary,
                    onPressed: () => getMarketerReportDetailsCubit
                        .fetchReportDetails(requestId: requestId ?? 0),
                  )
                ],
              ),
            ));
          } else if (state is MarketerReportDetailsLoaded) {
            final details = state.reportDetails;
            
            // Set the selected status from API response
            if (selectedStatus == null && details?.status != null) {
              selectedStatus = details!.status;
            }
            
            return RefreshIndicator(
              onRefresh: () async {
                await getMarketerReportDetailsCubit
                    .fetchReportDetails(requestId: requestId ?? 0);
              },
              color: ColorManager.lightprimary,
              child: SingleChildScrollView(
                padding: REdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CarReportDetailsCard(
                        details: details, paddingVertical: 0, paddingHorizontal: 0),
                    SizedBox(height: 20.h),
                    PhotoListView(
                      imageUrls: details?.productImages ?? [],
                    ),
                    (details.inspectionImages == null || details.inspectionImages!.isEmpty || details.inspectorComment == null)?SizedBox():Column(
                      children: [
                        RadioStatusGroup(
                          title: AppLocalizations.of(context)!.inspectionResults,
                          statusOptions: statusOptions,
                          selectedValue: selectedStatus,
                          onChanged: (value) {
                            // Empty function - no action taken, making it read-only
                          },
                        ),

                    SizedBox(height: 20.h),
                    CustomTextFormField(
                      hintText: "",
                      maxLines: 4,
                      enabled: false, // Make it read-only
                      initialValue: details?.inspectorComment ?? "", // Display comment from API
                    ),
                    SizedBox(height: 64.h),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}

class CarReportDetailsCard extends StatelessWidget {
  CarReportDetailsCard({
    super.key,
    required this.details,
    this.showLabel = true,
    required this.paddingVertical,
    required this.paddingHorizontal,
    this.showBotton=true,
  });

  final InspectionReportDetailsEntity details;
  final bool showLabel;
  final double paddingVertical, paddingHorizontal;
  final bool showBotton;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorManager.white,
      elevation: 0,
      margin: EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: paddingVertical),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r), side: BorderSide(color: const Color(0xff777777).withOpacity(0.5))),
      child: Padding(
        padding: EdgeInsets.symmetric( horizontal: 16.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(ImageAssets.carIcon,
                  width: 17.w,
                  height: 17.h,
                  color: ColorManager.lightprimary,
                  fit: BoxFit.cover,

                ),
                SizedBox(width: 8.w),
                Text(
                  details?.productName??"",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ColorManager.textBlack,fontSize: 14.sp),
                ),
                Spacer(),
                Chip(
                  backgroundColor: getStatusColor(
                    getRequestStatusFromString(details.status) ?? RequestStatus.pending,
                  ),
                  label: Text(
                    getStatusLabel(getRequestStatusFromString(details.status)?? RequestStatus.pending),
                    style: getBoldStyle(
                      fontSize: 10.sp,
                      color: getTextStatusColor(getRequestStatusFromString(details.status)??RequestStatus.pending),
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
              ],
            ),
           // SizedBox(height: 4.h),
            Row(children: [
              Icon(Icons.person_rounded,

                color: ColorManager.lightprimary,
                size: 20.sp,

              ),
              SizedBox(width: 8.w),

              Text(
                details?.clientName??"",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ColorManager.textBlack,fontSize: 14.sp),
              ),
            ],),
            SizedBox(height: 8.h),

            Row(children: [
              Icon(Icons.calendar_month,
                color: ColorManager.lightprimary,
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                " ${details.appointmentDate != null
                    ? DateFormat('MMM dd,  yyyy').format(DateTime.parse(details.appointmentDate!))
                    : AppLocalizations.of(context)!.noDataFound}_ ${details.appointmentTime != null
                    ? formatTime(details.appointmentTime!)
                    : AppLocalizations.of(context)!.noDataFound}",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ColorManager.textBlack,fontSize: 14.sp),
              ),
            ],),
            SizedBox(height: 8.h),

            Row(children: [
              Icon(Icons.phone,
                color: ColorManager.lightprimary,
                size: 20.sp,

              ),
              SizedBox(width: 8.w),
              Text(
                details?.phoneNumber??"",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ColorManager.textBlack,fontSize: 14.sp),
              ),
            ],),
            SizedBox(height: 8.h),

          ],
        ),
      ),
    );
  }
}

