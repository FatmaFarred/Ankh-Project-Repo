import 'package:ankh_project/core/constants/assets_manager.dart';
import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import 'package:ankh_project/feauture/myrequest/status_handler_widgets.dart';
import 'package:ankh_project/feauture/request_inspection_screen/request_submitted.dart';
import 'package:ankh_project/l10n/app_localizations.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../api_service/di/di.dart';
import '../my_request_screen.dart';
import 'details_controller/details_request_cubit.dart';
import 'details_controller/request_details_states.dart';

class MyRequestDetails extends StatelessWidget {
  static const String myRequestDetailsRouteName = "myRequestDetails";

  const MyRequestDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final num? requestId = ModalRoute.of(context)?.settings.arguments as num?;

    if (requestId == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.requestDetails),
        ),
        body: Center(child: Text(AppLocalizations.of(context)!.noDataFound)),
      );
  }


    
    return BlocProvider(
      create: (context) => getIt<MarketerRequestDetailsCubit>()..fetchRequests(productId: requestId),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(CupertinoIcons.back),
            color: Colors.white, // White color
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(AppLocalizations.of(context)!.requestDetails),
      
        ),
    body: BlocBuilder<MarketerRequestDetailsCubit, MarketerRequestDetailsState>(
    builder: (context, state) {
    if (state is MarketerRequestDetailsLoading) {
    return const Center(child: CircularProgressIndicator());
    } else if (state is MarketerRequestDetailsError) {
    return Center(child: Text(state.error?.errorMessage??""));
    } else if (state is MarketerRequestDetailsSuccess) {
    final request = state.requestDetails;


    return ListView(
    padding: EdgeInsets.all(20.w),
    children: [
    SizedBox(height: 20),
    Text(AppLocalizations.of(context)!.productInfo,
    style: Theme
        .of(context)
        .textTheme
        .bodyLarge
        ?.copyWith(fontSize: 14.sp
    ),),
    CarRequestCard(
    request: request, paddingHorizontal: 0, paddingVertical: 12.h,),


    _tableSection(
    title: AppLocalizations.of(context)!.clientInformation,
    rows: [
    _infoRow(Icons.person_2_outlined, request?.clientName ?? ""),

    _infoRow(Icons.phone_outlined, request?.phoneNumber ?? ""),
    _infoRow(Icons.location_on_outlined, request?.address ?? ""),
    ],
    ),

    /// Schedule
    _tableSection(
    title: AppLocalizations.of(context)!.inspectionSchedule,
    rows: [
    _infoRow(Icons.calendar_today, request.preferredDate != null
    ? DateFormat('dd/MM/yyyy').format(DateTime.parse(
    request.preferredDate!))
        : AppLocalizations.of(context)!.notAvailable,),
    _infoRow(Icons.access_time, request.preferredTime != null
    ? formatTime(request.preferredTime!)
        : AppLocalizations.of(context)!.notAvailable,
    ),
    ],
    ),
    Text(
    AppLocalizations.of(context)!.currrentStatus,
    style: Theme
        .of(context)
        .textTheme
        .bodyLarge
        ?.copyWith(fontSize: 14.sp),

    ),
    ListTile(
    leading: CircleAvatar(
    backgroundColor: getStatusColor(getRequestStatusFromString(request
        .status) ?? RequestStatus.pending),
    radius: 20.r,
    child: Icon(
    Icons.access_time, size: 20.sp, color: getTextStatusColor(
    getRequestStatusFromString(request.status) ??
    RequestStatus.pending).withOpacity(1)),),
    title: Text(
    getStatusLabel(getRequestStatusFromString(request.status) ??
    RequestStatus.pending),
    style: Theme
        .of(context)
        .textTheme
        .bodyMedium
        ?.copyWith(fontSize: 16.sp, color: getTextStatusColor(
    getRequestStatusFromString(request.status) ??
    RequestStatus.pending)),

    ),
    subtitle: Text('${AppLocalizations.of(context)!.lastUpdated} '
    '${(request.preferredDate != null)
    ? DateFormat('dd/MM/yyyy').format(DateTime.parse(
    request.preferredDate!))
        : AppLocalizations.of(context)!.notAvailable}',
    style: Theme
        .of(context)
        .textTheme
        .bodySmall
        ?.copyWith(fontSize: 12.sp, color: ColorManager.darkGrey),
    ),
    ),


    /// Status Tracker
    Padding(
    padding: const EdgeInsets.only(top: 20, bottom: 12),
    child: Text(
    AppLocalizations.of(context)!.statusTracker,
    style: TextStyle(fontWeight: FontWeight.bold),
    ),
    ),
    statusTracker(context),

    SizedBox(height: 24),
    ],
    );
    }
    return const SizedBox.shrink();

    }
      )
    ),
    );
  }


  Widget _tableSection({required String title, required List<Widget> rows}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: List.generate(rows.length * 2 - 1, (index) {
                if (index.isEven) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: rows[index ~/ 2],
                  );
                } else {
                  return Divider(height: 1, color: Colors.grey.shade300);
                }
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey[700]),
        SizedBox(width: 8),
        Expanded(child: Text(value, style: TextStyle(fontSize: 14))),
      ],
    );
  }

  Widget statusTracker(BuildContext context) {
    return EasyStepper(
      activeStep: 0,
      stepShape: StepShape.circle,
      stepBorderRadius: 14,
      borderThickness: 1,
     // padding: REdgeInsets.all(16),
      stepRadius: 20,
      finishedStepBorderColor: Colors.grey,
      finishedStepTextColor: Colors.grey,
      finishedStepBackgroundColor: Colors.grey.shade200,
      activeStepIconColor: Colors.brown,
      activeStepBorderColor: Colors.orange.shade100,
      activeStepBackgroundColor: Colors.yellow.shade100,
      unreachedStepBackgroundColor: Colors.grey.shade100,
      unreachedStepTextColor: Colors.grey,
      showLoadingAnimation: false,
      steps: [
        EasyStep(
          icon: Icon(Icons.access_time, color: ColorManager.lightprimary),
          customTitle: Text(
            AppLocalizations.of(context)!.pending,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: ColorManager.lightprimary,
            ),
          ),
        ),
        EasyStep(
          icon: Icon(Icons.check_circle_outline),
          customTitle: Text(
            AppLocalizations.of(context)!.done,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: ColorManager.hintColor,
            ),
          ),
        ),
        EasyStep(
          icon: Icon(Icons.schedule),
          customTitle: Text(
            AppLocalizations.of(context)!.delayed,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: ColorManager.hintColor,
            ),
          ),
        ),
        EasyStep(
          icon: Icon(Icons.cancel_outlined),
          customTitle: Text(
            AppLocalizations.of(context)!.notResponding,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: ColorManager.hintColor,
            ),
          ),
        ),
      ],
    );
  }
}
