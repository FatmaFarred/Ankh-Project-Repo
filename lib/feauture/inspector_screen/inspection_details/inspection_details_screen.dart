import 'dart:io';

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
import '../../../core/customized_widgets/reusable_widgets/custom_dialog.dart';
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
  int? selectedIndex;
  List<XFile> _selectedImages = [];
  final TextEditingController commentController = TextEditingController();

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message ?? "")),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const RequestSubmittedScreen()),
            );
          } else if (state is SubmitInspectionError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message??"An error occurred")));
          }
        },
        builder: (context, submitState) {
          return BlocBuilder<
            InspectionRequestDetailsCubit,
            InspectionRequestDetailsState
          >(
            builder: (context, state) {
              // Define statusOptions here where context is available
              final List<String> statusOptions = [
                AppLocalizations.of(context)!.completed,
                AppLocalizations.of(context)!.clientDidNotRespond,
                AppLocalizations.of(context)!.postponed,
                AppLocalizations.of(context)!.returnedToMarketer,
                AppLocalizations.of(context)!.clientRejected,
              ];
              
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
                        Container(
                          padding: REdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xff777777).withOpacity(0.5)),
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Inspection result",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Column(
                                children: List.generate(statusOptions.length, (index) {
                                  return RadioListTile<int>(
                                    title: Text(
                                      statusOptions[index],
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xff374151),
                                      ),
                                    ),
                                    value: index,
                                    groupValue: selectedIndex,
                                    onChanged: (int? value) {
                                      setState(() {
                                        selectedIndex = value;
                                      });
                                    },
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),

                        /// Image Preview or Upload
                        _selectedImages.isEmpty
                            ? CustomPhotoButtons(
                                onImagesSelected: (List<XFile> images) {
                                  setState(() {
                                    _selectedImages = images;
                                  });
                                },
                              )
                            : Container(
                                padding: REdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(
                                      0xff777777,
                                    ).withOpacity(0.5),
                                  ),
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                child: Wrap(
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: _selectedImages
                                      .map(
                                        (img) => Center(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            child: Image.file(
                                              File(img.path),
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
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
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(
                                        color: ColorManager.white,
                                        fontSize: 16.sp,
                                      ),
                                ),
                          color: Theme.of(context).primaryColor,
                          borderColor: Theme.of(context).primaryColor,
                          onPressed: submitState is SubmitInspectionLoading
                              ? null
                              : () {
                                  if (selectedIndex == null ||
                                      commentController.text.isEmpty) {
                                    String missing = '';
                                    if (selectedIndex == null && commentController.text.isEmpty) {
                                      missing = 'status and comment';
                                    } else if (selectedIndex == null) {
                                      missing = 'status';
                                    } else {
                                      missing = 'comment';
                                    }
                                    CustomDialog.positiveButton(
                                      context: context,
                                      title: "attention", // you may define this key in your l10n
                                      message: "Please provide the $missing before submitting.",
                                      positiveText: "OK",
                                      positiveOnClick: () {
                                        Navigator.of(context).pop();
                                      },
                                    );
                                    return;

                                  }
                                  print("clicked");
                                  print("inspection Id: ${widget.requestId}");
                                  print("result status : ${statusOptions[selectedIndex!]}");
                                  print("inspection index: ${selectedIndex!+1}");

                                  print(
                                    "selected images : ${_selectedImages.map((file) => file.path).toList()}",
                                  );
                                  print("comment : ${commentController.text}");

                                  final entity = InspectionSubmissionEntity(
                                    requestInspectionId: widget.requestId!
                                        .toInt(),
                                    status: selectedIndex!+1,
                                    inspectorComment: commentController.text
                                        .trim(),
                                    images: _selectedImages
                                        .map((file) => file.path)
                                        .toList(),
                                  );

                                  context
                                      .read<SubmitInspectionCubit>()
                                      .submitReport(entity);
                                },
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
