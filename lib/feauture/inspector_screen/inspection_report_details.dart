
import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/feauture/inspector_screen/widgets/CustomRadioGroup.dart';
import 'package:ankh_project/feauture/inspector_screen/widgets/client_product_info_card.dart';
import 'package:ankh_project/feauture/inspector_screen/widgets/custom_text_form_field.dart'
    show CustomTextFormField;
import 'package:ankh_project/feauture/inspector_screen/widgets/photo_list_view.dart';
import 'package:ankh_project/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api_service/di/di.dart';
import 'inspection_details/inspection_request_details_cubit.dart';
import 'inspection_details/inspection_request_details_state.dart';

class InspectionReportDetails extends StatefulWidget {
  final num? requestId;
  final String? selectedStatus;

  const InspectionReportDetails({
    super.key,
    required this.requestId,
    this.selectedStatus,
  });

  @override
  State<InspectionReportDetails> createState() =>
      _InspectionReportDetailsState();
}

class _InspectionReportDetailsState extends State<InspectionReportDetails> {
  final List<String> statusOptions = [
    'Completed',
    'Client did not respond',
    'Postponed',
    'Returned to marketer',
    'Client rejected',
  ];

  late String? selectedStatus;
  late TextEditingController commentController;

  @override
  void initState() {
    super.initState();
    selectedStatus = widget.selectedStatus;
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InspectionRequestDetailsCubit>(
      create: (context) {
        final cubit = getIt<InspectionRequestDetailsCubit>();
        SharedPreferences.getInstance().then((prefs) {
          final token = prefs.getString('token') ?? '';
          cubit.fetchRequestDetails(
            token: token,
            requestId: widget.requestId?.toInt() ?? 0,
          );
        });
        return cubit;
      },
      child: BlocBuilder<InspectionRequestDetailsCubit,
          InspectionRequestDetailsState>(
        builder: (context, state) {
          if (state is InspectionRequestDetailsLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (state is InspectionRequestDetailsError) {
            return Scaffold(body: Center(child: Text(state.message)));
          } else if (state is InspectionRequestDetailsLoaded) {
            final details = state.details;

            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(CupertinoIcons.back),
                  color: Colors.white,
                  onPressed: () => Navigator.pop(context),
                ),
                title: Text(
                  AppLocalizations.of(context)!.inspectionDetails,
                ),
                centerTitle: true,
                backgroundColor: ColorManager.lightprimary,
              ),
              body: SingleChildScrollView(
                padding: REdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClientProductInfoCard(
                      clientName: details.clientName,
                      phoneNumber: details.phoneNumber,
                      address: details.address,
                      productName: details.productName,
                      appointment: details.appointmentTime,
                    ),
                    SizedBox(height: 20.h),
                    PhotoListView(imageUrls: details.productImages),
                    SizedBox(height: 20.h),

                    // Disabled radio group
                    IgnorePointer(
                      ignoring: true,
                      child: RadioStatusGroup(
                        title: "Inspection result",
                        statusOptions: statusOptions,
                        selectedValue: selectedStatus,
                        onChanged: (_) {},
                      ),
                    ),

                    SizedBox(height: 20.h),

                    // Read-only comment
                    CustomTextFormField(
                      controller: TextEditingController(text: details.inspectorComment),
                      hintText: "Comment",
                      maxLines: 4,
                      enabled: false,
                    ),

                    SizedBox(height: 64.h),
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
