import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import 'package:ankh_project/feauture/inspector_screen/inspection_details/submit_inspection_cubit.dart';
import 'package:ankh_project/feauture/inspector_screen/request_submitted_screen.dart';
import 'package:ankh_project/feauture/inspector_screen/widgets/CustomRadioGroup.dart';
import 'package:ankh_project/feauture/inspector_screen/widgets/client_product_info_card.dart';
import 'package:ankh_project/feauture/inspector_screen/widgets/custom_text_form_field.dart';
import 'package:ankh_project/feauture/inspector_screen/widgets/custom_upload_take_photo_row.dart';
import 'package:ankh_project/feauture/inspector_screen/widgets/photo_list_view.dart';
import 'package:ankh_project/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../api_service/di/di.dart';
import '../../../domain/entities/inspection_submission_entity.dart';
import 'inspection_request_details_cubit.dart';
import 'inspection_request_details_state.dart';

class InspectionDetailsScreen extends StatefulWidget {
  final num? requestId;

  const InspectionDetailsScreen({super.key, required this.requestId});

  @override
  State<InspectionDetailsScreen> createState() =>
      _InspectionDetailsScreenState();
}

class _InspectionDetailsScreenState extends State<InspectionDetailsScreen> {
  String? selectedStatus;
  List<XFile> _selectedImages = [];
  final List<String> statusOptions = [
    'Completed',
    'Client did not respond',
    'Postponed',
    'Returned to marketer',
    'Client rejected',
  ];

  final TextEditingController commentController = TextEditingController();
  List<String> imagePaths = []; // File paths of picked images

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  void addImages(List<String> paths) {
    setState(() {
      imagePaths.addAll(paths);
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Inspection Id : ${widget.requestId}");
    return MultiBlocProvider(
      providers: [
        BlocProvider<InspectionRequestDetailsCubit>(
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
        ),
        BlocProvider<SubmitInspectionCubit>(
          create: (_) => getIt<SubmitInspectionCubit>(),
        ),
      ],
      child: BlocConsumer<SubmitInspectionCubit, SubmitInspectionState>(
        listener: (context, state) {
          if (state is SubmitInspectionSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const RequestSubmittedScreen()),
            );
          } else if (state is SubmitInspectionError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, submitState) {
          return BlocBuilder<
            InspectionRequestDetailsCubit,
            InspectionRequestDetailsState
          >(
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
                        PhotoListView(
                          imageUrls: details.productImages,
                        ),
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
                        CustomPhotoButtons(
                          onImagesSelected: (List<XFile> images) {
                            setState(() {
                              _selectedImages = images;
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
                          bottonWidget: submitState is SubmitInspectionLoading
                              ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                              : Text(
                            AppLocalizations.of(context)!.submitRequest,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: ColorManager.white,
                              fontSize: 16.sp,
                            ),
                          ),
                          color: Theme.of(context).primaryColor,
                          borderColor: Theme.of(context).primaryColor,
                          onPressed: submitState is SubmitInspectionLoading
                              ? null
                              : () {
                            if (selectedStatus == null || commentController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Please complete all fields"),
                                ),
                              );
                              return;
                            }

                            final entity = InspectionSubmissionEntity(
                              requestInspectionId: widget.requestId!.toInt(),
                              status: selectedStatus!,
                              inspectorComment: commentController.text.trim(),
                              images: imagePaths,
                            );

                            context.read<SubmitInspectionCubit>().submitReport(entity);
                          },
                        ),

                        /// Display error text if there's an error state
                        if (submitState is SubmitInspectionError)
                          Padding(
                            padding: EdgeInsets.only(top: 8.h),
                            child: Text(
                              (submitState as SubmitInspectionError).message,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          );
        },
      ),
    );
  }
}
