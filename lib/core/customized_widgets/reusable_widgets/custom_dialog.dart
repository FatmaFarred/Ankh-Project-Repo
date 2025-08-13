import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../../l10n/app_localizations.dart';
import '../../constants/color_manager.dart';
import '../../constants/font_manager/font_style_manager.dart';
import 'customized_elevated_button.dart';

class CustomDialog {
  BuildContext context;

  String? title, message, positiveText, negativeText;
  VoidCallback? positiveOnClick, negativeOnClick;
  
  /// Static method to show a simple dialog with a title, message, and confirm button
  static void showCustomDialog({
    required BuildContext context,
    required String title,
    required String message,
    required String confirmButtonText,
    VoidCallback? onConfirm,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: ColorManager.lightGrey,
          title: Text(
            title,
            style: getBoldStyle(color: ColorManager.black, context: context),
          ),
          content: Text(
            message,
            style: getSemiBoldStyle(color: ColorManager.black, context: context),
          ),
          actions: [
            CustomizedElevatedButton(
              color: ColorManager.lightprimary,
              bottonWidget: Text(
                confirmButtonText,
                style: getSemiBoldStyle(color: ColorManager.white, context: context),
              ),
              onPressed: () {
                // Close dialog first
                Navigator.of(ctx).pop();
                
                // Then run the callback, if any
                onConfirm?.call();
              },
            ),
          ],
        );
      },
    );
  }

  CustomDialog.loading(
      {required this.context, this.message, bool cancelable = true}) {
    showDialog(
      context: context,
      barrierDismissible: cancelable,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: ColorManager.lightGrey,
          content: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(color: ColorManager.black),
              if (message != null) ...[
                SizedBox(width: 16.w),
                Text(
                  message!,
                  style: getSemiBoldStyle(color: ColorManager.black, context: context),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  CustomDialog.positiveButton(
      {required this.context,
        this.title,
        this.message,
        this.positiveText,
        this.positiveOnClick,
        bool cancelable = true}) {
    showDialog(
      context: context,
      barrierDismissible: cancelable,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: ColorManager.lightGrey,
          title: Text(
            title ?? AppLocalizations.of(context)!.success,
            style: getBoldStyle(color: ColorManager.black, context: context),
          ),
          content: Text(
            message ?? AppLocalizations.of(context)!.success,
            style: getBoldStyle(color: ColorManager.black, context: context),
          ),
          actions: [
            CustomizedElevatedButton(
              color: ColorManager.lightprimary,
              bottonWidget: Text(
                AppLocalizations.of(context)!.ok,
                style: getSemiBoldStyle(color: ColorManager.white, context: context),
              ),
              onPressed: () {
                // ✅ Close dialog first
                Navigator.of(ctx).pop();

                // ✅ Then run the callback, if any
                positiveOnClick?.call();
              },
            ),
          ],
        );
      },
    );
  }

  CustomDialog.positiveAndNegativeButton(
      {required this.context,
        this.title,
        this.message,
        this.positiveText,
        this.negativeText,
        this.positiveOnClick,
        this.negativeOnClick,
        bool cancelable = true}) {
    showDialog(
      context: context,
      barrierDismissible: cancelable,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: ColorManager.lightGrey,
          title: Text(
            title ?? "",
            style: getBoldStyle(color: ColorManager.black, context: context),
          ),
          content: Text(
            message ?? "",
            style: getSemiBoldStyle(color: ColorManager.black, context: context),
          ),
          actions: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: CustomizedElevatedButton(
                    color: Colors.transparent,
                    bottonWidget: Text(
                      negativeText ?? AppLocalizations.of(context)!.no,
                    ),
                    textStyle: getSemiBoldStyle(color: ColorManager.black, context: context),
                    onPressed: () {
                      // Run negative callback or just close
                      Navigator.of(ctx).pop();
                      negativeOnClick?.call();
                    },
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: CustomizedElevatedButton(
                    color: ColorManager.lightprimary,
                    bottonWidget: Text(
                      positiveText ?? AppLocalizations.of(context)!.yes,
                      style: getSemiBoldStyle(color: ColorManager.white, context: context),
                    ),
                    onPressed: () {
                      // Run positive callback or just close
                      positiveOnClick?.call();
                      Navigator.of(ctx).pop(); // ✅ Close dialog
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}