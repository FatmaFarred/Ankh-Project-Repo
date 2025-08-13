import 'package:ankh_project/feauture/home_screen/bottom_nav_bar.dart';
import 'package:ankh_project/feauture/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/assets_manager.dart';
import '../../core/constants/color_manager.dart';
import '../../core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import '../../l10n/app_localizations.dart';
import '../../l10n/languge_cubit.dart';
import '../authentication/signin/signin_screen.dart';
import '../choose_role/choose_role_screen.dart';
import '../onboarding/onboarding_page_widget.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  static String welcomeScreenRouteName ="WelcomeScreen";

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<LanguageCubit>().state;

    return  Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          OnBoardingPageWidget(
            imagePath: ImageAssets.appIcon,
            text: AppLocalizations.of(context)!.welcomeScreenTitle,
            subText: AppLocalizations.of(context)!.welcomeScreenSubTitle,


          ),
          Padding(
            padding:  EdgeInsets.symmetric(vertical: 20.h,horizontal: 18.w),
            child: Column(children: [
            CustomizedElevatedButton(

              bottonWidget: Text(AppLocalizations.of(context)!.continueAsVisitor,style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: ColorManager.white,fontSize: 16.sp),),
              color: Theme.of(context).primaryColor,
              borderColor: Theme.of(context).primaryColor,
              onPressed: () {
                //todo: navigate to visitor home
                Navigator.of(context).pushNamed(BottomNavBar.bottomNavBarRouteName);

              },
            ),

            SizedBox(height: 13.7.h,),
            CustomizedElevatedButton(

              bottonWidget: Text(AppLocalizations.of(context)!.createAccount,style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: ColorManager.lightprimary,fontSize: 16.sp),),
              color: Theme.of(context).scaffoldBackgroundColor,
              borderColor: Theme.of(context).primaryColor,
              onPressed: () {
                //todo: navigate to choose role
                Navigator.of(context).pushNamed(ChooseRoleScreen.chooseRoleScreenRouteName);
              },
            ),
              SizedBox(height: 13.7.h,),
              CustomizedElevatedButton(

                bottonWidget: Text(AppLocalizations.of(context)!.loginNow,style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: ColorManager.lightprimary,fontSize: 16.sp),),
                color: Theme.of(context).scaffoldBackgroundColor,
                borderColor: Theme.of(context).primaryColor,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SignInScreen(showRegietrButton: false,),

                        )

                  );
                },
              ),

            ],),
          )

        ],
      ),
    );
  }
}
