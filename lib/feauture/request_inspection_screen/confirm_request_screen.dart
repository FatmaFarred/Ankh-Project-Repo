import 'package:ankh_project/core/constants/assets_manager.dart';
import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import 'package:ankh_project/feauture/request_inspection_screen/request_submitted.dart';
import 'package:ankh_project/l10n/app_localizations.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ConfirmRequestScreen extends StatelessWidget {
  final DateTime scheduleDate = DateTime(2025, 6, 24);

  final TimeOfDay startTime = TimeOfDay(hour: 13, minute: 0);

  final TimeOfDay endTime = TimeOfDay(hour: 14, minute: 0);

  ConfirmRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String formattedDate = DateFormat('yyyy-MM-dd').format(scheduleDate);
    final String formattedTime =
        '${startTime.format(context)} - ${endTime.format(context)}';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back), // Cupertino back icon
          color: Colors.white, // White color
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(AppLocalizations.of(context)!.confirmRequest),
        centerTitle: true,
        backgroundColor: ColorManager.lightprimary,
        titleTextStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          fontSize: 20.sp,
        ),
      ),
      body: ListView(
        padding: REdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: ColorManager.lightprimary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.requestSummary,
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorManager.white,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.requestSummaryNote,
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: ColorManager.white,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),

          /// Product Info Table
          _tableSection(
            title: AppLocalizations.of(context)!.productName,
            rows: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF9FAFB),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Image.asset(
                      ImageAssets.carPic1,
                      height: 60,
                      width: 60,
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Toyota EX30",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Automatic - Electric",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          /// Client Info
          _tableSection(
            title: AppLocalizations.of(context)!.clientInformation,
            rows: [
              _infoRow(Icons.person, "Aya Ali"),

              _infoRow(Icons.phone, "01143267979"),
              _infoRow(Icons.location_on, "Nasr City"),
            ],
          ),

          /// Schedule
          _tableSection(
            title: AppLocalizations.of(context)!.inspectionSchedule,
            rows: [
              _infoRow(Icons.calendar_today, formattedDate),
              _infoRow(Icons.access_time, formattedTime),
            ],
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
          CustomizedElevatedButton(
            bottonWidget: Text(
              AppLocalizations.of(context)!.submitRequest,
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
                  builder: (context) {
                    return RequestSubmittedScreen();
                  },
                ),
              );
            },
          ),
        ],
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
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
      padding: REdgeInsets.all(16),
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
