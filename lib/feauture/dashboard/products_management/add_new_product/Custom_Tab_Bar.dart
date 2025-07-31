import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTabBar extends StatefulWidget {
  final List<String> tabs;
  final Function(int index) onTabChanged;

  const CustomTabBar({
    Key? key,
    required this.tabs,
    required this.onTabChanged,
  }) : super(key: key);

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.h,
      decoration: BoxDecoration(
        color: Colors.green[200],
        borderRadius: BorderRadius.circular(16.r),
      ),
      padding: EdgeInsets.all(4.w),
      child: Row(
        children: List.generate(widget.tabs.length, (index) {
          final isSelected = selectedIndex == index;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
                widget.onTabChanged(index); // Call back to parent
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(

                  widget.tabs[index],
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
