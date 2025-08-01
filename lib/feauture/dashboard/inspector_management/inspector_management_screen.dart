import 'package:ankh_project/core/constants/assets_manager.dart';
import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/feauture/dashboard/custom_widgets/custom_bottom_sheet.dart';
import 'package:ankh_project/feauture/dashboard/users_management/user_details_screen.dart';
import 'package:ankh_project/feauture/inspector_screen/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/custom_dialog.dart';
import 'package:ankh_project/feauture/dashboard/inspector_management/cubit/inspector_management_cubit.dart';
import 'package:ankh_project/domain/entities/all_inspectors_entity.dart';
import 'package:get_it/get_it.dart';

import '../../../core/customized_widgets/reusable_widgets/custom_text_field.dart';
import '../../../core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import '../../../core/customized_widgets/reusable_widgets/customized_search_bar.dart';
import '../../../l10n/app_localizations.dart';
import 'inspector_details_screen.dart';

class InspectorManagementScreen extends StatefulWidget {
  const InspectorManagementScreen({Key? key}) : super(key: key);

  @override
  State<InspectorManagementScreen> createState() => _InspectorManagementScreenState();
}

class _InspectorManagementScreenState extends State<InspectorManagementScreen> {
  InspectorManagementCubit inspectorManagementCubit = GetIt.instance<InspectorManagementCubit>();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    inspectorManagementCubit.getAllInspectors();
  }

  @override
  void dispose() {
    inspectorManagementCubit.close();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _refreshData() async {
    if (_searchController.text.isEmpty) {
      await inspectorManagementCubit.getAllInspectors();
    } else {
      await inspectorManagementCubit.searchInspectors(keyWord: _searchController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.inspectorManagement,
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: 18.sp),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomizedSearchBar(
              hintText: AppLocalizations.of(context)!.search,
              outlineInputBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide:  BorderSide(
                    color: ColorManager.lightGreyShade2,
                    width: 2,
                  )),


              onSearch: (keyword) {
              if (keyword.isEmpty) {
                inspectorManagementCubit.getAllInspectors();
              } else {
                inspectorManagementCubit.searchInspectors(keyWord: keyword);
              }
            },
            ),
          ),
          Expanded(
            child: BlocBuilder<InspectorManagementCubit, InspectorManagementState>(
              bloc: inspectorManagementCubit,
              builder: (context, state) {
                if (state is InspectorManagementLoading) {
                  return Center(child: CircularProgressIndicator(color: ColorManager.lightprimary));
                } else if (state is InspectorManagementFailure) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(state.error?.errorMessage??""),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => inspectorManagementCubit.getAllInspectors(),
                          child: Text(AppLocalizations.of(context)!.tryAgain),
                        ),
                      ],
                    ),
                  );
                } else if (state is InspectorManagementEmpty) {
                  return RefreshIndicator(
                    color: ColorManager.lightprimary,
                    onRefresh: _refreshData,
                    child: ListView(
                      children: [
                        Container(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.5,
                          child: Center(
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
                                  AppLocalizations.of(context)!.noProductsFound,
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                    color: ColorManager.darkGrey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (state is InspectorManagementSuccess) {
                  return RefreshIndicator(
                    color: ColorManager.lightprimary,
                    onRefresh: _refreshData,
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      itemCount: state.inspectors.length,
                      itemBuilder: (context, index) {
                        final inspector = state.inspectors[index];
                        return InspectorCard(
                          inspector: inspector,
                          onViewPressed: () {
                            Navigator.of(context).pushNamed(
                              InspectorDetailsScreen.routeName,
                              arguments: inspector,
                            );
                          },
                        );
                      },
                    ),
                  );
                }
                return SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class InspectorCard extends StatelessWidget {
  final AllInspectorsEntity inspector;
  final bool showBottons;
  final VoidCallback? onViewPressed;

  const InspectorCard({
    Key? key,
    required this.inspector,
    this.showBottons = true,
    this.onViewPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: ColorManager.white,
      margin: EdgeInsets.symmetric(vertical: 8.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
        side: BorderSide(color: ColorManager.lightGrey),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  ImageAssets.userIcon,
                  height: 18.h,
                  width: 18.w,
                ),
                SizedBox(width: 6.w),
                Text(
                  inspector.fullName ?? '',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                ),
               /* const Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: isActive ? const Color(0xFFDCFCE7) : const Color(0xFFFFEDD5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    inspector.accountStatus ?? '',
                    style: TextStyle(
                      color: isActive ? const Color(0xFF166534) : const Color(0xFF9A3412),
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ),*/
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                SvgPicture.asset(
                  ImageAssets.callIcon,
                  height: 18.h,
                  width: 18.w,
                ),
                SizedBox(width: 6.w),
                Text(
                  inspector.phoneNumber ?? '',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                SvgPicture.asset(
                  ImageAssets.mailIcon,
                  height: 18.h,
                  width: 18.w,
                ),
                SizedBox(width: 6.w),
                Text(
                  inspector.email ?? '',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                ),
              ],
            ),
            SizedBox(height: 10.h),

            Row(
              children: [
                Icon(
                  Icons.visibility,
                  color: ColorManager.lightprimary,
                  size: 20.sp,
                ),
                SizedBox(width: 6.w),
                Text(
                  "${AppLocalizations.of(context)!.totalInspections} :",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                ),
                Text(
                  inspector.totalInspections?.toString() ?? '0',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                SvgPicture.asset(
                  ImageAssets.completedIcon,
                  height: 18.h,
                  width: 18.w,
                ),
                SizedBox(width: 6.w),
                Text(
                  "${AppLocalizations.of(context)!.completed} :",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                ),
                Text(
                  inspector.completedInspections?.toString() ?? '0',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                ),
              ],
            ),
            // Vehicle Type
            if (inspector.vehicleType != null && inspector.vehicleType!.isNotEmpty) ...[
              SizedBox(height: 10.h),
              Row(
                children: [
                  SvgPicture.asset(
                    ImageAssets.carIcon2,
                    height: 18.h,
                    width: 18.w,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    "${AppLocalizations.of(context)!.vehicleType} :",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                  ),
                  Text(
                    inspector.vehicleType ?? '',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                  ),
                ],
              ),
            ],
            // License Number
            if (inspector.licenseNumber != null && inspector.licenseNumber!.isNotEmpty) ...[
              SizedBox(height: 10.h),
              Row(
                children: [
                  Icon(
                    Icons.credit_card,
                    color: ColorManager.lightprimary,
                    size: 18.sp,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    "${AppLocalizations.of(context)!.licenseNumber} :",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                  ),
                  Text(
                    inspector.licenseNumber ?? '',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                  ),
                ],
              ),
            ],
            // Vehicle License Number
            if (inspector.vehicleLicenseNumber != null && inspector.vehicleLicenseNumber!.isNotEmpty) ...[
              SizedBox(height: 10.h),
              Row(
                children: [
                  Icon(
                    Icons.car_rental,
                    color: ColorManager.lightprimary,
                    size: 18.sp,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    "${AppLocalizations.of(context)!.vehicleLicenseNumber} :",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                  ),
                  Text(
                    inspector.vehicleLicenseNumber ?? '',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                  ),
                ],
              ),
            ],
            // Work Area
            if (inspector.workArea != null && inspector.workArea!.isNotEmpty) ...[
              SizedBox(height: 10.h),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: ColorManager.lightprimary,
                    size: 18.sp,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    "${AppLocalizations.of(context)!.workArea} :",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                  ),
                  Text(
                    inspector.workArea ?? '',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                  ),
                ],
              ),
            ],
            // License Image
            // Vehicle Image
            SizedBox(height: 10.h),
            showBottons
                ? Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: ColorManager.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(color: ColorManager.darkGrey),
                            ),
                          ),
                          onPressed: onViewPressed,
                          icon: Icon(
                            Icons.visibility,
                            color: Color(0xffD4AF37),
                            size: 20.sp,
                          ),
                          label: Text(
                            AppLocalizations.of(context)!.view,
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 12.sp,
                              color: ColorManager.lightprimary,
                            ),
                          ),
                        ),
                      ),
                     /* ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(color: ColorManager.darkGrey),
                          ),
                        ),
                        onPressed: () {
                          _showBottomSheet(
                            context: context,
                            title: AppLocalizations.of(context)!.rejectUserAccount,
                            description: AppLocalizations.of(context)!.rejectUserAccountSubtitle,
                            cancelText: AppLocalizations.of(context)!.cancel,
                            confirmText: AppLocalizations.of(context)!.reject,
                            onCancel: () => Navigator.pop(context),
                            onConfirm: () {},
                            icon: Icon(Icons.delete, color: ColorManager.error),
                          );
                        },
                        icon: Icon(
                          Icons.delete,
                          color: ColorManager.error,
                          size: 20.sp,
                        ),
                        label: Text(
                          AppLocalizations.of(context)!.delete,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 12.sp,
                            color: ColorManager.lightprimary,
                          ),
                        ),
                      ),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: ColorManager.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(color: ColorManager.darkGrey),
                          ),
                        ),
                        onPressed: () {
                          _showBottomSheet(
                            context: context,
                            title: AppLocalizations.of(context)!.suspendUserAccount,
                            description: AppLocalizations.of(context)!.suspendUserAccountSubtitle,
                            cancelText: AppLocalizations.of(context)!.cancel,
                            confirmText: AppLocalizations.of(context)!.confirm,
                            onCancel: () => Navigator.pop(context),
                            onConfirm: () {},
                            icon: Icon(Icons.lock, color: ColorManager.error),
                          );
                        },
                        icon: Icon(
                          Icons.lock,
                          color: ColorManager.lightprimary,
                          size: 20.sp,
                        ),
                        label: Text(
                          isActive
                              ? AppLocalizations.of(context)!.suspend
                              : AppLocalizations.of(context)!.unsuspend,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 12.sp,
                            color: ColorManager.lightprimary,
                          ),
                        ),
                      ),*/
                    ],
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  void _showBottomSheet({
    required BuildContext context,
    required String title,
    required String description,
    required String cancelText,
    required String confirmText,
    required VoidCallback onCancel,
    required VoidCallback onConfirm,
    Color? cancelColor,
    Color? confirmColor,
    Widget? icon,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (context) => CustomBottomSheet(
        title: title,
        description: description,
        cancelText: cancelText,
        confirmText: confirmText,
        onCancel: onCancel,
        onConfirm: onConfirm,
        icon: icon,
      ),
    );
  }
}