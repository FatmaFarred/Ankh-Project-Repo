import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../constants/color_manager.dart';
import '../../constants/font_manager/font_style_manager.dart';
import 'customized_elevated_button.dart';

class CustomDialog {
  BuildContext context;

  String? title, message, positiveText, negativeText;

  Function? positiveOnClick, negativeOnClick;

  CustomDialog.loading(
      {required this.context, this.message, bool cancelable = true}) {
    showDialog(
        context: context,
        barrierDismissible: cancelable,
        builder: (ctx) {
          return AlertDialog(

            backgroundColor: ColorManager.lightGrey,
            content: Row(
              children: [
                 CircularProgressIndicator(
                  color: ColorManager.black,
                ),
                if (message != null) ...[
                  SizedBox(width: 16.w),
                  Text(
                    message!,
                    style:
                        getSemiBoldStyle(color:ColorManager.black,context:context ),
                  ),
                ],
              ],
            ),
          );
        });
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
              title ?? "Success",
              style: getBoldStyle(color:ColorManager.black, context:context),
            ),
            content: Text(
              message ?? "Success",
              style: getBoldStyle(color:ColorManager.black, context:context),
            ),
            actions: [
              CustomizedElevatedButton(
                color: ColorManager.lightprimary,
                bottonWidget:Text ("ok", style: getSemiBoldStyle(color:ColorManager.white, context:context)),
                onPressed: () {
                  if (positiveOnClick != null) {
                    positiveOnClick!();
                  } else {
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          );
        });
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
              style: getBoldStyle(color:ColorManager.black ,context:context ),
            ),
            content: Text(
              message ?? "",
              style: getSemiBoldStyle(color:ColorManager.black, context:context ),
            ),
            actions: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: CustomizedElevatedButton(
                      color: Colors.transparent,
                      bottonWidget:Text ("no,"),
                      textStyle: getSemiBoldStyle(color:ColorManager.black ,context:context ),
                      onPressed: () {
                        if (negativeOnClick != null) {
                          negativeOnClick!();
                        } else {
                          Navigator.of(ctx).pop();
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  Expanded(
                    child: CustomizedElevatedButton(
                      color: ColorManager.lightprimary,
                      bottonWidget:Text("yes",style: getSemiBoldStyle(color:ColorManager.white ,context:context ),),
                      onPressed: () {
                        if (positiveOnClick != null) {
                          positiveOnClick!();
                        } else {
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  ),
                ],
              )
            ],
          );
        });
  }
}
