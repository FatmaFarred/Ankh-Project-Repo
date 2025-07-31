import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/custom_text_field.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import 'package:ankh_project/l10n/app_localizations.dart';

class RescheduleInspectionBottomSheet extends StatefulWidget {
  final num inspectionId;
  final Function(num inspectionId, String date, String time, String reason) onConfirm;

  const RescheduleInspectionBottomSheet({
    Key? key,
    required this.inspectionId,
    required this.onConfirm,
  }) : super(key: key);

  @override
  State<RescheduleInspectionBottomSheet> createState() => _RescheduleInspectionBottomSheetState();
}

class _RescheduleInspectionBottomSheetState extends State<RescheduleInspectionBottomSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      final now = DateTime.now();
      final dt = DateTime(now.year, now.month, now.day, picked.hour, picked.minute);
      final formattedTime = DateFormat('HH:mm:ss').format(dt); // or 'HH:mm'

      _timeController.text = formattedTime;
    }
  }


  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      widget.onConfirm(
        widget.inspectionId,
        _dateController.text.trim(),
        _timeController.text.trim(),
        _reasonController.text.trim(),
      );
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
        child: Container(
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
            children: [
              Row(
                children: [
                  Icon(Icons.calendar_today, color: ColorManager.lightprimary),
                  SizedBox(width: 8.w),
                  Text(
                    AppLocalizations.of(context)!.reschedule,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 18.sp),
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              /// Date Input
              GestureDetector(
                onTap: _pickDate,
                child: AbsorbPointer(
                  child: CustomTextField(
                    controller: _dateController,
                    hintText: AppLocalizations.of(context)!.date,
                    validator: (val) => val == null || val.isEmpty
                        ? AppLocalizations.of(context)!.fieldRequired
                        : null,
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              /// Time Input
              GestureDetector(
                onTap: _pickTime,
                child: AbsorbPointer(
                  child: CustomTextField(
                    controller: _timeController,
                    hintText: AppLocalizations.of(context)!.time,
                    validator: (val) => val == null || val.isEmpty
                        ? AppLocalizations.of(context)!.fieldRequired
                        : null,
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              /// Reason Input
              CustomTextField(
                controller: _reasonController,
                hintText: AppLocalizations.of(context)!.enterDescription,
                validator: (val) => val == null || val.isEmpty
                    ? AppLocalizations.of(context)!.fieldRequired
                    : null,
              ),
              SizedBox(height: 24.h),

              /// Buttons
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
                      borderColor: ColorManager.lightprimary,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: CustomizedElevatedButton(
                      bottonWidget: Text(
                        AppLocalizations.of(context)!.confirm,
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
            ],
          ),
        ),
              )
      )
      );
  }
}
