import 'dart:ui';

import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import 'package:ankh_project/domain/entities/all_users_entity.dart';
import 'package:ankh_project/feauture/dashboard/users_management/cubit/user_favorites_cubit.dart';
import 'package:ankh_project/feauture/dashboard/users_management/cubit/user_favorites_states.dart';
import 'package:ankh_project/feauture/dashboard/marketer_mangemnet/cubit/block_user_cubit.dart';
import 'package:ankh_project/feauture/dashboard/marketer_mangemnet/cubit/unblock_user_cubit.dart';
import 'package:ankh_project/feauture/home_screen/header_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../api_service/di/di.dart';
import '../../../api_service/api_constants.dart';
import '../../../core/constants/assets_manager.dart';
import '../../../core/customized_widgets/reusable_widgets/custom_dialog.dart';
import '../../../l10n/app_localizations.dart';
import '../../details_screen/details_screen.dart';
import '../../inspector_screen/widgets/photo_list_view.dart';
import '../custom_widgets/photo_list.dart';
import '../custom_widgets/custom_bottom_sheet.dart';

class UserDetailsScreen extends StatefulWidget {
  static const String routeName = 'UserDetailsScreen';

  const UserDetailsScreen({Key? key}) : super(key: key);

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  late UserFavoritesCubit userFavoritesCubit;
  BlockUserCubit blockUserCubit = getIt<BlockUserCubit>();
  UnblockUserCubit unblockUserCubit = getIt<UnblockUserCubit>();

  @override
  void initState() {
    super.initState();
    userFavoritesCubit = getIt<UserFavoritesCubit>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final user = ModalRoute.of(context)!.settings.arguments as AllUsersEntity;
    userFavoritesCubit.fetchUserFavorites(user.id ?? '');
  }

