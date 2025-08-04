import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/feauture/invite_team_member/cubit/invite_team_member_cubit.dart';
import 'package:ankh_project/feauture/invite_team_member/cubit/invite_team_member_states.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter/services.dart';

import '../../api_service/di/di.dart';
import '../../core/customized_widgets/reusable_widgets/custom_dialog.dart';
import '../../core/customized_widgets/shared_preferences .dart';
import '../../l10n/app_localizations.dart';

class InviteTeamMemberScreen extends StatefulWidget {
  static const String inviteTeamMemberRouteName = "inviteTeamMember";

  const InviteTeamMemberScreen({super.key});

  @override
  State<InviteTeamMemberScreen> createState() => _InviteTeamMemberScreenState();
}

class _InviteTeamMemberScreenState extends State<InviteTeamMemberScreen> {
  final TextEditingController _invitesNumberController = TextEditingController();
  final InviteTeamMemberCubit _inviteTeamMemberCubit = getIt<InviteTeamMemberCubit>();
  String? token;
  Future<void> _loadToken() async {
    final fetchedToken = await SharedPrefsManager.getData(key: 'user_token');
    setState(() {
      token = fetchedToken;
    });
    print("👤 User token: $token");
  }
  initState() {
    super.initState();
    _loadToken();
  }


  @override
  void dispose() {
    _invitesNumberController.dispose();
    super.dispose();
  }

  void _generateCodes() {
    final numberOfCodes = int.tryParse(_invitesNumberController.text);
    if (numberOfCodes == null || numberOfCodes <= 0) {
      CustomDialog.positiveButton(
        context: context,
        positiveText: AppLocalizations.of(context)!.ok,
        title: AppLocalizations.of(context)!.error,
        message: 'Please enter a valid number of invites',
      );
      return;
    }

    _inviteTeamMemberCubit.generateCodes(token??"", numberOfCodes);
  }

  void _copyToClipboard(String code) {
    Clipboard.setData(ClipboardData(text: code));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Link copied to clipboard'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
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
          AppLocalizations.of(context)!.inviteTeamMember,

        ),
      ),
      body: BlocListener<InviteTeamMemberCubit, InviteTeamMemberState>(
        bloc: _inviteTeamMemberCubit,
        listener: (context, state) {
          if (state is InviteTeamMemberError) {
            CustomDialog.positiveButton(
              context: context,
              positiveText: AppLocalizations.of(context)!.ok,
              title: AppLocalizations.of(context)!.error,
              message: state.error.errorMessage ?? 'Error generating codes',
            );
          }
        },
        child: SizedBox(
          height: 800.h,
          child: Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: ColorManager.lightGrey),
              borderRadius: BorderRadius.circular(12.r),
            ),
            color: Colors.white,
            elevation: 4,
            margin: REdgeInsets.all(16),
            child: Padding(
              padding: REdgeInsets.all(20),
              child: BlocBuilder<InviteTeamMemberCubit, InviteTeamMemberState>(
                bloc: _inviteTeamMemberCubit,
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Fixed section with text field and button
                      Text(
                        AppLocalizations.of(context)!.invitesNumber,
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: ColorManager.lightprimary,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      TextField(
                        controller: _invitesNumberController,
                        keyboardType: TextInputType.number,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp,color: ColorManager.darkGrey),
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.enterCodeInvitationCount,
                          hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp,color: ColorManager.darkGrey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          contentPadding: REdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: state is InviteTeamMemberLoading ? null : _generateCodes,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorManager.lightprimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            padding: REdgeInsets.symmetric(vertical: 12),
                          ),
                          icon: state is InviteTeamMemberLoading
                              ? SizedBox(
                                  width: 16.w,
                                  height: 16.h,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                )
                              : const Icon(Icons.refresh, color: Colors.white),
                          label: Text(
                            state is InviteTeamMemberLoading
                                ? AppLocalizations.of(context)!.generating
                                : AppLocalizations.of(context)!.generateLink,
                            style: GoogleFonts.poppins(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),

                      // Scrollable section for generated codes and information
                      if (state is InviteTeamMemberSuccess) ...[
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(AppLocalizations.of(context)!.yourInvitesAreReady,
                                   style: GoogleFonts.poppins(
                                     fontSize: 18.sp,
                                     fontWeight: FontWeight.w700,
                                     color: ColorManager.lightprimary,
                                   ),
                                 ),
                                 SizedBox(height: 8.h),
                                 Text(
                                   AppLocalizations.of(context)!.shareTheseLinksToInvite,
                                   style: GoogleFonts.poppins(
                                     fontSize: 14.sp,
                                     color: Colors.grey[600],
                                   ),
                                 ),
                                SizedBox(height: 16.h),
                                // Generated Links
                                ...state.generatedCodes.map((code) => Container(
                                  margin: EdgeInsets.only(bottom: 12.h),
                                  padding: REdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          code,
                                          style: GoogleFonts.poppins(
                                            fontSize: 14.sp,
                                            color: Colors.grey[800],
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      SizedBox(width: 12.w),
                                      IconButton(
                                        onPressed: () => _copyToClipboard(code),
                                        icon: Icon(Icons.copy, color: ColorManager.lightprimary),
                                      ),
                                    ],
                                  ),
                                )).toList(),
                                SizedBox(height: 16.h),

                                // Information Boxes
                                Container(
                                  padding: REdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.amber[50],
                                    borderRadius: BorderRadius.circular(12.r),
                                    border: Border.all(color: Colors.amber[200]!),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.warning_amber, color: Colors.amber[700]),
                                      SizedBox(width: 12.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!.singleUseLink,
                                              style: GoogleFonts.poppins(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.amber[800],
                                              ),
                                            ),
                                            SizedBox(height: 4.h),
                                            Text(
                                              AppLocalizations.of(context)!.linkWillBeInvalidated,
                                              style: GoogleFonts.poppins(
                                                fontSize: 12.sp,
                                                color: Colors.amber[700],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 12.h),
                                Container(
                                  padding: REdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.amber[50],
                                    borderRadius: BorderRadius.circular(12.r),
                                    border: Border.all(color: Colors.amber[200]!),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.access_time, color: Colors.amber[700]),
                                      SizedBox(width: 12.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(AppLocalizations.of(context)!.expiresSoon,
                                               style: GoogleFonts.poppins(
                                                 fontSize: 14.sp,
                                                 fontWeight: FontWeight.w600,
                                                 color: Colors.amber[800],
                                               ),
                                             ),
                                             SizedBox(height: 4.h),
                                             Text(
                                               AppLocalizations.of(context)!.linkValidFor24Hours,
                                               style: GoogleFonts.poppins(
                                                 fontSize: 12.sp,
                                                 color: Colors.amber[700],
                                               ),
                                             ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
} 