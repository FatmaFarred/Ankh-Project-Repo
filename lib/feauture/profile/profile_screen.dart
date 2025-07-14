import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/core/customized_widgets/shared_preferences%20.dart';
import 'package:ankh_project/feauture/authentication/signin/signin_screen.dart';
import 'package:ankh_project/feauture/profile/widegts/setting_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../core/constants/assets_manager.dart';
import '../../l10n/app_localizations.dart';
import '../authentication/user_controller/user_cubit.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserCubit>().state;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.account),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: ColorManager.containerGrey,
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Column(children: [ Container(
                  height: 300.h,
                  width: double.infinity,
                  color: ColorManager.lightprimary,
                ),
                  Container(height: 90.h,
                    decoration: BoxDecoration(
                      color: ColorManager.containerGrey,
                      borderRadius: BorderRadius.circular(20.r)
                    ),
                  )
                ],),
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
                      color: ColorManager.white,// Dark greenish
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const CircleAvatar(
                                radius: 40,
                                backgroundImage:
                                AssetImage(ImageAssets.profilePic,), // Replace with your asset
                              ),
                              const SizedBox(height: 10),
                               Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   Text( user?.fullName ?? "Guest",
                                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16.sp,)
                                                               ),
                                   Image.asset(ImageAssets.goldMedal,
                                      scale: 6.sp,
                                      height: 24.h,
                                      width: 18.w,

                                   )

                                 ],
                               ),
                              const SizedBox(height: 4),
                              RatingBarIndicator(
                                rating: 5,
                                itemBuilder: (context, _) => const Icon(Icons.star, color: ColorManager.starRateColor),
                                itemCount: 5,
                                itemSize: 14.sp,
                                direction: Axis.horizontal,
                              ),
                              const SizedBox(height: 8),
                              TextButton(
                                onPressed: () {},
                                child:  Text(AppLocalizations.of(context)!.editProfile,
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14.sp,decoration: TextDecoration.underline, )
                                ),

                              ),
                               Divider(color: ColorManager.darkGrey, thickness: 1),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children:  [
                                  ProfileStat(label: "Completed", value: "234"),
                                  SizedBox(
                                    height: 40.h, // must give height
                                    child: VerticalDivider(
                                      color: ColorManager.darkGrey,
                                      thickness: 1,
                                    ),
                                  ),
                                  ProfileStat(label: "Rating", value: "4.9/5.0"),
                                  SizedBox(
                                    height: 40.h, // must give height
                                    child: VerticalDivider(
                                      color: ColorManager.darkGrey,
                                      thickness: 1,
                                    ),
                                  ),
                                  ProfileStat(label: "Response", value: "98%"),
                                ],
                              )
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
                padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
                children:  [
                  _tableSection(title: AppLocalizations.of(context)!.manageAccount,
                      rows: [
                        SettingsTile(title:  AppLocalizations.of(context)!.personalDetails, icon: Iconsax.user),
                        SettingsTile(title: AppLocalizations.of(context)!.securitySettings, icon: Iconsax.lock),
                        SettingsTile(title: AppLocalizations.of(context)!.notifications, icon: Iconsax.notification),
                      ]
                  ),
                  _tableSection(title:AppLocalizations.of(context)!.paymentAndWallets,
                      rows: [
                        SettingsTile(title: AppLocalizations.of(context)!.walletAndCommissions, icon: Iconsax.empty_wallet),
                        SettingsTile(title: AppLocalizations.of(context)!.paymentMethods, icon: Iconsax.card),
                      ]
                  ),
                  _tableSection(title:AppLocalizations.of(context)!.preferences,
                      rows: [
                        SettingsTile(title:AppLocalizations.of(context)!.devicePreferences, icon: Icons.phone_android_rounded),
                        SettingsTile(title: AppLocalizations.of(context)!.myFavorites, icon: Iconsax.heart),
                        DarkModeSwitchTile(),
                        SettingsTile(title: "Language", icon: Icons.language),
                      ]
                  ),
                  _tableSection(title:AppLocalizations.of(context)!.helpAndSupport,
                      rows: [
                        SettingsTile(title:AppLocalizations.of(context)!.contactSupport, icon: Iconsax.call),
                        SettingsTile(title: AppLocalizations.of(context)!.saftyCenter, icon: Icons.info_outline_rounded),
                      ]
                  ),
                  _tableSection(title:"",
                      rows: [
                        SettingsTile(title:AppLocalizations.of(context)!.logout, icon: Iconsax.logout,onTap:(){
                          SharedPrefsManager.removeData(key: 'user_token');
                          SharedPrefsManager.removeData(key:  'currentUser');
                          context.read<UserCubit>().clearUser();
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            SignInScreen.signInScreenRouteName,
                                  (route) => false

                          );

                        } ,),
                      ]
                  ),





                ],
              ),
            ),
          ],
        ),
      ),
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
        Text(label,
            style:Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12.sp,color:ColorManager.darkGrey)
        ),
        Text(value,
            style:Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14.sp)
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
      title: Text(AppLocalizations.of(context)!.darkMode,),
      trailing: Switch(

        value: isDark,
        onChanged: (val) {
          setState(() => isDark = val);
        },
      ),
    );
  }
}
