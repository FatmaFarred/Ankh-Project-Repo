
import 'package:ankh_project/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../core/constants/assets_manager.dart';
import '../../core/constants/color_manager.dart';
import '../../core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import '../../core/device/device_utility.dart';
import '../../l10n/languge_cubit.dart';
import '../welcome_screen/welcome_screen.dart';
import 'onboarding_controller/onboarding_cubit.dart';
import 'smooth_page_indicator.dart';
import 'onboarding_page_widget.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';


class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});
  static String onBoardingRouteName ="OnBoarding";


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnBoardingCubit(),
      child: const _OnBoardingView(),
    );
  }
}

class _OnBoardingView extends StatelessWidget {
  const _OnBoardingView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<OnBoardingCubit>();
    final locale = context.watch<LanguageCubit>().state;



    return Scaffold(
      body: Column(children: [
        SizedBox(
          height:700.h ,
          child: BlocBuilder<OnBoardingCubit, int>(
            builder: (context, state) {
              return PageView(
                controller: cubit.pageController,
                onPageChanged: cubit.updatePageIndicator,
                children: [
                  OnBoardingPageWidget(
                    text: AppLocalizations.of(context)!.onBoarding1Title,
                    subText:AppLocalizations.of(context)!.onBoarding1SubTitle,
                    imagePath: ImageAssets.OnBoardingImage1,
                  ),
                  OnBoardingPageWidget(
                    text: AppLocalizations.of(context)!.onBoarding2Title,
                    subText:AppLocalizations.of(context)!.onBoarding2SubTitle,
                    imagePath: ImageAssets.OnBoardingImage2,
                  ),
                  OnBoardingPageWidget(
                    text: AppLocalizations.of(context)!.onBoarding3Title,
                    subText:AppLocalizations.of(context)!.onBoarding3SubTitle,
                    imagePath: ImageAssets.OnBoardingImage3,
                  ),
                  OnBoardingPageWidget(
                    text: AppLocalizations.of(context)!.onBoarding4Title,
                    subText:AppLocalizations.of(context)!.onBoarding4SubTitle,
                    imagePath: ImageAssets.OnBoardingImage4,
                  ),
                ],
              );
            },
          ),
        ),

           MySmoothPageIndicator(),

           Padding(
             padding:  EdgeInsets.symmetric(horizontal: 18.w,vertical: 40.h),
             child: Column(children: [
               CustomizedElevatedButton(

                bottonWidget: Text(AppLocalizations.of(context)!.getStarted,style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: ColorManager.white,fontSize: 16.sp),),
                color: Theme.of(context).primaryColor,
                borderColor: Theme.of(context).primaryColor,
                onPressed: () {
                  cubit.skipPage();
                  Navigator.pushNamedAndRemoveUntil(context,       WelcomeScreen.welcomeScreenRouteName,
                  (route) => false,);
                },
              ),
               SizedBox(height: 13.7.h,),

               CustomizedElevatedButton(

                       bottonWidget: Text(AppLocalizations.of(context)!.next,style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: ColorManager.lightprimary,fontSize: 16.sp),),
                       color: Theme.of(context).scaffoldBackgroundColor,
                       borderColor: Theme.of(context).primaryColor,
                       onPressed: () {
              cubit.nextPage();
                       },
                     ),
             ],),
           )
      ]),
    );
  }
}