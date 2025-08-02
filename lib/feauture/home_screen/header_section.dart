import 'package:ankh_project/api_service/di/di.dart';
import 'package:ankh_project/core/constants/assets_manager.dart';
import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/custom_search_bar.dart';
import 'package:ankh_project/core/customized_widgets/profile_image_widget.dart';
import 'package:ankh_project/core/customized_widgets/shared_preferences .dart';
import 'package:ankh_project/domain/entities/product_entity.dart';
import 'package:ankh_project/feauture/client_notification_screen/client_notification_screen.dart';
import 'package:ankh_project/feauture/profile/profile_screen.dart';
import 'package:ankh_project/feauture/home_screen/bottom_nav_bar.dart';

import 'package:ankh_project/feauture/client_search_screen/client_search_screen.dart';
import 'package:ankh_project/feauture/client_search_screen/client_search_screen_wrapper.dart';
import 'package:ankh_project/feauture/client_search_screen/cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../api_service/api_constants.dart';
import '../../core/customized_widgets/reusable_widgets/customized_search_bar.dart';
import '../../l10n/app_localizations.dart';
import '../authentication/user_controller/user_cubit.dart';
import '../profile/cubit/profile_cubit.dart';
import '../profile/cubit/states.dart';

typedef OnSearchCallback = void Function(String keyword);

class HeaderSection extends StatefulWidget {
  final OnSearchCallback? onSearch;
  const HeaderSection({super.key, this.onSearch});

  @override
  State<HeaderSection> createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Start loading profile data immediately
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshProfileData();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      // Refresh profile data when app becomes active again
      _refreshProfileData();
    }
  }

  Future<void> _refreshProfileData() async {
    // Force refresh profile data from API
    final token = await SharedPrefsManager.getData(key: 'user_token');
    final userId = await SharedPrefsManager.getData(key: 'user_id');
    
    if (token != null && userId != null) {
      await context.read<ProfileCubit>().fetchProfile(token, userId);
    }
  }

  /// Handle profile update result
  Future<void> _handleProfileUpdate() async {
    await _refreshProfileData();
    // Show a brief success message
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Profile updated successfully'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
      final user = context.watch<UserCubit>().state;
      
      return BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          // Handle state changes here if needed
          if (state is ProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to load profile data'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
                builder: (context, state) {
          String userName = AppLocalizations.of(context)!.visitor;
          print("currentUserRole:${user?.roles?[0]}");
          String? profileImageUrl;
          num? rate;

          // Check if user role is null - show visitor and app logo
          if (user?.roles == null || user?.roles?.isEmpty == true) {
            return Container(
              padding: REdgeInsets.all(22),
              width: double.infinity,
              decoration: BoxDecoration(color: ColorManager.lightprimary),
              child: SafeArea(
                child: Column(
                  children: [
                    Row(
                      children: [
                        // Show app logo for visitor
                        Container(
                          width: 50.w,
                          height: 50.w,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(25.r),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25.r),
                            child: Image.asset(
                              ImageAssets.appLogo, // Using app logo
                              width: 50.w,
                              height: 50.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.visitor,
                              style: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        SizedBox(width: 12.w),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return ClientNotificationScreen();
                                },
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
                    Container(
                      padding: REdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 14.w,),
                          Icon(Icons.search, color: ColorManager.hintColor),
                          SizedBox(width: 14.w,),
                          Text(
                            AppLocalizations.of(context)!.whatAreYouLookingFor,
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: ColorManager.hintColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is ProfileLoading) {
            // Show loading state for authenticated users
            return Container(
              padding: REdgeInsets.all(22),
              width: double.infinity,
              decoration: BoxDecoration(color: ColorManager.lightprimary),
              child: SafeArea(
                child: Column(
                  children: [
                    Row(
                      children: [
                        // Loading indicator for profile image
                        Container(
                          width: 50.w,
                          height: 50.w,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(25.r),
                          ),
                          child: Center(
                            child: SizedBox(
                              width: 20.w,
                              height: 20.w,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Loading skeleton for user name
                            Container(
                              width: 120.w,
                              height: 14.h,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                            ),
                            SizedBox(height: 4.h),
                            // Loading skeleton for additional info
                            Container(
                              width: 80.w,
                              height: 12.h,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        SizedBox(width: 12.w),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return ClientNotificationScreen();
                                },
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
                    Container(
                      padding: REdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 14.w,),
                          Icon(Icons.search, color: ColorManager.hintColor),
                          SizedBox(width: 14.w,),
                          Text(
                            AppLocalizations.of(context)!.whatAreYouLookingFor,
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: ColorManager.hintColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is ProfileLoaded) {
            // User has role and profile data is loaded
            userName = state.profile.fullName ?? AppLocalizations.of(context)!.visitor;
            profileImageUrl = state.profile.imageUrl;
            rate = state.profile.rating ?? 0;
          } else if (state is ProfileError) {
            // Show default state for error - but user has role
            userName = AppLocalizations.of(context)!.visitor;
            profileImageUrl = null;
            rate = 0;
          } else if (state is ProfileInitial) {
            // Initial state - user has role but no profile data yet
            userName = AppLocalizations.of(context)!.visitor;
            profileImageUrl = null;
            rate = 0;
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
                  child: ProfileImageWidget(
                    imageUrl: profileImageUrl,
                    size: 50,
                    showLoadingState: true,
                  ),
                ),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(userName??"",
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        )),
                    // RatingBarIndicator(
                    //   rating: 5,
                    //   itemBuilder: (context, _) => const Icon(
                    //     Icons.star,
                    //     color: ColorManager.starRateColor,
                    //   ),
                    //   itemCount: 5,
                    //   itemSize: 12.sp,
                    //   direction: Axis.horizontal,
                    // ),
                  ],
                ),
                const Spacer(),
                // Image.asset(ImageAssets.goldMedal, scale: 6.sp),
                SizedBox(width: 12.w),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ClientNotificationScreen();
                        },
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

            InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ClientSearchScreenWrapper(),
                  ),
                );              },
              child: Container(
                padding: REdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 14.w,),
                    Icon(Icons.search, color: ColorManager.hintColor),
                    SizedBox(width: 14.w,),
                    Text(
                      AppLocalizations.of(context)!.whatAreYouLookingFor,
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: ColorManager.hintColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
        },
      );
  }
}
