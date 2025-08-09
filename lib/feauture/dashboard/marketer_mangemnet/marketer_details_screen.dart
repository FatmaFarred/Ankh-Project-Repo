import 'package:ankh_project/api_service/api_constants.dart';
import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import 'package:ankh_project/domain/entities/all_marketers_entity.dart';
import 'package:ankh_project/feauture/marketer_products/get_product_controller/marketer_product_cubit.dart';
import 'package:ankh_project/feauture/marketer_products/get_product_controller/states.dart';

import 'package:ankh_project/feauture/dashboard/marketer_mangemnet/cubit/update_marketer_status_cubit.dart';
import 'package:ankh_project/feauture/dashboard/marketer_mangemnet/cubit/update_marketer_status_states.dart';
import 'package:ankh_project/feauture/dashboard/marketer_mangemnet/cubit/block_user_cubit.dart';
import 'package:ankh_project/feauture/dashboard/marketer_mangemnet/cubit/unblock_user_cubit.dart';
import 'package:ankh_project/feauture/dashboard/marketer_mangemnet/cubit/appoint_as_team_leader_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../api_service/di/di.dart';
import '../../../core/constants/assets_manager.dart';
import '../../../core/customized_widgets/reusable_widgets/custom_dialog.dart';
import '../../../core/customized_widgets/reusable_widgets/custom_text_field.dart';
import '../../../core/customized_widgets/shared_preferences .dart';
import '../../../l10n/app_localizations.dart';
import '../../authentication/user_controller/user_cubit.dart';
import '../../details_screen/details_screen.dart';
import '../../marketer_home/assign_product_controller/marketer_product_cubit.dart';
import '../../marketer_home/assign_product_controller/states.dart';
import '../custom_widgets/custom_bottom_sheet.dart';
import '../users_management/user_details_screen.dart';
import 'cubit/appoint_as_team_leader_states.dart';
import '../cubit/adjust_user_points_cubit.dart';
import '../widgets/adjust_points_bottom_sheet.dart';

class MarketerDetailsScreen extends StatefulWidget {
  static const String routeName = 'MarketerDetailsScreen';



  const MarketerDetailsScreen({
    Key? key,

  }) ;

  @override
  State<MarketerDetailsScreen> createState() => _MarketerDetailsScreenState();
}