  @override
  void dispose() {
    blockUserCubit.close();
    unblockUserCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)!.settings.arguments as AllUsersEntity;
    return MultiBlocListener(
      listeners: [
        BlocListener<BlockUserCubit, BlockUserState>(
          bloc: blockUserCubit,
          listener: (context, state) {
            if (state is BlockUserLoading) {
              CustomDialog.loading(
                context: context,
                message: AppLocalizations.of(context)!.loading,
                cancelable: false,
              );
            } else if (state is BlockUserFailure) {
              Navigator.of(context).pop();
              CustomDialog.positiveAndNegativeButton(
                context: context,
                positiveText: AppLocalizations.of(context)!.tryAgain,
                positiveOnClick: () {
                  Navigator.of(context).pop();
                  _showBlockUserBottomSheet();
                },
                title: AppLocalizations.of(context)!.error,
                message: state.error.errorMessage,
              );
            } else if (state is BlockUserSuccess) {
              Navigator.of(context).pop();
              CustomDialog.positiveButton(
                context: context,
                title: AppLocalizations.of(context)!.success,
                message: state.response,
                positiveOnClick: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              );
            }
          },
        ),
        BlocListener<UnblockUserCubit, UnblockUserState>(
          bloc: unblockUserCubit,
          listener: (context, state) {
            if (state is UnblockUserLoading) {
              CustomDialog.loading(
                context: context,
                message: AppLocalizations.of(context)!.loading,
                cancelable: false,
              );
            } else if (state is UnblockUserFailure) {
              Navigator.of(context).pop();
              CustomDialog.positiveAndNegativeButton(
                context: context,
                positiveText: AppLocalizations.of(context)!.tryAgain,
                positiveOnClick: () {
                  Navigator.of(context).pop();
                  _showUnblockUserBottomSheet();
                },
                title: AppLocalizations.of(context)!.error,
                message: state.error.errorMessage,
              );
            } else if (state is UnblockUserSuccess) {
              Navigator.of(context).pop();
              CustomDialog.positiveButton(
                context: context,
                title: AppLocalizations.of(context)!.success,
                message: state.response,
                positiveOnClick: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              );
            }
          },
        ),
      ],
      child: Scaffold(
      appBar: AppBar(
        title:  Text(AppLocalizations.of(context)!.userDetails),
        backgroundColor: ColorManager.lightprimary,
        leading: IconButton(onPressed: ()=>Navigator.pop(context), icon:Icon (Icons.arrow_back_ios)),
      ),
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                userFavoritesCubit.fetchUserFavorites(user.id ?? '');
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.all(16.0.w),
                  child: Column(
                    children: [
                      UserDetailsCard(user: user, userFavoritesCubit: userFavoritesCubit),
                      SizedBox(height: 16.h),
              BlocBuilder<UserFavoritesCubit, UserFavoritesState>(
                bloc: userFavoritesCubit,
                builder: (context, state) {
                  if (state is UserFavoritesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is UserFavoritesSuccess) {
                    if (state.favoritesList.isEmpty) {
                      return Center(
                        child: Text(
                          AppLocalizations.of(context)!.noFavoritesFound,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      );
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              ImageAssets.carIcon2,
                              height: 18.h,
                              width: 18.w,
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              AppLocalizations.of(context)!.favoriteProducts,
                              style: Theme.of(
                                context,
                              ).textTheme.bodyLarge!.copyWith(fontSize: 16.sp),
                            ),
                            SizedBox(width: 6.w),
                          ],
                        ),
                        SizedBox(height: 12),
                        RefreshIndicator(
                          onRefresh: () async {
                            userFavoritesCubit.fetchUserFavorites(user.id ?? '');
                          },
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.favoritesList.length,
                            itemBuilder: (context, index) {
                              final product = state.favoritesList[index];
                              return AssignedProductCard(
                                image:
                                "${ApiConstant.imageBaseUrl}${product?.imageUrls}" ,
                                name: product.title ?? '',
                                price: "${AppLocalizations.of(context)!.egp} ${product.price ?? ''}",
                                onButtonClick: () {
                                  "image:${ApiConstant.imageBaseUrl}${[product?.imageUrls]}";
                                  Navigator.of(context).pushNamed(DetailsScreen.detailsScreenRouteName,
                                      arguments: product.productId
                                  );
                                },
                                TextButton: AppLocalizations.of(context)!.view,
                                TextColor: ColorManager.lightprimary,
                                backgroundColor: ColorManager.white,
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  } else if (state is UserFavoritesEmpty) {
                    return Center(
                      child: Text(
                        AppLocalizations.of(context)!.noFavoritesFound,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    );
                  } else if (state is UserFavoritesError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            state.error.errorMessage ?? "Error loading favorites",
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: ColorManager.error,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          ElevatedButton(
                            onPressed: () {
                              userFavoritesCubit.fetchUserFavorites(user.id ?? '');
                            },
                            child: Text(AppLocalizations.of(context)!.tryAgain),
                          ),
                        ],
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              SizedBox(height: 24.h),
              /*Row(
                children: [
                  SvgPicture.asset(
                    ImageAssets.imageIcon,
                    height: 18.h,
                    width: 18.w,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    "${AppLocalizations.of(context)!.images} ",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge!.copyWith(fontSize: 16.sp),
                  ),
                  SizedBox(width: 6.w),
                ],
              ),
              SizedBox(height: 12.h),*/
              // PhotoList(imageUrls: [],),
              SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Buttons at the bottom
          Padding(
            padding: EdgeInsets.all(16.0.w),
            child: Column(
              children: [
              CustomizedElevatedButton(
                bottonWidget: Text(
                  AppLocalizations.of(context)!.unblockUser,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 16.sp,
                    color: ColorManager.white,
                  ),
                ),
                onPressed: () {
                  _showUnblockUserBottomSheet();
                },
                color: ColorManager.lightprimary,
                borderColor: ColorManager.lightprimary,
              ),
              SizedBox(height: 16.h),
              CustomizedElevatedButton(
                bottonWidget: Text(
                  AppLocalizations.of(context)!.blockUser,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 16.sp,
                    color: ColorManager.white,
                  ),
                ),
                onPressed: () {
                  _showBlockUserBottomSheet();
                },
                color: ColorManager.error,
                borderColor: ColorManager.error,
              ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  void _showBlockUserBottomSheet() {
    final user = ModalRoute.of(context)!.settings.arguments as AllUsersEntity;
    final TextEditingController reasonController = TextEditingController();
    final TextEditingController daysController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          padding: EdgeInsets.all(20.w),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Row(
                  children: [
                    Icon(
                      Icons.block,
                      size: 24.h,
                      color: ColorManager.error,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      AppLocalizations.of(context)!.blockUser,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  AppLocalizations.of(context)!.blockUserSubtitle,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp,color: ColorManager.darkGrey),
                ),
                SizedBox(height: 20.h),
                Text(
                  AppLocalizations.of(context)!.reasonForBlocking,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                ),
                SizedBox(height: 8.h),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return AppLocalizations.of(context)!.fieldRequired;
                    }
                    return null;
                  },
                  controller: reasonController,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.enterReasonForBlocking,
                    hintStyle: Theme.of(context).textTheme.bodySmall,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(color: ColorManager.lightGrey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(color: ColorManager.lightGrey),
                    ),
                  ),
                  maxLines: 3,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: 16.h),
                Text(
                  AppLocalizations.of(context)!.blockDaysCount,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: 8.h),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return AppLocalizations.of(context)!.fieldRequired;
                    }
                    return null;
                  },
                  controller: daysController,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.enterBlockDaysCount,
                    hintStyle: Theme.of(context).textTheme.bodySmall,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(color: ColorManager.lightGrey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(color: ColorManager.lightGrey),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.white,
                          side: BorderSide(color: ColorManager.lightGrey),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.cancel,
                          style: TextStyle(color: ColorManager.darkGrey),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            Navigator.pop(context);
                            blockUserCubit.blockUser(
                              user.id ?? '',
                              reasonController.text,
                              int.parse(daysController.text),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.error,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.block,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  void _showUnblockUserBottomSheet() {
    final user = ModalRoute.of(context)!.settings.arguments as AllUsersEntity;

    showModalBottomSheet(
      context: context,
      builder: (context) => CustomBottomSheet(
        title: AppLocalizations.of(context)!.unblockUser,
        description: AppLocalizations.of(context)!.unblockUserSubtitle,
        cancelText: AppLocalizations.of(context)!.cancel,
        confirmText: AppLocalizations.of(context)!.unblock,
        onCancel: () => Navigator.pop(context),
        onConfirm: () {
          Navigator.pop(context);
          unblockUserCubit.unblockUser(user.id ?? '');
        },
        icon: Icon(Icons.lock_open, color: ColorManager.lightprimary),
      ),
    );
  }
}

class UserDetailsCard extends StatelessWidget {
  AllUsersEntity user;
  UserFavoritesCubit userFavoritesCubit;

   UserDetailsCard({Key? key, required this.user, required this.userFavoritesCubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: ColorManager.white,
      margin: EdgeInsets.symmetric(vertical: 8.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
        side: BorderSide(color: ColorManager.lightGrey),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  ImageAssets.userIcon,
                  height: 18.h,
                  width: 18.w,
                ),
                SizedBox(width: 6.w),
                Text(
                  user.fullName??"",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                ),

              ],
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                SvgPicture.asset(
                  ImageAssets.callIcon,
                  height: 18.h,
                  width: 18.w,
                ),
                SizedBox(width: 6.w),
                Text(
                  user.phoneNumber??"",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                SvgPicture.asset(
                  ImageAssets.mailIcon,
                  height: 18.h,
                  width: 18.w,
                ),
                SizedBox(width: 6.w),
                Text(
                  user.email??"",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                SvgPicture.asset(
                  ImageAssets.carIcon2,
                  height: 18.h,
                  width: 18.w,
                ),
                SizedBox(width: 6.w),
                Text(
                  "${AppLocalizations.of(context)!.interestedCars} :",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                ),

                SizedBox(width: 6.w),
                BlocBuilder<UserFavoritesCubit, UserFavoritesState>(
                  bloc: userFavoritesCubit,
                  builder: (context, state) {
                    int count = 0;
                    if (state is UserFavoritesSuccess) {
                      count = state.favoritesList.length;
                    }
                    return Text(
                      count.toString(),
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 10.h),


          ],
        ),
      ),
    );
  }
}

class AssignedProductCard extends StatelessWidget {
  final String image;
  final String name;
  final String price;
  final VoidCallback onButtonClick;
  final String TextButton;
  final Color TextColor;
  final Color backgroundColor;

  const AssignedProductCard({
    required this.image,
    required this.name,
    required this.price,
    required this.onButtonClick,
    required this.TextButton,
    required this.TextColor,
    required  this.backgroundColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: ColorManager.white,
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),side: BorderSide(color: ColorManager.lightGrey)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child:
                Image.network(
                        image,
                        width: 60,
                        height: 60,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            ImageAssets.brokenImage,
                            width: 60,
                            height: 60,
                            fit: BoxFit.contain,
                          );
                        },
                      )
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: 6),
                  Row(
                    children: [
                      SvgPicture.asset(ImageAssets.tagPriceIcon, height: 18.h, width: 18.w, color: Colors.grey),
                      SizedBox(width: 4),
                      Text(price,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 12.sp,color: ColorManager.lightprimary),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 12),
            ElevatedButton(
              onPressed: onButtonClick,
              style: ElevatedButton.styleFrom(
                backgroundColor:backgroundColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                elevation: 0,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
              ),

              child: Text(TextButton, style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 12.sp,color: TextColor,
              ),
            ),
            )],
        ),
      ),
    );
  }
}
