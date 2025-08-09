import 'package:ankh_project/core/constants/assets_manager.dart';
import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/feauture/dashboard/custom_widgets/custom_bottom_sheet.dart';
import 'package:ankh_project/feauture/dashboard/users_management/cubit/users_management_cubit.dart';
import 'package:ankh_project/feauture/dashboard/users_management/cubit/users_management_states.dart';
import 'package:ankh_project/feauture/dashboard/users_management/user_details_screen.dart';
import 'package:ankh_project/feauture/inspector_screen/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/customized_widgets/reusable_widgets/custom_text_field.dart';
import '../../../core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import '../../../core/customized_widgets/reusable_widgets/customized_search_bar.dart';
import '../../../l10n/app_localizations.dart';
import '../../../api_service/di/di.dart';
import '../../../domain/entities/all_users_entity.dart';

class UsersManagementScreen extends StatefulWidget {
  const UsersManagementScreen({Key? key}) : super(key: key);

  @override
  State<UsersManagementScreen> createState() => _UsersManagementScreenState();
}

class _UsersManagementScreenState extends State<UsersManagementScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  late UsersManagementCubit _usersManagementCubit;

  @override
  void initState() {
    super.initState();
    _usersManagementCubit = getIt<UsersManagementCubit>();
    _usersManagementCubit.fetchUsers();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    setState(() {
      _searchQuery = value;
    });
    if (value.isEmpty) {
      _usersManagementCubit.fetchUsers();
    } else {
      _usersManagementCubit.searchUsers(value);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Text(
                AppLocalizations.of(context)!.usersManagement,
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize:18.sp ),
              ),
            ],
          ),
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomizedSearchBar(
                  onSearch: _onSearchChanged,
                  hintText: AppLocalizations.of(context)!.search,
                  outlineInputBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide:  BorderSide(
                        color: ColorManager.lightGreyShade2,
                        width: 2,
                      ))


              )
          ),

          Expanded(
            child: BlocBuilder<UsersManagementCubit, UsersManagementState>(
              bloc: _usersManagementCubit,
              builder: (context, state) {
                if (state is UsersManagementLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is UsersManagementSuccess) {
                  if (state.usersList.isEmpty) {
                    return Center(
                      child: Text(
                        AppLocalizations.of(context)!.noUsersFound,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    );
                  }
                  return RefreshIndicator(
                    onRefresh: () async {
                      _usersManagementCubit.fetchUsers();
                    },
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      itemCount: state.usersList.length,
                      itemBuilder: (context, index) {
                        final user = state.usersList[index];
                        return UserCard(
                          user: user,
                          onViewPressed: () {
                            Navigator.of(context).pushNamed(
                              UserDetailsScreen.routeName,
                              arguments: user,
                            );
                          },
                        );
                      },
                    ),
                  );
                } else if (state is UsersManagementEmpty) {
                  return Center(
                    child: Text(
                      AppLocalizations.of(context)!.noUsersFound,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  );
                } else if (state is UsersManagementError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          state.error.errorMessage??"",
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: ColorManager.error,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        ElevatedButton(
                          onPressed: () {
                            _usersManagementCubit.fetchUsers();
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
          ),
        ],
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  final AllUsersEntity user;
  final bool showAssignedProductsNum;
  final VoidCallback onViewPressed;
  const UserCard({Key? key, required this.user, this.showAssignedProductsNum=false, required this.onViewPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isActive = true; // Default to active since status is not available in API
    return Card(
      elevation: 0,
      color: ColorManager.white,
      margin:  EdgeInsets.symmetric(vertical: 8.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r),side: BorderSide(color: ColorManager.lightGrey)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(ImageAssets.userIcon, height: 18.h,width: 18.w,),
                 SizedBox(width: 6.w),
                Text(
                  user.fullName ?? '',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                ),
              ],
            ),
             SizedBox(height: 8.h),
            Row(
              children: [
                SvgPicture.asset(ImageAssets.callIcon, height: 18.h,width: 18.w,),
                 SizedBox(width: 6.w),
                Text(user.phoneNumber ?? '',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                ),
              ],
            ),
             SizedBox(height: 10.h),
            Row(
              children: [
                SvgPicture.asset(ImageAssets.mailIcon, height: 18.h,width: 18.w,),
                 SizedBox(width: 6.w),
                Text(user.email ?? '',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                ),
              ],
            ),
             SizedBox(height: 10.h),
           showAssignedProductsNum? Row(
              children: [
                SvgPicture.asset(ImageAssets.assignedIcon, height: 18.h,width: 18.w,),

                SizedBox(width: 6.w),
                Text("${AppLocalizations.of(context)!.assignedProducts} :",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                ),

                Text('0', // Not available in API
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                ),
              ],
            ):SizedBox.shrink(),
             SizedBox(height: 10.h),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: ColorManager.white,

                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),side: BorderSide(color: ColorManager.darkGrey)),
                    ),
                    onPressed: onViewPressed,
                    icon: Icon(Icons.visibility, color: Color(0xffD4AF37), size: 20.sp),

                    label:Text(AppLocalizations.of(context)!.view,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 12.sp,color: ColorManager.lightprimary),

                    ),
                  ),
                ),
              ],

            ),
          ],
        ),
      ),
    );
  }

// ... inside your widget class

  void _showBottomSheet({ required BuildContext context,
    required  String title,
    required String description,
    required String cancelText,
    required String confirmText,
    required VoidCallback onCancel,
    required VoidCallback onConfirm,
      Color? cancelColor,
      Color? confirmColor,
    Widget ? icon,


  }) {
    showModalBottomSheet(

      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => CustomBottomSheet(

        title: title,
        description: description,
        cancelText: cancelText,
        confirmText: confirmText,
        onCancel: () => onCancel,
        onConfirm:()=>onConfirm,
        confirmColor: Colors.red,
        icon: icon,
      ),
    );
  }
} 