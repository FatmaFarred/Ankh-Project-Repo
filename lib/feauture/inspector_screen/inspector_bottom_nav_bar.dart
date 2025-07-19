import 'package:ankh_project/core/constants/assets_manager.dart';
import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/feauture/balance_screen/balance_screen.dart';
import 'package:ankh_project/feauture/inspector_screen/inspector_home/inspector_home_screen.dart';
import 'package:ankh_project/feauture/inspector_screen/inspector_reports_screen.dart';
import 'package:ankh_project/feauture/inspector_screen/my_inspections_screen.dart';
import 'package:ankh_project/feauture/profile/profile_screen.dart';
import 'package:ankh_project/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/entities/all_products_entity.dart';

class InspectorBottomNavBar extends StatefulWidget {
  const InspectorBottomNavBar({super.key,});

  static String inspectorBottomNavBarRouteName = "InspectorBottomNavBar";


  @override
  State<InspectorBottomNavBar> createState() => _InspectorBottomNavBarState();
}

class _InspectorBottomNavBarState extends State<InspectorBottomNavBar> {

  int _currentIndex = 0;

  final List<Widget> _pages = [
    InspectorHomeScreen(),
    MyInspectionsScreen( ),

    InspectorReportsScreen(),

    BalanceScreen(),

    AccountScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: ColorManager.lightprimary,
        selectedLabelStyle: GoogleFonts.cairo(
          fontSize: 14.sp,
          fontWeight: FontWeight.w700,
          color: ColorManager.lightprimary,
        ),
        unselectedItemColor: ColorManager.darkGrey,
        unselectedLabelStyle: GoogleFonts.cairo(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: ColorManager.darkGrey,
        ),
        backgroundColor: Colors.white,
        elevation: 0.7,
        showUnselectedLabels: true,
        onTap: (index) => setState(() => _currentIndex = index),
        items:  [
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(ImageAssets.homeIcon), size: 20.sp),
            label:  AppLocalizations.of(context)!.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.remove_red_eye_outlined, size: 20.sp),
            label:  AppLocalizations.of(context)!.home,
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(ImageAssets.requestIcon), size: 20.sp),
            label:  AppLocalizations.of(context)!.requests,
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(ImageAssets.walletIcon), size: 20.sp),
            label: AppLocalizations.of(context)!.balance,
          ),
          BottomNavigationBarItem(
            icon:ImageIcon(AssetImage(ImageAssets.profileIcon), size: 20.sp),
            label: AppLocalizations.of(context)!.account,

          ),
        ],
      ),
    );
  }
}
