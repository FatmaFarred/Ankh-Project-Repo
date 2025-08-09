import 'package:ankh_project/core/constants/assets_manager.dart';
import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/domain/entities/comment_entity.dart';
import 'package:ankh_project/feauture/details_screen/cubit/comment_states.dart';
import 'package:ankh_project/feauture/details_screen/cubit/comment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../l10n/app_localizations.dart';

class CommentListWidget extends StatefulWidget {
  final num productId;
  final CommentCubit commentCubit;

  const CommentListWidget({super.key, required this.productId, required this.commentCubit});

  @override
  State<CommentListWidget> createState() => _CommentListWidgetState();
}

class _CommentListWidgetState extends State<CommentListWidget> {
  bool _showAllComments = false;

  @override
  Widget build(BuildContext context) {
    print('🔍 CommentListWidget: Building with productId: ${widget.productId}');
    return BlocBuilder<CommentCubit, CommentState>(
      bloc: widget.commentCubit,
      builder: (context, state) {
        print('🔍 CommentListWidget: State changed to: ${state.runtimeType}');
        if (state is CommentLoading) {
          print('🔍 CommentListWidget: Showing loading state');
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is CommentError) {
          print('🔍 CommentListWidget: Showing error state: ${state.error.errorMessage}');
          return Center(
            child: Text(
              state.error.errorMessage ?? 'Error loading comments',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          );
        } else if (state is CommentEmpty) {
          print('🔍 CommentListWidget: Showing empty state');
          return Center(
            child: Text(
              'No comments yet',
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                color: ColorManager.hintColor,
              ),
            ),
          );
        } else if (state is CommentSuccess) {
          print('🔍 CommentListWidget: Showing success state with ${state.comments.length} comments');
          
          final commentsToShow = _showAllComments 
              ? state.comments 
              : state.comments.take(3).toList();
          
          return Column(
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: commentsToShow.length,
                separatorBuilder: (context, index) => SizedBox(height: 12.h),
                itemBuilder: (context, index) {
                  final comment = commentsToShow[index];
                  return _buildCommentCard(comment);
                },
              ),
              if (state.comments.length > 3)
                SizedBox(height: 16.h),
              if (state.comments.length > 3)
                Center(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _showAllComments = !_showAllComments;
                      });
                    },
                    child: Text(
                      _showAllComments 
                          ? 'Show Less' 
                          : 'View All (${state.comments.length})',
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: ColorManager.lightprimary,
                      ),
                    ),
                  ),
                ),
            ],
          );
        }
        print('🔍 CommentListWidget: Showing default state');
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildCommentCard(CommentEntity comment) {
    return Container(
      padding: REdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.09),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16.r,
                backgroundImage: const AssetImage(ImageAssets.appLogo),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comment.userName ?? 'Anonymous',
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: ColorManager.lightprimary,
                      ),
                    ),
                    Text(
                      _formatDate(comment.createdAt),
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        color: ColorManager.hintColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            comment.content ?? '',
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              color: const Color(0xFF404147),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return 'Unknown date';
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('dd/MM/yyyy HH:mm').format(date);
    } catch (e) {
      return 'Invalid date';
    }
  }
} 