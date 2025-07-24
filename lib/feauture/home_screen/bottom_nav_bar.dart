import 'package:ankh_project/core/constants/assets_manager.dart';
import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/feauture/client_favourite_screen/client_favourite_screen.dart';
import 'package:ankh_project/feauture/home_screen/home_screen.dart';
import 'package:ankh_project/feauture/marketer_products/marketer_product_screen.dart';
import 'package:ankh_project/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../api_service/di/di.dart';
import '../authentication/user_controller/user_cubit.dart';
import '../balance_screen/balance_screen.dart';
import '../chats_screen/chats_screen.dart';
import '../inspector_screen/inspector_home/inspector_home_screen.dart';
import '../inspector_screen/inspection_reports/inspector_reports_screen.dart';
import '../inspector_screen/my_inspections/my_inspections_screen.dart';
import '../marketer_Reports/marketer_reports_screen.dart';
import '../marketer_home/marketer_home_screen.dart';
import '../myrequest/controller/cubit.dart';
import '../myrequest/my_request_screen.dart';


import '../profile/profile_screen.dart';

class BottomNavBar extends StatefulWidget {
   BottomNavBar({this.initialIndex = 0}) ;

  static String bottomNavBarRouteName = "BottomNavBar";
  final int initialIndex;
  

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserCubit>().state;

    late final List<Widget> pages;
    late final List<BottomNavigationBarItem> items;

    if (user?.roles?[0]=="Marketer") {
      pages = [
        MarketerHomeScreen(),
        MarketerProductScreen(),
        BalanceScreen(),
        BlocProvider(
          create: (_) => getIt<MarketerRequestCubit>()
            ..fetchRequests(user?.id??"", 'roleId'),
          child: MarketerReportsScreen(),
        ),
        ChatsScreen(),
        AccountScreen(),
      ];
      items = [
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage(ImageAssets.homeIcon), size: 20.sp),
          label: AppLocalizations.of(context)!.home,
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage(ImageAssets.carIcon), size: 20.sp),
          label: AppLocalizations.of(context)!.myProducts,
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage(ImageAssets.walletIcon), size: 20.sp),
          label: AppLocalizations.of(context)!.balance,
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage(ImageAssets.requestIcon), size: 20.sp),
          label: AppLocalizations.of(context)!.reports,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.wechat_sharp, size: 20.sp),
          label: AppLocalizations.of(context)!.chats,
        ),
      ];
    }
    else  if (user?.roles?[0]=="Inspector")  {
      pages = [
        InspectorHomeScreen(),
        MyInspectionsScreen( ),

        InspectorReportsScreen(),

        BalanceScreen(),

        AccountScreen(),
      ];
      items = [
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage(ImageAssets.homeIcon), size: 20.sp),
          label: AppLocalizations.of(context)!.home,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.remove_red_eye_outlined, size: 20.sp),
          label:  AppLocalizations.of(context)!.myInspections,
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage(ImageAssets.requestIcon), size: 20.sp),
          label:  AppLocalizations.of(context)!.reports,
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage(ImageAssets.walletIcon), size: 20.sp),
          label: AppLocalizations.of(context)!.balance,
        ),
        BottomNavigationBarItem(
          icon:ImageIcon(AssetImage(ImageAssets.profileIcon), size: 20.sp),
          label: AppLocalizations.of(context)!.account,
        ),
      ];
    }
    else  {
      pages = [
        HomeScreen(),
        ClientFavouriteScreen(),
        ChatsScreen(),
        AccountScreen(),
      ];
      items = [
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage(ImageAssets.homeIcon), size: 20.sp),
          label: AppLocalizations.of(context)!.home,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border_rounded, size: 20.sp),
          label: AppLocalizations.of(context)!.favorite,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.wechat_sharp, size: 20.sp),
          label: AppLocalizations.of(context)!.chats,
        ),
        BottomNavigationBarItem(
          icon:ImageIcon(AssetImage(ImageAssets.profileIcon), size: 20.sp),
          label: AppLocalizations.of(context)!.accoun,
        ),
      ];
    }

    // Ensure index is valid
    if (_currentIndex >= pages.length) _currentIndex = 0;

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: ColorManager.lightprimary,
        unselectedItemColor: ColorManager.darkGrey,
        selectedLabelStyle: GoogleFonts.cairo(
            fontSize: 14.sp, fontWeight: FontWeight.w700),
        unselectedLabelStyle: GoogleFonts.cairo(
            fontSize: 12.sp, fontWeight: FontWeight.w600),
        backgroundColor: Colors.white,
        elevation: 0.7,
        showUnselectedLabels: true,
        onTap: (i) => setState(() => _currentIndex = i),
        items: items,
      ),
    );
  }
}
