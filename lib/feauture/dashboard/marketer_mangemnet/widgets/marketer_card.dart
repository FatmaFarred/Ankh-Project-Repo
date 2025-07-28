import 'package:ankh_project/core/constants/assets_manager.dart';
import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/domain/entities/all_marketers_entity.dart';
import 'package:ankh_project/feauture/dashboard/custom_widgets/custom_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';

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
                    color: getAccountStatusColor(getAccountRequestStatusFromString(marketer.accountStatus)?? AccountStatus.Pending),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    marketer.accountStatus ?? '',
                    style: TextStyle(
                      color: getAccountTextStatusColor(getAccountRequestStatusFromString(marketer.accountStatus)?? AccountStatus.Pending),
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
            SizedBox(height: 10.h),
            Row(
              children: [
                SvgPicture.asset(
                  ImageAssets.assignedIcon,
                  height: 18.h,
                  width: 18.w,
                ),
                SizedBox(width: 6.w),
                Text(
                  "${AppLocalizations.of(context)!.assignedProducts} :",
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
                   AppLocalizations.of(context)!.accept ,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 12.sp,
                      color: ColorManager.lightprimary,
                    ),
                  ),
                ),
              ],
            )
            /*Row(
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
                      title: AppLocalizations.of(context)!.deleteUserAccount,
                      description: AppLocalizations.of(context)!.deleteUserAccountSubtitle,
                      cancelText: AppLocalizations.of(context)!.cancel,
                      confirmText: AppLocalizations.of(context)!.delete,
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
                    isActive ? AppLocalizations.of(context)!.suspend : AppLocalizations.of(context)!.unsuspend,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 12.sp,
                      color: ColorManager.lightprimary,
                    ),
                  ),
                ),
              ],
            ),*/



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
} 