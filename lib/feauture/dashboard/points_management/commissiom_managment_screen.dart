import 'package:ankh_project/api_service/di/di.dart';

import 'package:ankh_project/core/constants/color_manager.dart';

import 'package:ankh_project/core/customized_widgets/reusable_widgets/custom_dialog.dart';

import 'package:ankh_project/core/customized_widgets/reusable_widgets/custom_text_field.dart';

import 'package:ankh_project/core/customized_widgets/reusable_widgets/customized_elevated_button.dart';

import 'package:ankh_project/core/customized_widgets/shared_preferences .dart';



import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../l10n/app_localizations.dart';

import 'cubit/commission_rate_cubit.dart';

import 'cubit/commission_rate_states.dart';

// Simple data model for static roles
class StaticRoleData {
  final String roleName;
  final bool isActive;

  StaticRoleData({required this.roleName, this.isActive = true});
}

class CommissiomManagmentScreen extends StatefulWidget {
  final String? roleName; // Add roleName parameter
  
  const CommissiomManagmentScreen({Key? key, this.roleName}) : super(key: key);

  @override
  State<CommissiomManagmentScreen> createState() => _CommissiomManagmentScreenState();
}

class _CommissiomManagmentScreenState extends State<CommissiomManagmentScreen> {
  CommissionRateCubit commissionRateCubit = getIt<CommissionRateCubit>();
  String? userToken;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  // Static list of roles
  List<StaticRoleData> staticRoles = [
    StaticRoleData(roleName: 'Marketer'),
    StaticRoleData(roleName: 'Inspector'),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // No filtering needed for static list
  }


  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    userToken = await SharedPrefsManager.getData(key: 'user_token');
  }


  Future<void> _refreshData() async {
    print("🔄 Refresh triggered!"); // Debug print
    setState(() {
      // Refresh the UI if needed
    });
    print("✅ Refresh completed!"); // Debug print
  }

  List<StaticRoleData> _getFilteredRoles() {
    return staticRoles;
  }


  void _showEditPriceBottomSheet(BuildContext context, StaticRoleData roleData) {
    final TextEditingController rateControler = TextEditingController();
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          child: Form(
            key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Icon(Icons.edit, color: ColorManager.lightprimary, size: 24.sp),
                  SizedBox(width: 12.w),
                  Text(
                    AppLocalizations.of(context)!.editCommissionRate,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              
              // Role info
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: ColorManager.lightGrey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.person, color: ColorManager.lightprimary, size: 20.sp),
                    SizedBox(width: 8.w),
                    Text(
                      '${roleData.roleName}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: ColorManager.textBlack,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              
              // Price input field
              Text(
                '${AppLocalizations.of(context)!.commissionRate}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: ColorManager.textBlack,
                ),
              ),
              SizedBox(height: 8.h),
              CustomTextField(
                controller: rateControler,
                hintText: AppLocalizations.of(context)!.enterCommissionRate,
                keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return AppLocalizations.of(context)!.enterCommissionRate;
                    }
                    final rate = num.tryParse(value.trim());
                    if (rate == null || rate <= 0) {
                      return AppLocalizations.of(context)!.invalidNumber;
                    }
                    return null;
                  },
              ),
              SizedBox(height: 24.h),
              
              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: CustomizedElevatedButton(
                      bottonWidget: Text(
                        AppLocalizations.of(context)!.cancel,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: ColorManager.textBlack,
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                      color: ColorManager.white,
                      borderColor: ColorManager.lightGrey,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: CustomizedElevatedButton(
                      bottonWidget: Text(
                        AppLocalizations.of(context)!.update,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: ColorManager.white,
                        ),
                      ),
                      onPressed: () {
                          if (_formKey.currentState!.validate()) {
                        final newRate = num.tryParse(rateControler.text.trim());
                            if (newRate != null && newRate > 0 && userToken != null) {
                              commissionRateCubit.editRateForRoles(userToken!, newRate, roleData.roleName);
                              Navigator.pop(context);
                            }
                          }
                      },
                      color: ColorManager.lightprimary,
                      borderColor: ColorManager.lightprimary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
            ],
            ),
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return BlocListener<CommissionRateCubit, CommissionRateStates>(
      bloc: commissionRateCubit,
      listener: (context, state) {
        if (state is CommissionRateLoading) {
          CustomDialog.loading(
            context: context,
            message: AppLocalizations.of(context)!.loading,
            cancelable: false,
          );
        } else if (state is CommissionRateSuccess) {
          Navigator.of(context).pop(); // Close loading dialog
          CustomDialog.positiveButton(
            context: context,
            title: AppLocalizations.of(context)!.success,
            message: state.response ?? AppLocalizations.of(context)!.success,
            positiveOnClick: () {
              Navigator.of(context).pop();
            },
          );
        } else if (state is CommissionRateError) {
          Navigator.of(context).pop(); // Close loading dialog
          CustomDialog.positiveButton(
            context: context,
            title: AppLocalizations.of(context)!.error,
            message: state.error.errorMessage ?? AppLocalizations.of(context)!.error,
            positiveOnClick: () {
              Navigator.of(context).pop();
            },
          );
        }
      },
      child: Scaffold(
        backgroundColor: ColorManager.white,
        appBar: AppBar(
          backgroundColor: ColorManager.lightprimary,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
              AppLocalizations.of(context)!.commissionRateManagement,


            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontSize: 18.sp,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            SizedBox(height: 20.h),

            // Point Prices List
            Expanded(
              child: RefreshIndicator(
                      color: ColorManager.lightprimary,
                      onRefresh: _refreshData,
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemCount: _getFilteredRoles().length,
                        physics: AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                    final roleData = _getFilteredRoles()[index];
                          
                          return Container(
                            margin: EdgeInsets.only(bottom: 16.h),
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              color: ColorManager.white,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: ColorManager.lightGrey,
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: ColorManager.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Header with role and status
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                      roleData.roleName,
                                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                              color: ColorManager.textBlack,
                                            ),
                                          ),
                                          SizedBox(height: 4.h),
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                                            decoration: BoxDecoration(
                                               color: ColorManager.darkGreen.withOpacity(0.1),
                                              borderRadius: BorderRadius.circular(12.r),
                                            ),
                                            child: Text(
                                               AppLocalizations.of(context)!.active,
                                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                fontSize: 12.sp,
                                                color: ColorManager.darkGreen
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () => _showEditPriceBottomSheet(context, roleData),
                                      icon: Icon(
                                        Icons.edit,
                                        color: ColorManager.lightprimary,
                                        size: 20.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 
