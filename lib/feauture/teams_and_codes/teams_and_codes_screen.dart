import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/feauture/teams_and_codes/cubit/teams_and_codes_cubit.dart';
import 'package:ankh_project/feauture/teams_and_codes/cubit/teams_and_codes_states.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter/services.dart';

import '../../api_service/di/di.dart';
import '../../core/constants/assets_manager.dart';
import '../../core/customized_widgets/reusable_widgets/custom_dialog.dart';
import '../../core/customized_widgets/shared_preferences .dart';
import '../../l10n/app_localizations.dart';
import '../../domain/use_cases/get_all_marketer_codes_use_case.dart';
import '../../domain/use_cases/get_team_member_use_case.dart';

class TeamsAndCodesScreen extends StatefulWidget {
  static const String teamsAndCodesRouteName = "teamsAndCodes";

  const TeamsAndCodesScreen({super.key});

  @override
  State<TeamsAndCodesScreen> createState() => _TeamsAndCodesScreenState();
}

class _TeamsAndCodesScreenState extends State<TeamsAndCodesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late TeamsAndCodesCubit _teamsAndCodesCubit;
  String? token;
  String? userId;
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedTabIndex = _tabController.index;
      });
    });
    _initializeCubit();
    _loadData();
  }

  void _initializeCubit() {
    final getAllMarketerCodesUseCase = getIt<GetAllMarketerCodesUseCase>();
    final getTeamMemberUseCase = getIt<GetTeamMemberUseCase>();
    _teamsAndCodesCubit = TeamsAndCodesCubit(
      getAllMarketerCodesUseCase: getAllMarketerCodesUseCase,
      getTeamMemberUseCase: getTeamMemberUseCase,
    );
  }

  Future<void> _loadData() async {
    final fetchedToken = await SharedPrefsManager.getData(key: 'user_token');
    final fetchedUserId = await SharedPrefsManager.getData(key: 'user_id');
    
    setState(() {
      token = fetchedToken;
      userId = fetchedUserId;
    });
    
    if (token != null && userId != null) {
      _teamsAndCodesCubit.loadBothData(userId!, token!);
    }
  }

  void _copyToClipboard(String code) {
    Clipboard.setData(ClipboardData(text: code));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context)!.codeCopied),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _teamsAndCodesCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.lightprimary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          AppLocalizations.of(context)!.teamManagement,
        ),
      ),
      body: Column(
        children: [
          // Spacing to move tabs away from app bar
          SizedBox(height: 20.h),
          // Custom Tab Bar like product management
          Padding(
            padding: REdgeInsets.symmetric(horizontal: 16),
            child: Container(
              height: 44.h,
              decoration: BoxDecoration(
                color: Colors.green[200],
                borderRadius: BorderRadius.circular(16.r),
              ),
              padding: EdgeInsets.all(4.w),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        _tabController.animateTo(0);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: _selectedTabIndex == 0 ? Colors.white : Colors.transparent,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.teamMembers,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            color: _selectedTabIndex == 0 ? Colors.green[700] : Colors.black87,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        _tabController.animateTo(1);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: _selectedTabIndex == 1 ? Colors.white : Colors.transparent,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.invitationCodes,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            color: _selectedTabIndex == 1 ? Colors.green[700] : Colors.black87,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16.h),
          // Tab Bar View with RefreshIndicator
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                if (token != null && userId != null) {
                  _teamsAndCodesCubit.loadBothData(userId!, token!);
                }
              },
              child: BlocListener<TeamsAndCodesCubit, TeamsAndCodesState>(
                bloc: _teamsAndCodesCubit,
                listener: (context, state) {
                  if (state is TeamsAndCodesError) {
                    CustomDialog.positiveButton(
                      context: context,
                      positiveText: AppLocalizations.of(context)!.ok,
                      title: AppLocalizations.of(context)!.error,
                      message: state.error.errorMessage ?? 'Error loading data',
                    );
                  }
                },
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Teams Tab
                    _buildTeamsTab(),
                    // Codes Tab
                    _buildCodesTab(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamsTab() {
    return BlocBuilder<TeamsAndCodesCubit, TeamsAndCodesState>(
      bloc: _teamsAndCodesCubit,
      builder: (context, state) {
        if (state is TeamsAndCodesLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is TeamsAndCodesError) {
          return Center(
            child: Padding(
              padding: REdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64.w, color: Colors.red),
                  SizedBox(height: 16.h),
                  Text(
                    state.error.errorMessage ?? 'Error loading team members',
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        
        if (state is TeamsAndCodesSuccess && state.teamMembers != null) {
          if (state.teamMembers!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.people_outline,
                    size: 64.w,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    AppLocalizations.of(context)!.noTeamMembersFound,
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }
          
          return ListView.builder(
            padding: REdgeInsets.all(16),
            itemCount: state.teamMembers!.length,
            itemBuilder: (context, index) {
              final member = state.teamMembers![index];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  side: BorderSide(
                    color: ColorManager.lightGrey,
                    width: 1.w,
                  ),

                ),
                color: ColorManager.white,
                margin: EdgeInsets.only(bottom: 12.h),
                child: Padding(
                  padding: REdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 24.r,
                            backgroundColor: ColorManager.lightprimary,
                            child: Text(
                              member.fullName?.substring(0, 1).toUpperCase() ?? 'U',
                              style: GoogleFonts.poppins(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  member.fullName ?? 'Unknown',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: ColorManager.darkGrey,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  member.code ?? 'Unknown',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: ColorManager.darkGrey,
                                  ),
                                ),
                                SizedBox(height: 4.h),

                                Text(
                                  member.email ?? '',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14.sp,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        children: [
                          SvgPicture.asset(
                              ImageAssets.assignedIcon,
                              width: 20.w, height: 20.h, color: ColorManager.lightprimary),

                          SizedBox(width: 20.w),
                          Text(
                            '${AppLocalizations.of(context)!.assignedProducts}: ${member.productsCount ?? 0} ',
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              color: ColorManager.lightprimary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
        
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildCodesTab() {
    return BlocBuilder<TeamsAndCodesCubit, TeamsAndCodesState>(
      bloc: _teamsAndCodesCubit,
      builder: (context, state) {
        if (state is TeamsAndCodesLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is TeamsAndCodesError) {
          return Center(
            child: Padding(
              padding: REdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64.w, color: Colors.red),
                  SizedBox(height: 16.h),
                  Text(
                    state.error.errorMessage ?? 'Error loading codes',
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        
        if (state is TeamsAndCodesSuccess && state.invitationCodes != null) {
          if (state.invitationCodes!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.qr_code_outlined,
                    size: 64.w,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    AppLocalizations.of(context)!.noCodeFound,
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }
          
          return ListView.builder(
            padding: REdgeInsets.all(16),
            itemCount: state.invitationCodes!.length,
            itemBuilder: (context, index) {
              final code = state.invitationCodes![index];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  side: BorderSide(
                    color: ColorManager.lightGrey,
                    width: 1.w,
                  ),

                ),
                color: ColorManager.white,
                margin: EdgeInsets.only(bottom: 12.h),
                child: Padding(
                  padding: REdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              code.inviteCode ?? '',
                              style: GoogleFonts.poppins(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: ColorManager.darkGrey,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Container(
                              padding: REdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: code.isUsed == true 
                                    ? Colors.red[100] 
                                    : Colors.green[100],
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Text(
                                code.isUsed == true 
                                    ? AppLocalizations.of(context)!.used
                                    : AppLocalizations.of(context)!.unused,
                                style: GoogleFonts.poppins(
                                  fontSize: 12.sp,
                                  color: code.isUsed == true 
                                      ? Colors.red[700] 
                                      : Colors.green[700],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => _copyToClipboard(code.inviteCode ?? ''),
                        icon: Icon(
                          Icons.copy,
                          color: ColorManager.lightprimary,
                        ),
                        tooltip: AppLocalizations.of(context)!.copyCode,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
        
        return const SizedBox.shrink();
      },
    );
  }
} 