import 'package:ankh_project/core/constants/assets_manager.dart';
import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/domain/entities/all_marketers_entity.dart';
import 'package:ankh_project/feauture/dashboard/custom_widgets/custom_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import '../../../authentication/user_controller/user_cubit.dart';
import '../cubit/rate_user_cubit.dart';
import '../cubit/rate_user_states.dart';

import '../../../../api_service/di/di.dart';
import '../../../../l10n/app_localizations.dart';
import '../cubit/update_marketer_status_cubit.dart';
import '../cubit/update_marketer_status_states.dart';

import 'account_status_handler.dart';
import 'package:ankh_project/core/constants/assets_manager.dart';
import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/domain/entities/all_marketers_entity.dart';
import 'package:ankh_project/feauture/dashboard/custom_widgets/custom_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import '../../../authentication/user_controller/user_cubit.dart';
import '../cubit/rate_user_cubit.dart';
import '../cubit/rate_user_states.dart';
import '../../../../api_service/di/di.dart';
import '../../../../l10n/app_localizations.dart';
import '../cubit/update_marketer_status_cubit.dart';
import '../cubit/update_marketer_status_states.dart';
import 'account_status_handler.dart';

class MarketerCard extends StatelessWidget {
  final AllMarketersEntity marketer;
  final VoidCallback onViewPressed;
  final VoidCallback? onRefresh;
  final UpdateMarketerStatusCubit? updateMarketerStatusCubit;

  const MarketerCard({
    Key? key,
    required this.marketer,
    required this.onViewPressed,
    this.onRefresh,
    this.updateMarketerStatusCubit,
  }) : super(key: key);

  void _handleAccept(BuildContext context) {
    final cubit = updateMarketerStatusCubit ?? getIt<UpdateMarketerStatusCubit>();
    cubit.updateMarketerAccountStatus(1, marketer.id ?? '');
    Navigator.pop(context);
  }

