import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import 'package:ankh_project/feauture/inspector_screen/inspection_details_screen.dart';
import 'package:ankh_project/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../home_screen/header_section.dart';

class InspectorHomeScreen extends StatefulWidget {
  const InspectorHomeScreen({super.key});

  @override
  State<InspectorHomeScreen> createState() => _InspectorHomeScreenState();
}

class _InspectorHomeScreenState extends State<InspectorHomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, _) => [
            const SliverToBoxAdapter(child: HeaderSection()),
            SliverToBoxAdapter(child: SizedBox(height: 12.h)),
          ],
          body: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 17.w, vertical: 13.h),
                child: TabBar(
                  controller: _tabController,
                  tabAlignment: TabAlignment.center,
                  dividerColor: ColorManager.transparent,
                  isScrollable: true,
                  indicator: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  labelStyle: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: ColorManager.white),
                  unselectedLabelStyle: Theme.of(context).textTheme.bodyMedium,

                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: [
                    Tab(text: AppLocalizations.of(context)!.today),
                    Tab(text: AppLocalizations.of(context)!.tomorrow),
                    Tab(text: AppLocalizations.of(context)!.completed),
                    Tab(text: AppLocalizations.of(context)!.postponed),
                    Tab(text: AppLocalizations.of(context)!.returned),
                    Tab(text: AppLocalizations.of(context)!.notResponded),
                  ],
                  onTap: (_) => setState(() {}),
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Padding(
                      padding: REdgeInsets.symmetric(horizontal: 16),
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 12.h);
                        },
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {},
                            child: Container(
                              padding: REdgeInsets.all(16),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xFF777777).withOpacity(0.5),
                                ),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "John Doe",
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyLarge,
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 4,
                                          horizontal: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            16.r,
                                          ),
                                          color: Color(0xFFFEF9C3),
                                        ),
                                        child: Text(
                                          AppLocalizations.of(context)!.pending,
                                          style: GoogleFonts.inter(
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF166534),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "Toyota Corolla 2023",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w300,
                                      color: Color(0xFF4f4f4f),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.access_time_rounded,
                                        size: 14,
                                        color: ColorManager.lightprimary,
                                      ),
                                      SizedBox(width: 6.w,),
                                      Text(
                                        "July 7, 2025 – 3:00 PM",
                                        style: GoogleFonts.poppins(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w300,
                                          color: Color(0xFF4f4f4f),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_rounded,
                                        size: 14,
                                        color: ColorManager.lightprimary,
                                      ),
                                      SizedBox(width: 6.w,),
                                      Text(
                                        "15 El-Tahrir St., Cairo",
                                        style: GoogleFonts.poppins(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w300,
                                          color: Color(0xFF4f4f4f),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 26.h,),
                                  CustomizedElevatedButton(
                                    bottonWidget: Text(
                                      AppLocalizations.of(context)!.startInspect,
                                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                        color: ColorManager.white,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                    color: Theme.of(context).primaryColor,
                                    borderColor: Theme.of(context).primaryColor,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const InspectionDetailsScreen(),
                                        ),
                                      );
                                    },
                                  ),

                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: 12,
                      ),
                    ),
                    Center(child: Text("Tomorrow's Inspections")),
                    Center(child: Text("Completed Inspections")),
                    Center(child: Text("Postponed Inspections")),
                    Center(child: Text("Postponed Inspections")),
                    Center(child: Text("Postponed Inspections")),
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