class _MarketerDetailsScreenState extends State<MarketerDetailsScreen> {
  MarketerProductCubit marketerProductCubit = getIt<MarketerProductCubit>();
  UpdateMarketerStatusCubit updateMarketerStatusCubit = getIt<UpdateMarketerStatusCubit>();
  BlockUserCubit blockUserCubit = getIt<BlockUserCubit>();
  UnblockUserCubit unblockUserCubit = getIt<UnblockUserCubit>();
  AppointAsTeamLeaderCubit appointAsTeamLeaderCubit = getIt<AppointAsTeamLeaderCubit>();
  AdjustUserPointsCubit adjustUserPointsCubit = getIt<AdjustUserPointsCubit>();
  String? token;


  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final marketer = ModalRoute.of(context)!.settings.arguments as AllMarketersEntity;
      if (marketer.id != null && marketer.id!.isNotEmpty) {
        marketerProductCubit.fetchProducts(marketer.id!);
      }
    });
    _loadToken();
  }
  Future<void> _loadToken() async {
    final fetchedToken = await SharedPrefsManager.getData(key: 'user_token');
    setState(() {
      token = fetchedToken;
    });
    print("👤 User ID: $token");
  }


  @override
  void dispose() {
    marketerProductCubit.close();
    updateMarketerStatusCubit.close();
    blockUserCubit.close();
    unblockUserCubit.close();
    appointAsTeamLeaderCubit.close();
    adjustUserPointsCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserCubit>().state;

    final marketer =
    ModalRoute.of(context)!.settings.arguments as AllMarketersEntity;
    final isActive = marketer.accountStatus == 'Active';
    return MultiBlocListener(
      listeners: [

        BlocListener<UpdateMarketerStatusCubit, UpdateMarketerStatusState>(
          bloc: updateMarketerStatusCubit,
          listener: (context, state) {
            if (state is UpdateMarketerStatusLoading) {
              CustomDialog.loading(
                context: context,
                message: AppLocalizations.of(context)!.loading,
                cancelable: false,
              );
            } else if (state is UpdateMarketerStatusFailure) {
              Navigator.of(context).pop();
              CustomDialog.positiveAndNegativeButton(
                context: context,
                positiveText: AppLocalizations.of(context)!.tryAgain,
                positiveOnClick: () {
                  Navigator.of(context).pop();
                  // Re-trigger the delete action
                  _showDeleteConfirmation();
                },
                title: AppLocalizations.of(context)!.error,
                message: state.error.errorMessage,
              );
            } else if (state is UpdateMarketerStatusSuccess) {
              Navigator.of(context).pop();
              CustomDialog.positiveButton(
                context: context,
                title: AppLocalizations.of(context)!.success,
                message: state.response ?? AppLocalizations.of(context)!.success,
                positiveOnClick: () {
                  //Navigator.of(context).pop();
                  // Navigate back to marketer management screen
                 // Navigator.of(context).pop();
                },
              );
            }
          },
        ),
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
                  // Re-trigger the block action
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
                 // Navigator.of(context).pop();
                  // Refresh the screen or navigate back
                 // Navigator.of(context).pop();
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
                 // Navigator.of(context).pop();
                  // Re-trigger the unblock action
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
                 // Navigator.of(context).pop();
                  // Refresh the screen or navigate back
                 // Navigator.of(context).pop();
                },
              );
            }
          },
        ),
        BlocListener<AppointAsTeamLeaderCubit, AppointAsTeamLeaderState>(
          bloc: appointAsTeamLeaderCubit,
          listener: (context, state) {
            if (state is AppointAsTeamLeaderLoading) {
              CustomDialog.loading(
                context: context,
                message: AppLocalizations.of(context)!.loading,
                cancelable: false,
              );
            } else if (state is AppointAsTeamLeaderFailure) {
              Navigator.of(context).pop();
              CustomDialog.positiveAndNegativeButton(
                context: context,
                positiveText: AppLocalizations.of(context)!.tryAgain,
                positiveOnClick: () {
                 // Navigator.of(context).pop();
                  // Re-trigger the appoint action
                  appointAsTeamLeaderCubit.appointAsTeamLeader(marketer.id ?? '', 'LeaderMarketer');
                },
                title: AppLocalizations.of(context)!.error,
                message: state.failure.errorMessage,
              );
            } else if (state is AppointAsTeamLeaderSuccess) {
              Navigator.of(context).pop();
              CustomDialog.positiveButton(
                context: context,
                title: AppLocalizations.of(context)!.success,
                message: state.response ,
                positiveOnClick: () {
                  //Navigator.of(context).pop();
                  // Navigate back to marketer management screen
                 // Navigator.of(context).pop();
                },
              );
            }
          },
        ),
        BlocListener<AdjustUserPointsCubit, AdjustUserPointsState>(
          bloc: adjustUserPointsCubit,
          listener: (context, state) {
            if (state is AdjustUserPointsLoading) {
              CustomDialog.loading(
                context: context,
                message: AppLocalizations.of(context)!.loading,
                cancelable: false,
              );
            } else if (state is AdjustUserPointsFailure) {
              Navigator.of(context).pop();
              CustomDialog.positiveButton(
                context: context,
                title: AppLocalizations.of(context)!.error,
                message: state.failure.errorMessage,
                positiveText: AppLocalizations.of(context)!.ok,
                positiveOnClick: () => Navigator.of(context).pop(),
              );
            } else if (state is AdjustUserPointsSuccess) {
              Navigator.of(context).pop();
              CustomDialog.positiveButton(
                context: context,
                title: AppLocalizations.of(context)!.success,
                message: state.message ?? "Points adjusted successfully",
                positiveText: AppLocalizations.of(context)!.ok,
                positiveOnClick: () {},
              );
            }
          },
        ),

      ],
      child: Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.marketerDetails),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: RefreshIndicator(
        color: ColorManager.lightprimary,
        onRefresh: () async {
          final marketer = ModalRoute.of(context)!.settings.arguments as AllMarketersEntity;
          if (marketer.id != null && marketer.id!.isNotEmpty) {
            await marketerProductCubit.fetchProducts(marketer.id!);
          }
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(16.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              // Marketer Info Card
              Card(
                elevation: 0,
                color:ColorManager.white ,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),side: BorderSide(color: ColorManager.lightGrey)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(ImageAssets.userIcon, height: 20.h,width: 20.w,color: Color(0xff9333EA),),
                          SizedBox(width: 8.w),
                          Text(AppLocalizations.of(context)!.marketerInfo, style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 16.sp),
                ),
                        ],
                      ),
                      SizedBox(height: 16),
                      _readonlyField(AppLocalizations.of(context)!.marketerName, marketer.fullName ?? ''),
                      _readonlyField(AppLocalizations.of(context)!.email, marketer.email ?? ''),
                      _readonlyField(AppLocalizations.of(context)!.phoneNumber, marketer.phoneNumber ?? ''),
                      _readonlyField(AppLocalizations.of(context)!.joiningCode, marketer.code ?? ''),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Assigned Products Title
              Row(
                children: [
                  SvgPicture.asset(ImageAssets.assignedIcon, height: 20.h,width: 20.w,),
                  SizedBox(width: 6),
                  Text(AppLocalizations.of(context)!.assignedProducts,style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 16.sp),
                  ),
                ],
              ),
              SizedBox(height: 12),
              BlocBuilder<MarketerProductCubit, MarketerProductState>(
                bloc: marketerProductCubit,
                builder: (context, state) {
                  if (state is MarketerProductLoading) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.all(20.h),
                        child: CircularProgressIndicator(
                          color: ColorManager.lightprimary,
                        ),
                      ),
                    );
                  } else if (state is MarketerProductError) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.all(20.h),
                        child: Column(
                          children: [
                            Text(
                              state.error?.errorMessage ?? AppLocalizations.of(context)!.error,
                              style: Theme.of(context).textTheme.bodyMedium,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 12.h),
                          ],
                        ),
                      ),
                    );
                  } else if (state is MarketerProductEmpty) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.all(20.h),
                        child: Column(
                          children: [
                            Icon(
                              Icons.inventory_2_outlined,
                              size: 48.h,
                              color: ColorManager.darkGrey,
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              AppLocalizations.of(context)!.noProductsFound,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: ColorManager.darkGrey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  } else if (state is MarketerProductSuccess) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.productList.length,
                      itemBuilder: (context, index) {
                        final product = state.productList[index];
                        return AssignedProductCard(
                          image: product.image ?? ImageAssets.carPic1,
                          name: product.title ?? '',
                          price: product.price ?? '',
                          onButtonClick: () {
                            Navigator.of(context).pushNamed(DetailsScreen.detailsScreenRouteName,
                            arguments: product.id
                            );
                          },
                          TextButton: AppLocalizations.of(context)!.view,
                          TextColor: ColorManager.lightprimary,
                          backgroundColor: ColorManager.white,
                        );
                      },
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
              SizedBox(height: 24),
                              _actionButton(AppLocalizations.of(context)!.appointAsTeamLeader, ColorManager.darkGrey, Colors.white,
                       () => _showAppointAsTeamLeaderBottomSheet()
                ),
                SizedBox(height: 12),
                _actionButton(
                  AppLocalizations.of(context)!.sendPoints,
                  ColorManager.lightprimary,
                  Colors.white,
                      () => _showAdjustPointsBottomSheet(),
                ),
              SizedBox(height: 12),
              _actionButton(
                AppLocalizations.of(context)!.blockUser,
                ColorManager.error,
                Colors.white,
                () => _showBlockUserBottomSheet(),
              ),

              SizedBox(height: 12),
              _actionButton(
                AppLocalizations.of(context)!.unblockUser,
                ColorManager.lightprimary,
                Colors.white,
                () => _showUnblockUserBottomSheet(),
              ),
            ],
          ),
        ),
              ),
      ),
    ));
  }

  Widget _readonlyField(String label, String value,) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
          ),
          SizedBox(height: 4),
          TextFormField(
            initialValue: value,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
            readOnly: true,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8),borderSide: BorderSide(color: ColorManager.lightGrey)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton(String text, Color color, Color textColor, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      child: CustomizedElevatedButton(
        color:color ,
        borderColor: color,
        onPressed: onPressed,
        bottonWidget: Text(text, style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 16.sp, color: textColor)),
      ),
    );
  }

  void _showDeleteConfirmation() {
    final marketer = ModalRoute.of(context)!.settings.arguments as AllMarketersEntity;
    showModalBottomSheet(
      context: context,
      builder: (context) => CustomBottomSheet(
        title: AppLocalizations.of(context)!.rejectUserAccount,
        description: AppLocalizations.of(context)!.rejectUserAccountSubtitle,
        cancelText: AppLocalizations.of(context)!.cancel,
        confirmText: AppLocalizations.of(context)!.delete,
        onCancel: () => Navigator.pop(context),
        onConfirm: () {
          Navigator.pop(context);
          updateMarketerStatusCubit.updateMarketerAccountStatus(2, marketer.id ?? '');
        },
        icon: Icon(Icons.delete, color: ColorManager.error),
      ),
    );
  }

  void _showBlockUserBottomSheet() {
    final marketer = ModalRoute.of(context)!.settings.arguments as AllMarketersEntity;
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
                      return AppLocalizations.of(context)!.fieldRequired; // or use localization
                    }

                    return null; // Valid
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
                              marketer.id ?? '',
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
    final marketer = ModalRoute.of(context)!.settings.arguments as AllMarketersEntity;
    
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
          unblockUserCubit.unblockUser(marketer.id ?? '');
        },
        icon: Icon(Icons.lock_open, color: ColorManager.lightprimary),
      ),
    );
  }

  void _showAppointAsTeamLeaderBottomSheet() {
    final marketer = ModalRoute.of(context)!.settings.arguments as AllMarketersEntity;
    showModalBottomSheet(
      context: context,
      builder: (context) => CustomBottomSheet(
        title: AppLocalizations.of(context)!.appointAsTeamLeader,
        description: AppLocalizations.of(context)!.appointAsteamLeaderSubtitle,
        cancelText: AppLocalizations.of(context)!.cancel,
        confirmText: AppLocalizations.of(context)!.confirm,
        onCancel: () => Navigator.pop(context),
        onConfirm: () {
          Navigator.pop(context);
          appointAsTeamLeaderCubit.appointAsTeamLeader(marketer.id ?? '', 'LeaderMarketer');
        },
        icon: Icon(Icons.person_add, color: ColorManager.darkGrey),
      ),
    );
  }

  void _showAdjustPointsBottomSheet() {
    final marketer = ModalRoute.of(context)!.settings.arguments as AllMarketersEntity;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: AdjustPointsBottomSheet(
          userId: marketer.id ?? '',
          userName: marketer.fullName ?? 'Marketer',
          onAdjustPoints: (userId, points, reason) {
            adjustUserPointsCubit.adjustUserPoints(userId, points, reason);
          },
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
                child: Image.network("${ApiConstant.imageBaseUrl}$image",
                    width: 60.w, height: 60.h, fit: BoxFit.contain,
                 errorBuilder: (context, error, stackTrace) {
                   return Image.asset(
                     ImageAssets.brokenImage, // Your default image asset
                     width: 60.w,
                     height: 60.h,
                     fit: BoxFit.contain,
                   );
                 }),
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
