import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/custom_text_field.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import 'package:ankh_project/l10n/app_localizations.dart';

class AdjustPointsBottomSheet extends StatefulWidget {
  final String userId;
  final String userName;
  final Function(String userId, num points, String reason) onAdjustPoints;

  const AdjustPointsBottomSheet({
    Key? key,
    required this.userId,
    required this.userName,
    required this.onAdjustPoints,
  }) : super(key: key);

  @override
  State<AdjustPointsBottomSheet> createState() => _AdjustPointsBottomSheetState();
}

class _AdjustPointsBottomSheetState extends State<AdjustPointsBottomSheet> {
  final TextEditingController _pointsController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _pointsController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final points = int.tryParse(_pointsController.text) ?? 0;
      final reason = _reasonController.text.trim();

      widget.onAdjustPoints(widget.userId, points, reason);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(
                  Icons.point_of_sale,
                  color: ColorManager.lightprimary,
                  size: 24.sp,
                ),
                SizedBox(width: 8.w),
                Text(
                  '${AppLocalizations.of(context)!.sendPoints} الى ${widget.userName}',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),

            // Points Input
            Text(
              AppLocalizations.of(context)!.pointsCount,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
            CustomTextField(
              controller: _pointsController,
              hintText: AppLocalizations.of(context)!.enterPointsCount,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocalizations.of(context)!.fieldRequired;
                }
                final points = int.tryParse(value);
                if (points == null) {
                  return AppLocalizations.of(context)!.fieldRequired;
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),

            // Reason Input
            Text(
              AppLocalizations.of(context)!.description,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
            CustomTextField(
              controller: _reasonController,
              hintText: AppLocalizations.of(context)!.enterDescription,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return AppLocalizations.of(context)!.fieldRequired;
                }
                return null;
              },
            ),
            SizedBox(height: 24.h),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: CustomizedElevatedButton(
                    bottonWidget: Text(
                      AppLocalizations.of(context)!.cancel,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 16.sp,
                        color: ColorManager.lightprimary,
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                    color: Colors.white,
                    borderColor:  ColorManager.lightprimary,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: CustomizedElevatedButton(
                    bottonWidget: Text(
                      AppLocalizations.of(context)!.send,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 16.sp,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: _submitForm,
                    color: ColorManager.lightprimary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}