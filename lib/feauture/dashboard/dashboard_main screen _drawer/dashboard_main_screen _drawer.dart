import 'package:ankh_project/core/constants/assets_manager.dart';
import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/customized_widgets/shared_preferences .dart';
import '../../../l10n/app_localizations.dart';
import '../../authentication/user_controller/user_cubit.dart';
import '../../welcome_screen/welcome_screen.dart';
import '../users_management/users_management_screen.dart';

class DashboardMainScreen  extends StatefulWidget {
  static String mainScreenRouteName = "MainScreen";
  @override
  _DashboardMainScreenState createState() => _DashboardMainScreenState();
}

class _DashboardMainScreenState extends State<DashboardMainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    Center(child: Text('🏠 Product Screen')),
    Center(child: UsersManagementScreen()),
    Center(child: Text('⚙️ Marketers Screen')),
    Center(child: Text('👁️ Inspectors Screen')),
    Center(child: Text('📊 Inspections Screen')),
    Center(child: Text('⚙️ Notification Screen')),
  ];

  void _onDrawerItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      Navigator.pop(context); // Close the drawer after selection
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.lightprimary,
        leading: Builder(
          builder: (context) => IconButton(
            icon: SvgPicture.asset(
              ImageAssets.drawerIcon,

              color: Colors.white,
            ),
            iconSize: 24.w,
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),

        ) ,

      drawer: Drawer(
        surfaceTintColor:ColorManager.lightprimary ,
        backgroundColor: ColorManager.neutralLight,


        child: Padding(

          padding:  EdgeInsets.symmetric(horizontal: 22.w,
          vertical: 42.h
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  IconButton(
                    icon:Icon(Icons.close_rounded),
                    color: ColorManager.lightprimary,
                    iconSize: 30.w,
                    onPressed: ()=> Navigator.pop(context), // Close the drawer
                  ),
                ],
              ),
                SizedBox(height: 20.h,),
              ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                selected: _selectedIndex == 0,
                selectedTileColor: ColorManager.lightprimary, // Background when selected
                onTap: () => _onDrawerItemTapped(0),
                leading: SvgPicture.asset(
                  ImageAssets.productIcon,
                  height:20.h, // Adjust height as needed,
                  width:20.w, // Adjust width as needed,

                  color: _selectedIndex == 0 ? Colors.white : Colors.black, // Icon color
                ),
                title: Text(
                  AppLocalizations.of(context)!.products,
                  style:Theme.of(context).textTheme.bodyMedium!.copyWith(color: _selectedIndex == 0 ? Colors.white : null), // Text color
                ),
              ),
              ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),

                selected: _selectedIndex == 1,
                selectedTileColor: ColorManager.lightprimary, // Background when selected
                onTap: () => _onDrawerItemTapped(1),
                leading: SvgPicture.asset(
                  height:20.h, // Adjust height as needed,
                  width:20.w, //
                  ImageAssets.usersIcon,
                  color: _selectedIndex == 1 ? Colors.white : Colors.black, // Icon color
                ),
                title: Text(
                  AppLocalizations.of(context)!.users,
                  style:Theme.of(context).textTheme.bodyMedium!.copyWith(color: _selectedIndex == 1 ? Colors.white : null), // Text color
                ),
              ),
              ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),

                selected: _selectedIndex == 2,
                selectedTileColor: ColorManager.lightprimary, // Background when selected
                onTap: () => _onDrawerItemTapped(2),
                leading: SvgPicture.asset(
                  height:20.h, // Adjust height as needed,
                  width:20.w, //
                  ImageAssets.marketerIcon2,
                  color: _selectedIndex == 2 ? Colors.white : Colors.black, // Icon color
                ),
                title: Text(
                  AppLocalizations.of(context)!.marketers,
                  style:Theme.of(context).textTheme.bodyMedium!.copyWith(color: _selectedIndex == 2 ? Colors.white : null), // Text color
                ),
              ),
              ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),

                selected: _selectedIndex == 3,
                selectedTileColor: ColorManager.lightprimary, // Background when selected
                onTap: () => _onDrawerItemTapped(3),
                leading: Icon(
                  Icons.visibility, // You can replace this with an SVG icon if needed
                  color: _selectedIndex == 3 ? Colors.white : Colors.black, // Icon color
                  size: 20.sp, // Adjust size as needed
                ),
                title: Text(
                  AppLocalizations.of(context)!.inspectors,
                  style:Theme.of(context).textTheme.bodyMedium!.copyWith(color: _selectedIndex == 3 ? Colors.white : null), // Text color
                ),
              ),
              ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),

                selected: _selectedIndex == 4,
                selectedTileColor: ColorManager.lightprimary, // Background when selected
                onTap: () => _onDrawerItemTapped(4),
                leading: SvgPicture.asset(
                  height:20.h, // Adjust height as needed,
                  width:20.w, //
                  ImageAssets.inspectionIcon,
                  color: _selectedIndex == 4 ? Colors.white : Colors.black, // Icon color
                ),
                title: Text(
                  AppLocalizations.of(context)!.inspections,
                  style:Theme.of(context).textTheme.bodyMedium!.copyWith(color: _selectedIndex == 4 ? Colors.white : null), // Text color
                ),

              ),

              ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),

                selected: _selectedIndex == 5,
                selectedTileColor: ColorManager.lightprimary, // Background when selected
                onTap: () => _onDrawerItemTapped(5),
                leading: SvgPicture.asset(
                  height:20.h, // Adjust height as needed,
                  width:20.w, //
                  ImageAssets.notifactionIcon2,
                  color: _selectedIndex == 5 ? Colors.white : Colors.black, // Icon color
                ),
                title: Text(
                  AppLocalizations.of(context)!.notifications,
                  style:Theme.of(context).textTheme.bodyMedium!.copyWith(color: _selectedIndex == 5 ? Colors.white : null), // Text color
                ),

              ),

             Spacer(),
              ListTile(
                onTap: () {
                  context.read<UserCubit>().clearUser();
                  SharedPrefsManager.removeData(key: 'user_token');
                  SharedPrefsManager.removeData(key:  'currentUser');
                  context.read<UserCubit>().clearUser();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      WelcomeScreen.welcomeScreenRouteName,
                          (route) => false

                  );


                },
                leading: Icon(Icons.logout,
                size: 30.sp, // Adjust size as needed
                  color: Colors.red, // Icon color
                ),
                title: Text(
                  AppLocalizations.of(context)!.logout,
                  style:Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.red,fontSize: 16.sp), // Text color
                ),

              ),







            ],
          ),
        ),
      ),
      body: _screens[_selectedIndex],
    );
  }
}