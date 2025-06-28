import 'package:flutter/material.dart' ;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../core/constants/color_manager.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../core/constants/color_manager.dart';
import 'onboarding_controller/onboarding_cubit.dart';

class MySmoothPageIndicator extends StatelessWidget {
  const MySmoothPageIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnBoardingCubit>();
    return SmoothPageIndicator(
      controller: cubit.pageController,
      count: 4,
      onDotClicked: cubit.dotNavigationClick,
      effect: ExpandingDotsEffect(
        activeDotColor: Theme.of(context).primaryColor,
        dotColor:ColorManager.lightGrey ,
        dotHeight: 5.h,
        dotWidth:25.w
      ),
    );
  }
}