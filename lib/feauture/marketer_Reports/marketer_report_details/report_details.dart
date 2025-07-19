import 'package:ankh_project/core/constants/assets_manager.dart';
import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import 'package:ankh_project/feauture/inspector_screen/request_submitted_screen.dart';

import 'package:ankh_project/feauture/inspector_screen/widgets/CustomRadioGroup.dart';
import 'package:ankh_project/feauture/inspector_screen/widgets/client_product_info_card.dart';
import 'package:ankh_project/feauture/inspector_screen/widgets/custom_text_form_field.dart';
import 'package:ankh_project/feauture/inspector_screen/widgets/custom_upload_take_photo_row.dart';
import 'package:ankh_project/feauture/inspector_screen/widgets/photo_list_view.dart';
import 'package:ankh_project/feauture/marketer_Reports/marketer_reports_screen.dart';
import 'package:ankh_project/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../domain/entities/marketer_requests_for_inspection_entity.dart';
import '../../inspector_screen/inspector_bottom_nav_bar.dart';

class ReportDetailsScreen extends StatefulWidget {
  static const String reportDetailsRouteName = "ReportDetailsScreen";

  const ReportDetailsScreen({super.key});

  @override
  State<ReportDetailsScreen> createState() =>
      _ReportDetailsScreenState();
}

class _ReportDetailsScreenState extends State<ReportDetailsScreen> {
  String? selectedStatus;
  final List<String> statusOptions = [
    'Completed',
    'Client did not respond',
    'Postponed',
    'Returned to marketer',
    'Client rejected',
  ];


  final TextEditingController commentController = TextEditingController();

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final request = ModalRoute.of(context)?.settings.arguments as MarketerRequestsForInspectionEntity;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Reports Screen"),
        centerTitle: true,
        backgroundColor: ColorManager.lightprimary,
      ),
      body: SingleChildScrollView(
        padding: REdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             CarReportCard(request: request, paddingVertical: 12.h, paddingHorizontal: 20.w,showBotton: true,),
            SizedBox(height: 20.h),

            const PhotoListView(), // Product Images
            SizedBox(height: 20.h),

            RadioStatusGroup(
              title: "Inspection result",
              statusOptions: statusOptions,
              selectedValue: selectedStatus,
              onChanged: (value) {
                setState(() {
                  selectedStatus = value;
                });
              },
            ),
            SizedBox(height: 20.h),

            CustomTextFormField(
              controller: commentController,
              hintText: "Write your comments or notes here...",
              maxLines: 4,
            ),
            SizedBox(height: 64.h),

            CustomizedElevatedButton(
              bottonWidget: Text(
                "Back To home",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: ColorManager.white, fontSize: 16.sp),
              ),
              color: Theme.of(context).primaryColor,
              borderColor: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return InspectorBottomNavBar();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

