import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/feauture/client_favourite_screen/favourite_product_card.dart';
import 'package:ankh_project/feauture/home_screen/bottom_nav_bar.dart';
import 'package:ankh_project/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ClientFavouriteScreen extends StatelessWidget {
  const ClientFavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(CupertinoIcons.back),
            color: Colors.white,
            onPressed: () {
              Navigator.pushReplacementNamed(context, BottomNavBar.bottomNavBarRouteName);
            },
          ),
          title: Text(AppLocalizations.of(context)!.myFavorites),
          centerTitle: true,
          backgroundColor: ColorManager.lightprimary,
        ),
        body: Padding(
          padding: REdgeInsets.all(20.0),
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: 2,
            separatorBuilder: (context, index) => SizedBox(height: 10.h),
            itemBuilder: (context, index) {
              return FavouriteProductCard();
            },
          ),
        ),
    );
  }
}
