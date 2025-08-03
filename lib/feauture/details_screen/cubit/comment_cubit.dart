import 'package:ankh_project/domain/use_cases/add_comment_use_case.dart';
import 'package:ankh_project/domain/use_cases/get_comment_use_case.dart';
import 'package:ankh_project/feauture/details_screen/cubit/comment_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../api_service/failure/error_handling.dart';
import '../../../l10n/app_localizations.dart';

@injectable
class CommentCubit extends Cubit<CommentState> {
  final GetCommentUseCase getCommentUseCase;
  final AddCommentUseCase addCommentUseCase;

  CommentCubit({
    required this.getCommentUseCase,
    required this.addCommentUseCase,
  }) : super(CommentInitial()) {
    print('🔍 CommentCubit: Constructor called');
  }

  Future<void> fetchComments(num productId) async {
    print('🔍 CommentCubit: fetchComments called with productId: $productId');
    emit(CommentLoading());
    var either = await getCommentUseCase.execute(productId);
    print('🔍 CommentCubit: API response received');
    either.fold((error) {
      print('❌ CommentCubit: Error fetching comments: ${error.errorMessage}');
      emit(CommentError(error: error));
    }, (response) {
      print('✅ CommentCubit: Comments fetched successfully. Count: ${response.length}');
      if (response.isEmpty) {
        emit(CommentEmpty(message: 'No comments found'));
      } else {
        emit(CommentSuccess(comments: response, message: 'Comments loaded successfully'));
      }
    });
  }

  Future<void> addComment(num productId, String token, String comment) async {
    print('🔍 CommentCubit: addComment called');
    emit(AddCommentLoading());
    var either = await addCommentUseCase.execute(productId, token, comment);
    either.fold((error) {
      print('❌ CommentCubit: Error adding comment: ${error.errorMessage}');
      emit(AddCommentError(error: error));
    }, (response) {
      print('✅ CommentCubit: Comment added successfully');
      emit(AddCommentSuccess(response: response));
      // Refresh comments after adding
      fetchComments(productId);
    });
  }
} 