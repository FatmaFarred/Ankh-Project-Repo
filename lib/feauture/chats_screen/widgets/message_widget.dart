import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Massage extends StatelessWidget {
  const Massage({super.key, required this.text, required this.IsMe});

  final bool IsMe;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: IsMe
          ? AlignmentDirectional.centerEnd
          : AlignmentDirectional.centerStart,
      child: Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        constraints: BoxConstraints(maxWidth: 250),
        decoration: BoxDecoration(
          color: IsMe ? Color(0xfff4f4f4) : ColorManager.lightprimary,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
            topLeft: IsMe ? Radius.circular(15) : Radius.circular(0),
            topRight: IsMe ? Radius.circular(0) : Radius.circular(15),
          ),
        ),
        child: Column(
          crossAxisAlignment:IsMe?  CrossAxisAlignment.end : CrossAxisAlignment.start ,
          children: [
            Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                color: IsMe ? ColorManager.black : Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text("11:11",style: GoogleFonts.poppins(fontSize: 10 .sp,fontWeight: FontWeight.w300,color: IsMe ? Colors.grey : Color(0xffE9EAEB)),),
          ],
        ),
      ),
    );
  }
}
