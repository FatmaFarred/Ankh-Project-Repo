import 'package:ankh_project/feauture/balance_screen/transaction_card.dart';
import 'package:ankh_project/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/color_manager.dart';

class BalanceScreen extends StatelessWidget {
  const BalanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(CupertinoIcons.back), // Cupertino back icon
            color: Colors.white, // White color
            onPressed: () => Navigator.pop(context),
          ),
          title: Text("My Balance"),
          centerTitle: true,
          backgroundColor: ColorManager.balanceColor,
          titleTextStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: 20.sp,
          ),
        ),
        body: Padding(
          padding: REdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                padding: REdgeInsets.symmetric(vertical: 25,horizontal:32 ),
                decoration: BoxDecoration(
                  color: ColorManager.balanceColor,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Available Balance",
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: ColorManager.white,
                      ),
                    ),
                    SizedBox(height: 6.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "EGP",
                          style: GoogleFonts.inter(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w700,
                            color: ColorManager.white,
                          ),
                        ),
                        SizedBox(width:6.w ,),
                        Text(
                          "6500.00",
                          style: GoogleFonts.inter(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w700,
                            color: ColorManager.white,
                          ),
                        ),
                        SizedBox(width:6.w ,),
                        Icon(Icons.trending_up_rounded,color: Color(0xFFCAA650))
                      ],
                    ),
                    SizedBox(height: 24.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "Total Points",
                                style: GoogleFonts.inter(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: ColorManager.white,
                                ),
                              ),
                              SizedBox(height: 6.h,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "EGP",
                                    style: GoogleFonts.inter(
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.w700,
                                      color: ColorManager.white,
                                    ),
                                  ),
                                  SizedBox(width:6.w ,),
                                  Text(
                                    "5,440",
                                    style: GoogleFonts.inter(
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.w700,
                                      color: ColorManager.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 30.w,),
                        Container(height: 58,width: 1,decoration: BoxDecoration(
                          color: ColorManager.white,
                          borderRadius: BorderRadius.circular(16.r),
                        ),),
                        SizedBox(width: 30.w,),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "Per Point",
                                style: GoogleFonts.inter(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: ColorManager.white,
                                ),
                              ),
                              SizedBox(height: 6.h,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "EGP",
                                    style: GoogleFonts.inter(
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.w700,
                                      color: ColorManager.white,
                                    ),
                                  ),
                                  SizedBox(width:6.w ,),
                                  Text(
                                    "2,209",
                                    style: GoogleFonts.inter(
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.w700,
                                      color: ColorManager.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 33.h,),
              TabBar(
                labelColor: ColorManager.balanceColor,
                unselectedLabelColor: Colors.grey,
                indicatorColor: ColorManager.balanceColor,
                indicatorWeight: 1,
                labelStyle: GoogleFonts.inter(fontWeight:FontWeight.w500 , fontSize: 14.sp),
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: ColorManager.balanceColor, // Match your theme color
                      width: 2,
                    ),
                  ),
                ),
                tabs: [
                  Tab(text: 'All'),
                  Tab(text: 'Paid'),
                  Tab(text: 'Pending'),
                ],
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    TransactionCard(),
                    Center(child: Text("Paid Transactions")),
                    Center(child: Text("Pending Transactions")),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
