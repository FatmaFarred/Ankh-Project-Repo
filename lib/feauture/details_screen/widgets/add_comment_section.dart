import 'package:ankh_project/core/constants/assets_manager.dart';
import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/l10n/app_localizations.dart';
import 'package:ankh_project/feauture/details_screen/cubit/comment_cubit.dart';
import 'package:ankh_project/feauture/details_screen/cubit/comment_states.dart';
import 'package:ankh_project/feauture/authentication/user_controller/user_cubit.dart';
import 'package:ankh_project/api_service/di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/customized_widgets/shared_preferences .dart';
import '../../../../core/customized_widgets/reusable_widgets/custom_dialog.dart';
import '../../welcome_screen/welcome_screen.dart';

class AddCommentSection extends StatefulWidget {
  final num productId;
  final CommentCubit commentCubit;
  
  const AddCommentSection({super.key, required this.productId, required this.commentCubit});

  @override
  State<AddCommentSection> createState() => _AddCommentSectionState();
}

class _AddCommentSectionState extends State<AddCommentSection> {
  final TextEditingController _commentController = TextEditingController();
  String? token;
  Future<void> _loadToken() async {
    final fetchedToken = await SharedPrefsManager.getData(key: 'user_token');
    setState(() {
      token = fetchedToken;
    });
    print("👤 User ID: $token");
  }
  void initState() {
    super.initState();

    _loadToken();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final commentCubit = widget.commentCubit;
    return BlocListener<CommentCubit, CommentState>(
      bloc: commentCubit,
      listener: (context, state) {
        if (state is AddCommentSuccess) {
          _commentController.clear();
          CustomDialog.positiveButton(
            context: context,
            positiveText: AppLocalizations.of(context)!.ok,
            title: AppLocalizations.of(context)!.success,
            message: state.response,
          );
        } else if (state is AddCommentError) {
          CustomDialog.positiveButton(
            context: context,
            positiveText: AppLocalizations.of(context)!.ok,
            title: AppLocalizations.of(context)!.error,
            message: state.error.errorMessage ?? 'Error adding comment',
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.09),
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundImage: AssetImage(ImageAssets.appLogo),
                  ),
                  SizedBox(width: 8.h),
                  Expanded(
                    child: TextField(
                      style:Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp,color: ColorManager.darkGrey),
                      controller: _commentController,

                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.addComment,
                        hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp,color: ColorManager.hintColor),
                        border: InputBorder.none,
                        isDense: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.h),
            Column(
              children: [
                                 BlocBuilder<CommentCubit, CommentState>(
                   bloc: commentCubit,
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: state is AddCommentLoading
                          ? null
                          : () {
                              final user = context.read<UserCubit>().state;
                              if (token == null) {
                                CustomDialog.positiveAndNegativeButton(
                                  context: context,
                                  positiveText: AppLocalizations.of(context)!.login,
                                  negativeText: AppLocalizations.of(context)!.cancel,
                                  negativeOnClick: () => Navigator.of(context).pop(),
                                  title: AppLocalizations.of(context)!.loginNow,
                                  message: AppLocalizations.of(context)!.reactDenied,
                                  positiveOnClick: ()=>Navigator.of(context).pushNamed(WelcomeScreen.welcomeScreenRouteName)
                                );
                                return;
                              }
                              
                              if (_commentController.text.trim().isEmpty) {
                                CustomDialog.positiveButton(
                                  context: context,
                                  positiveText: AppLocalizations.of(context)!.ok,
                                  title: AppLocalizations.of(context)!.error,
                                  message: AppLocalizations.of(context)!.addComment,
                                );
                                return;
                              }

                              commentCubit.addComment(
                                widget.productId,
                                token!,
                                _commentController.text.trim(),
                              );
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.lightprimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: state is AddCommentLoading
                          ? SizedBox(
                              width: 16.w,
                              height: 16.h,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(ColorManager.white),
                              ),
                            )
                          : Text(
                              AppLocalizations.of(context)!.post,
                              style: GoogleFonts.cairo(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w700,
                                color: ColorManager.white,
                              ),
                            ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
