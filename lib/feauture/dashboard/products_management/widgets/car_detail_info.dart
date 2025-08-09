import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CarDetailInfo extends StatelessWidget {
  final String batteryCapacity;
  final String horsepower;
  final String odometer;
  final String year;
  final String transmission;
  final String engineType;
  final String color;
  final String category;

  const CarDetailInfo({
    super.key,
    required this.batteryCapacity,
    required this.horsepower,
    required this.odometer,
    required this.year,
    required this.transmission,
    required this.engineType,
    required this.color,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoItem("Battery Capacity", batteryCapacity),
            _buildInfoItem("Horsepower", horsepower),
            _buildInfoItem("Odometer", odometer),
            _buildInfoItem("Year", year),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoItem("Transmission", transmission),
            _buildInfoItem("Engine Type", engineType),
            _buildInfoItem("Color", color),
            _buildInfoItem("Category", category),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(fontSize: 12.sp, color: Colors.grey),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