  void _handleReject(BuildContext context) {
    final cubit = updateMarketerStatusCubit ?? getIt<UpdateMarketerStatusCubit>();
    cubit.updateMarketerAccountStatus(2, marketer.id ?? '');
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isActive = marketer.accountStatus?.toLowerCase() == 'active';
    final user = context.read<UserCubit>().state;
    final isAdmin = user?.roles?.contains('Admin') == true;

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
                  marketer.fullName ?? '',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                ),
                const Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: getAccountStatusColor(getAccountRequestStatusFromString(marketer.accountStatus) ?? AccountStatus.Pending),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    marketer.accountStatus ?? '',
                    style: TextStyle(
                      color: getAccountTextStatusColor(getAccountRequestStatusFromString(marketer.accountStatus) ?? AccountStatus.Pending),
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ),
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
                  marketer.phoneNumber ?? '',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                ),
                if (isAdmin) ...[
                  const Spacer(),
                  GestureDetector(
                    onTap: () => _showRateBottomSheet(context),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.amber.withOpacity(0.3)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star_rate, color: Colors.amber, size: 16.sp),
                          SizedBox(width: 6.w),
                          Text(
                            AppLocalizations.of(context)!.enterYourRate,
                            style: TextStyle(
                              color: Colors.amber.shade700,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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
                  marketer.email ?? '',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                ),
              ],
            ),
            SizedBox(height: 14.h),
            Row(
              children: [
                SvgPicture.asset(
                  ImageAssets.assignedIcon,
                  height: 18.h,
                  width: 18.w,
                ),
                SizedBox(width: 6.w),
                Text(
                  "${AppLocalizations.of(context)!.requestInspection} :",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                ),
                SizedBox(width: 4.w),
                Text(
                  marketer.productsCount?.toString() ?? '',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
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
                    color: const Color(0xffD4AF37),
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
                ElevatedButton.icon(
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
                      onConfirm: () => _handleReject(context),
                      icon: Icon(Icons.delete, color: ColorManager.error),
                    );
                  },
                  icon: Icon(
                    Icons.delete,
                    color: ColorManager.error,
                    size: 20.sp,
                  ),
                  label: Text(
                    AppLocalizations.of(context)!.reject,
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
                      title: AppLocalizations.of(context)!.acceptUserAccount,
                      description: AppLocalizations.of(context)!.acceptUserAccountSubtitle,
                      cancelText: AppLocalizations.of(context)!.cancel,
                      confirmText: AppLocalizations.of(context)!.confirm,
                      onCancel: () => Navigator.pop(context),
                      onConfirm: () => _handleAccept(context),
                      icon: Icon(Icons.lock, color: ColorManager.error),
                    );
                  },
                  icon: Icon(
                    Icons.lock_open_rounded,
                    color: ColorManager.lightprimary,
                    size: 20.sp,
                  ),
                  label: Text(
                    AppLocalizations.of(context)!.accept,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 12.sp,
                      color: ColorManager.lightprimary,
                    ),
                  ),
                ),
              ],
            ),
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
    required Widget icon,
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

  void _showRateBottomSheet(BuildContext context) {
    final TextEditingController _rateController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => BlocListener<RateUserCubit, RateUserState>(
        listener: (context, state) {
          if (state is RateUserSuccess) {
            // ✅ Show success dialog first
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(AppLocalizations.of(context)!.success),
                content: Text(state.message ?? AppLocalizations.of(context)!.success),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Close dialog
                      Navigator.pop(context); // Close bottom sheet
                      if (onRefresh != null) onRefresh!();
                    },
                    child: Text(AppLocalizations.of(context)!.ok),
                  ),
                ],
              ),
            );
          } else if (state is RateUserFailure) {
            // ✅ Show error dialog
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(AppLocalizations.of(context)!.error),
                content: Text(state.error.errorMessage ?? 'حدث خطأ'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context), // Close dialog only
                    child: Text(AppLocalizations.of(context)!.ok),
                  ),
                ],
              ),
            );
          }
        },
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SizedBox(
            height: 350.h,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.amber.withOpacity(0.1),
                        radius: 30,
                        child: CircleAvatar(
                          backgroundColor: Colors.amber.withOpacity(0.2),
                          child: Icon(Icons.star_rate, color: Colors.amber),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.close, size: 24.sp, color: ColorManager.darkGrey),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    AppLocalizations.of(context)!.marketerRate,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontSize: 18.sp,
                      color: Colors.amber.shade700,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    AppLocalizations.of(context)!.marketerRate,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 14.sp,
                      color: ColorManager.darkGrey,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  TextField(
                    controller: _rateController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.enterYourRate,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    children: [
                      Expanded(
                        child: CustomizedElevatedButton(
                          bottonWidget: Text(
                            AppLocalizations.of(context)!.cancel,
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 16.sp),
                          ),
                          onPressed: () => Navigator.pop(context),
                          borderColor: ColorManager.lightGrey,
                          color: ColorManager.white,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: BlocBuilder<RateUserCubit, RateUserState>(
                          builder: (context, state) {
                            return CustomizedElevatedButton(
                              bottonWidget: state is RateUserLoading
                                  ? SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                                  : Text(
                                'إرسال',
                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  fontSize: 16.sp,
                                  color: ColorManager.white,
                                ),
                              ),
                              onPressed: state is RateUserLoading
                                  ? null
                                  : () {
                                final rate = num.tryParse(_rateController.text);
                                if (rate == null) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text(AppLocalizations.of(context)!.error),
                                      content: Text('يرجى إدخال رقم صحيح'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: Text(AppLocalizations.of(context)!.ok),
                                        ),
                                      ],
                                    ),
                                  );
                                  return;
                                }
                                // ✅ Only dispatch — do NOT close sheet here
                                context.read<RateUserCubit>().rateUser(marketer.id ?? '', rate);
                              },
                              borderColor: ColorManager.lightprimary,
                              color: ColorManager.lightprimary,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}