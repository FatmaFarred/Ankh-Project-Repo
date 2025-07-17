import 'package:ankh_project/feauture/details_screen/widgets/section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class RadioStatusGroup extends StatelessWidget {
  final List<String> statusOptions;
  final String? selectedValue;
  final ValueChanged<String?> onChanged;
  final String title;

  const RadioStatusGroup({
    super.key,
    required this.statusOptions,
    required this.selectedValue,
    required this.onChanged,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xff777777).withOpacity(0.5)),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(title: title),
          Column(
            children: statusOptions.map((status) {
              return RadioListTile<String>(
                title: Text(
                  status,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff374151),
                  ),
                ),
                value: status,
                groupValue: selectedValue,
                onChanged: onChanged,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
