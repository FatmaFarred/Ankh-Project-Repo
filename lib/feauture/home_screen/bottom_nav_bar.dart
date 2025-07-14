import 'package:ankh_project/chats_screen/chats_screen.dart';
import 'package:ankh_project/core/constants/assets_manager.dart';
import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/feauture/client_favourite_screen/client_favourite_screen.dart';
import 'package:ankh_project/feauture/home_screen/home_screen.dart';
import 'package:ankh_project/feauture/marketer_products/marketer_product_screen.dart';
import 'package:ankh_project/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../profile/profile_screen.dart';

class ClientBottomNavBar extends StatefulWidget {
  const ClientBottomNavBar({super.key});
  static String bottomNavBarRouteName = "BottomNavBar";



  @override
  State<ClientBottomNavBar> createState() => _ClientBottomNavBarState();
}

class _ClientBottomNavBarState extends State<ClientBottomNavBar> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),

    ClientFavouriteScreen(),
    
    // BlocProvider(
    //   create: (_) => getIt<MarketerRequestCubit>()..fetchRequests("f4af7724-4d57-46d9-bb77-93bc1b53964c", "roleId"),
    //   child: RequestScreen(),
    // ),

    ChatsScreen(),


    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
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
            icon: Icon(Icons.favorite_border_rounded, size: 20.sp),
            label:  AppLocalizations.of(context)!.favorite,
          ),
          BottomNavigationBarItem(

            icon: Icon(Icons.wechat_sharp, size: 20.sp),
            label: AppLocalizations.of(context)!.chats,

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
