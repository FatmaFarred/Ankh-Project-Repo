import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/core/customized_widgets/profile_image_widget.dart';
import 'package:ankh_project/feauture/authentication/signin/signin_screen.dart';
import 'package:ankh_project/feauture/home_screen/bottom_nav_bar.dart';
import 'package:ankh_project/feauture/profile/widegts/setting_tile.dart';
import 'package:ankh_project/feauture/welcome_screen/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter/material.dart';

import '../../api_service/api_constants.dart';
import '../../core/constants/assets_manager.dart';
import '../../core/customized_widgets/reusable_widgets/custom_dialog.dart';
import '../../core/customized_widgets/shared_preferences .dart';
import '../../l10n/app_localizations.dart';
import '../authentication/user_controller/user_cubit.dart';
import '../client_favourite_screen/client_favourite_screen.dart';
import '../invite_team_member/invite_team_member_screen.dart';
import '../teams_and_codes/teams_and_codes_screen.dart';
import '../marketer_price_offers/marketer_price_offers.dart';
import '../marketer_installment_offers/marketer_installment_offers.dart';
import '../marketer_installment_offers/cubit/installment_offers_by_marketer_id_cubit.dart';
import '../marketer_price_offers/cubit/price_offers_by_marketer_id_cubit.dart';
import '../../api_service/di/di.dart';
import 'cubit/profile_cubit.dart';
import 'cubit/states.dart';
import 'edit_profile_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  static String accountScreenRouteName = "AccountScreen";

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen>
    with WidgetsBindingObserver, RouteAware {
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Refresh profile data when returning to this screen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshProfileData();
    });
  }

  @override
  void didPopNext() {
    super.didPopNext();
    // Refresh profile data when returning to this screen from another screen
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
    } else {
      // If no token or user ID, emit initial state to show visitor
      context.read<ProfileCubit>().emit(ProfileInitial());
    }
  }

  /// Force refresh profile data and ensure UI updates
  Future<void> _forceRefreshProfile() async {
    await _refreshProfileData();
    // Force a rebuild of the widget
    if (mounted) {
      setState(() {});
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
        if (state is ProfileError) {}
      },
      builder: (context, state) {
        String userName = AppLocalizations.of(context)!.visitor;
        String? profileImageUrl;
        num? rate;
        num? completedTasks;

        // Check if user has no role - show visitor and app logo but keep all settings
        if (user?.roles == null || user?.roles?.isEmpty == true) {
          // Show visitor state with app logo but keep all profile content
          userName = AppLocalizations.of(context)!.visitor;
          profileImageUrl = null;
          rate = 0;
          completedTasks = 0;
        }

        if (state is ProfileLoading) {
          // Show loading state with skeleton UI
          return Scaffold(
            appBar: AppBar(
              title: Text(AppLocalizations.of(context)!.personalAccount),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                color: Colors.white,
                onPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    BottomNavBar.bottomNavBarRouteName,
                  );
                },
              ),
            ),
            backgroundColor: ColorManager.containerGrey,
            body: RefreshIndicator(
              onRefresh: _refreshProfileData,
              color: ColorManager.lightprimary,
              child: SafeArea(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 300.h,
                              width: double.infinity,
                              color: ColorManager.lightprimary,
                            ),
                            Container(
                              height: 90.h,
                              decoration: BoxDecoration(
                                color: ColorManager.containerGrey,
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          top: 70.h,
                          right: 20.w,
                          child: SizedBox(
                            height: 319.h,
                            width: 388.w,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              color: ColorManager.white,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 40,
                                      backgroundColor: Colors.grey.shade300,
                                      child: Stack(
                                        children: [
                                          Center(
                                            child: SizedBox(
                                              width: 30.w,
                                              height: 30.w,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 3,
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                      Color
                                                    >(Colors.grey.shade600),
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Icon(
                                              Icons.person,
                                              size: 30,
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      width: 120.w,
                                      height: 16.h,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius: BorderRadius.circular(
                                          8.r,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      width: 80.w,
                                      height: 12.h,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius: BorderRadius.circular(
                                          6.r,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      width: 100.w,
                                      height: 32.h,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius: BorderRadius.circular(
                                          16.r,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.only(
                          top: 20.h,
                          left: 20.w,
                          right: 20.w,
                        ),
                        children: List.generate(
                          4,
                          (index) => Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 120.w,
                                  height: 16.h,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(4.r),
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Container(
                                  width: double.infinity,
                                  height: 60.h,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                    ),
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        if (state is ProfileLoaded) {
          userName =
              state.profile.fullName ?? AppLocalizations.of(context)!.visitor;
          profileImageUrl = state.profile.imageUrl;
          rate = state.profile.rating ?? 0;
          completedTasks = state.profile.completedTasks ?? 0;
        } else if (state is ProfileInitial) {
          // Show visitor state when no token or user ID
          userName = AppLocalizations.of(context)!.visitor;
          profileImageUrl = null;
          rate = 0;
          completedTasks = 0;
        } else if (state is ProfileError) {
          // Show error state with retry option
          return Scaffold(
            appBar: AppBar(
              title: Text(AppLocalizations.of(context)!.personalAccount),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                color: Colors.white,
                onPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    BottomNavBar.bottomNavBarRouteName,
                  );
                },
              ),
            ),
            backgroundColor: ColorManager.containerGrey,
            body: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 64, color: Colors.grey),
                    SizedBox(height: 16.h),
                    Text(
                      state.error.errorMessage ??
                          AppLocalizations.of(context)!.failedToLoadData,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 24.h),
                    ElevatedButton(
                      onPressed: () => Navigator.pushNamed(
                        context,
                        WelcomeScreen.welcomeScreenRouteName,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.lightprimary,
                        foregroundColor: Colors.white,
                      ),
                      child: Text(AppLocalizations.of(context)!.loginNow),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.personalAccount),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              color: Colors.white,
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  BottomNavBar.bottomNavBarRouteName,
                );
              },
            ),
          ),
          backgroundColor: ColorManager.containerGrey,
          body: RefreshIndicator(
            onRefresh: _refreshProfileData,
            color: ColorManager.lightprimary,
            child: SafeArea(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 300.h,
                            width: double.infinity,
                            color: ColorManager.lightprimary,
                          ),
                          Container(
                            height: 90.h,
                            decoration: BoxDecoration(
                              color: ColorManager.containerGrey,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: 70.h,
                        right: 20.w,
                        child: SizedBox(
                          height: 319.h,
                          width: 388.w,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            color: ColorManager.white, // Dark greenish
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    ProfileImageWidget(
                                      imageUrl: profileImageUrl,
                                      size: 80,
                                      showLoadingState: true,
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          userName ?? "Guest",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(fontSize: 16.sp),
                                        ),
                                        Image.asset(
                                          ImageAssets.goldMedal,
                                          scale: 6.sp,
                                          height: 24.h,
                                          width: 18.w,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    RatingBarIndicator(
                                      rating: rate?.toDouble() ?? 0.0,
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: ColorManager.starRateColor,
                                      ),
                                      itemCount: 5,
                                      itemSize: 14.sp,
                                      direction: Axis.horizontal,
                                    ),
                                    const SizedBox(height: 8),
                                    TextButton(
                                      onPressed: () async {
                                        // Check if user is authenticated before allowing edit
                                        if (user?.roles != null &&
                                            user?.roles?.isNotEmpty == true) {
                                          final result =
                                              await Navigator.pushNamed(
                                                context,
                                                EditProfileScreen.routeName,
                                              );
                                          // If profile was updated, refresh the data
                                          if (result == true) {
                                            _handleProfileUpdate();
                                          }
                                        } else {
                                          // Show message for visitors
                                          CustomDialog.positiveAndNegativeButton(
                                            context: context,
                                            positiveText: AppLocalizations.of(
                                              context,
                                            )!.loginNow,
                                            positiveOnClick: () {
                                              Navigator.of(context).pushNamed(
                                                WelcomeScreen
                                                    .welcomeScreenRouteName,
                                              );
                                            },
                                            title: AppLocalizations.of(
                                              context,
                                            )!.login,
                                            message: AppLocalizations.of(
                                              context,
                                            )!.signInforMore,
                                          );
                                        }
                                      },
                                      child: Text(
                                        user?.roles != null &&
                                                user?.roles?.isNotEmpty == true
                                            ? AppLocalizations.of(
                                                context,
                                              )!.editProfile
                                            : AppLocalizations.of(
                                                context,
                                              )!.loginNow,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              fontSize: 14.sp,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                      ),
                                    ),
                                    user?.roles?[0] == "Marketer" ||
                                            user?.roles?[0] == "Inspector" ||
                                            user?.roles?[0] == "LeaderMarketer"
                                        ? Column(
                                            children: [
                                              Divider(
                                                color: ColorManager.darkGrey,
                                                thickness: 1,
                                              ),
                                              const SizedBox(height: 12),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  ProfileStat(
                                                    label: AppLocalizations.of(
                                                      context,
                                                    )!.completed,
                                                    value: "$completedTasks",
                                                  ),
                                                  SizedBox(
                                                    height: 40.h,
                                                    child: VerticalDivider(
                                                      color:
                                                          ColorManager.darkGrey,
                                                      thickness: 1,
                                                    ),
                                                  ),
                                                  ProfileStat(
                                                    label: AppLocalizations.of(
                                                      context,
                                                    )!.rating,
                                                    value: "$rate/5.0",
                                                  ),
                                                  SizedBox(
                                                    height: 40.h,
                                                    child: VerticalDivider(
                                                      color:
                                                          ColorManager.darkGrey,
                                                      thickness: 1,
                                                    ),
                                                  ),
                                                  ProfileStat(
                                                    label: AppLocalizations.of(
                                                      context,
                                                    )!.response,
                                                    value: "98%",
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )
                                        : const SizedBox.shrink(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // 🔒 Fixed Top Section

                  // 📜 Scrollable Section
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.only(
                        top: 20.h,
                        left: 20.w,
                        right: 20.w,
                      ),
                      children: [
                        user?.roles?[0] == "LeaderMarketer"
                            ? _tableSection(
                                title: AppLocalizations.of(
                                  context,
                                )!.teamManagement,
                                rows: [
                                  SettingsTile(
                                    title: AppLocalizations.of(
                                      context,
                                    )!.inviteTeamMember,
                                    iconWidget: SvgPicture.asset(
                                      ImageAssets.chatTeam,
                                      height: 22.h,
                                      width: 22.w,
                                      color: ColorManager.darkestGrey,
                                    ),
                                    onTap: () => Navigator.pushNamed(
                                      context,
                                      InviteTeamMemberScreen
                                          .inviteTeamMemberRouteName,
                                    ),
                                  ),
                                  SettingsTile(
                                    title: AppLocalizations.of(
                                      context,
                                    )!.teamMembers,
                                    iconWidget: SvgPicture.asset(
                                      ImageAssets.usersIcon,
                                      height: 22.h,
                                      width: 22.w,
                                      color: ColorManager.darkestGrey,
                                    ),
                                    onTap: () => Navigator.pushNamed(
                                      context,
                                      TeamsAndCodesScreen
                                          .teamsAndCodesRouteName,
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),
                        user?.roles?[0] == "LeaderMarketer" ||
                                user?.roles?[0] == "Marketer"
                            ? _tableSection(
                                title: AppLocalizations.of(
                                  context,
                                )!.offersManagement,
                                rows: [
                                  SettingsTile(
                                    title: AppLocalizations.of(
                                      context,
                                    )!.priceOffers,
                                    icon: Iconsax.dollar_circle,
                                    onTap: () {
                                      print("Creating PriceOffersByMarketerIdCubit...");
                                      try {
                                        final cubit = getIt<PriceOffersByMarketerIdCubit>();
                                        print("Cubit created successfully: $cubit");
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => BlocProvider.value(
                                              value: cubit,
                                              child: const MarketerPriceOffers(),
                                            ),
                                          ),
                                        );
                                      } catch (e) {
                                        print("Error creating cubit: $e");
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text("Error creating cubit: $e"),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                  SettingsTile(
                                    title: AppLocalizations.of(
                                      context,
                                    )!.installmentOffers,
                                    icon: Iconsax.calendar,
                                    onTap: () {
                                      print("Creating InstallmentOffersByMarketerIdCubit...");
                                      try {
                                        final cubit = getIt<InstallmentOffersByMarketerIdCubit>();
                                        print("Cubit created successfully: $cubit");
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => BlocProvider.value(
                                              value: cubit,
                                              child: const MarketerInstallmentOffers(),
                                            ),
                                          ),
                                        );
                                      } catch (e) {
                                        print("Error creating cubit: $e");
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text("Error creating cubit: $e"),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),
                        /*_tableSection(
                          title: AppLocalizations.of(context)!.manageAccount,
                          rows: [
                            // SettingsTile(title:  AppLocalizations.of(context)!.personalDetails, icon: Iconsax.user),
                            SettingsTile(
                              title: AppLocalizations.of(
                                context,
                              )!.securitySettings,
                              icon: Iconsax.lock,
                            ),
                            SettingsTile(
                              title: AppLocalizations.of(
                                context,
                              )!.notifications,
                              icon: Iconsax.notification,
                            ),
                          ],
                        ),*/
                        _tableSection(
                          title: AppLocalizations.of(context,)!.paymentAndWallets,
                          rows: [
                            SettingsTile(
                              title: AppLocalizations.of(
                                context,
                              )!.walletAndCommissions,
                              icon: Iconsax.empty_wallet,
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${AppLocalizations.of(context)!.notAvailableNow}'),
                                    duration: Duration(seconds: 3),
                                    backgroundColor: ColorManager.error,
                                    behavior: SnackBarBehavior.floating,
                                    margin: EdgeInsets.symmetric(vertical: 100.h, horizontal: 16.w),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                  ),
                                );
                              },
                            ),
                            SettingsTile(
                              title: AppLocalizations.of(
                                context,
                              )!.paymentMethods,
                              icon: Iconsax.card,
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${AppLocalizations.of(context)!.notAvailableNow}'),
                                    duration: Duration(seconds: 3),
                                    backgroundColor: ColorManager.error,
                                    behavior: SnackBarBehavior.floating,
                                    margin: EdgeInsets.symmetric(vertical: 100.h, horizontal: 16.w),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        _tableSection(
                          title: AppLocalizations.of(context)!.preferences,
                          rows: [
                            // SettingsTile(title:AppLocalizations.of(context)!.devicePreferences, icon: Icons.phone_android_rounded),
                           // DarkModeSwitchTile(),
                            SettingsTile(
                              title: AppLocalizations.of(context)!.language,
                              icon: Icons.language,
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${AppLocalizations.of(context)!.notAvailableNow}'),
                                    duration: Duration(seconds: 3),
                                    backgroundColor: ColorManager.error,
                                    behavior: SnackBarBehavior.floating,
                                    margin: EdgeInsets.symmetric(vertical: 100.h, horizontal: 16.w),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                  ),
                                );
                              },

                            ),
                            SettingsTile(
                              title: AppLocalizations.of(
                                context,
                              )!.favoriteProducts,
                              icon: Iconsax.heart,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ClientFavouriteScreen(),
                                  ),
                                );
                              },
                            ),

                          ],

                        ),
                        _tableSection(
                          title: AppLocalizations.of(context)!.helpAndSupport,
                          rows: [
                            SettingsTile(
                              title: AppLocalizations.of(
                                context,
                              )!.contactSupport,
                              icon: Iconsax.call,
                            ),
                          ],
                        ),
                        _tableSection(
                          title: "",
                          rows: [
                            SettingsTile(
                              title: AppLocalizations.of(context)!.logout,
                              icon: Iconsax.logout,
                              onTap: () {
                                context.read<UserCubit>().clearUser();
                                SharedPrefsManager.removeData(
                                  key: 'user_token',
                                );
                                SharedPrefsManager.removeData(
                                  key: 'currentUser',
                                );
                                SharedPrefsManager.removeData(key: 'user_id');
                                context.read<UserCubit>().clearUser();
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                  WelcomeScreen.welcomeScreenRouteName,
                                  (route) => false,
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// Widget: Profile Statistic
class ProfileStat extends StatelessWidget {
  final String label;
  final String value;

  const ProfileStat({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontSize: 12.sp,
            color: ColorManager.darkGrey,
          ),
        ),
        Text(
          value,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(fontSize: 14.sp),
        ),
      ],
    );
  }
}

// Widget: Section Header

// Widget: Setting Tile

Widget _tableSection({required String title, required List<Widget> rows}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: ColorManager.white,

            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: List.generate(rows.length * 2 - 1, (index) {
              if (index.isEven) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: rows[index ~/ 2],
                );
              } else {
                return Divider(height: 1, color: Colors.grey.shade300);
              }
            }),
          ),
        ),
      ],
    ),
  );
}

// Widget: Dark Mode Switch
class DarkModeSwitchTile extends StatefulWidget {
  const DarkModeSwitchTile({super.key});

  @override
  State<DarkModeSwitchTile> createState() => _DarkModeSwitchTileState();
}

class _DarkModeSwitchTileState extends State<DarkModeSwitchTile> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.nightlight_round),
      title: Text(AppLocalizations.of(context)!.darkMode),
      trailing: Switch(
        value: isDark,
        onChanged: (val) {
          setState(() => isDark = val);
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${AppLocalizations.of(context)!.notAvailableNow}'),
                duration: Duration(seconds: 3),
                backgroundColor: ColorManager.error,
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.symmetric(vertical: 100.h, horizontal: 16.w),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            );
          };


        },
      ),
    );
  }
}
