import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/feauture/inspector_screen/inspector_bottom_nav_bar.dart';
import 'package:ankh_project/feauture/inspector_screen/widgets/CustomRadioGroup.dart';
import 'package:ankh_project/feauture/inspector_screen/widgets/client_product_info_card.dart';
import 'package:ankh_project/feauture/inspector_screen/widgets/custom_text_form_field.dart' show CustomTextFormField;
import 'package:ankh_project/feauture/inspector_screen/widgets/photo_list_view.dart';
import 'package:ankh_project/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/customized_widgets/reusable_widgets/customized_elevated_button.dart';

class InspectionReport extends StatefulWidget {
  const InspectionReport({super.key});

  @override
  State<InspectionReport> createState() => _InspectionReportState();
}

class _InspectionReportState extends State<InspectionReport> {

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
            const ClientProductInfoCard(),
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
