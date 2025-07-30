import 'package:ankh_project/api_service/api_constants.dart';
import 'package:ankh_project/core/constants/assets_manager.dart';
import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/custom_search_bar.dart';
import 'package:ankh_project/feauture/client_notification_screen/client_notification_screen.dart';
import 'package:ankh_project/feauture/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/customized_widgets/reusable_widgets/customized_search_bar.dart';
import '../../l10n/app_localizations.dart';
import '../authentication/user_controller/user_cubit.dart';
import '../profile/cubit/profile_cubit.dart';
import '../profile/cubit/states.dart';

typedef OnSearchCallback = void Function(String keyword);

class HomeAppBar extends StatelessWidget {
  final OnSearchCallback? onSearch;
  final bool showSearchBar;

  const HomeAppBar({super.key, this.onSearch, this.showSearchBar = true});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserCubit>().state;
    final profileCubit = context.read<ProfileCubit>();
    final state = profileCubit.state;

    String userName = AppLocalizations.of(context)!.visitor;
    String? profileImageUrl;
    num? rate;


    if (state is ProfileLoaded) {
      userName = state.profile.fullName ?? AppLocalizations.of(context)!.visitor;
      profileImageUrl = state.profile.imageUrl; // ma// ke sure this is a URL string
      rate = state.profile.rating ?? 0; // Assuming rate is a num, adjust as necessary

    }

    return Container(
      padding: REdgeInsets.all(22),
      width: double.infinity,
      decoration: BoxDecoration(color: ColorManager.lightprimary),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    if (user?.roles?[0] == "Marketer") {
                      Navigator.of(context).pushNamed(AccountScreen.accountScreenRouteName);
                    }
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.r),
                    child: profileImageUrl != null
                        ? Image.network(
                      "${ApiConstant.imageBaseUrl}$profileImageUrl",
                      height: 50.w,
                      width: 50.w,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          ImageAssets.profilePic,
                          height: 50.w,
                          width: 50.w,
                          fit: BoxFit.cover,
                        );
                      },
                    )
                        : Image.asset(
                      ImageAssets.profilePic,
                      height: 50.w,
                      width: 50.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                    RatingBarIndicator(
                      rating: rate?.toDouble()?? 0.0,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: ColorManager.starRateColor,
                      ),
                      itemCount: 5,
                      itemSize: 12.sp,
                      direction: Axis.horizontal,
                    ),
                  ],
                ),
                const Spacer(),
                Image.asset(ImageAssets.goldMedal, scale: 6.sp),
                SizedBox(width: 12.w),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ClientNotificationScreen(),
                      ),
                    );
                  },
                  child: ClipRRect(
                    child: Image.asset(ImageAssets.notification, scale: 1.3),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            showSearchBar ? CustomizedSearchBar(onSearch: onSearch) : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
