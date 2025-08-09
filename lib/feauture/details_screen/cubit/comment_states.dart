import 'package:ankh_project/api_service/failure/error_handling.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/comment_entity.dart';

abstract class CommentState extends Equatable {
  const CommentState();

  @override
  List<Object?> get props => [];
}

class CommentInitial extends CommentState {
  const CommentInitial();
}

class CommentLoading extends CommentState {
  const CommentLoading();
}

class CommentSuccess extends CommentState {
  final List<CommentEntity> comments;
  final String? message;

  const CommentSuccess({required this.comments, this.message});

  @override
  List<Object?> get props => [comments, message];
}

class CommentEmpty extends CommentState {
  final String? message;

  const CommentEmpty({this.message});

  @override
  List<Object?> get props => [message];
}

class CommentError extends CommentState {
  final Failure error;

  const CommentError({required this.error});

  @override
  List<Object?> get props => [error];
}

// States for add comment actions
class AddCommentLoading extends CommentState {
  const AddCommentLoading();
}

class AddCommentSuccess extends CommentState {
  final String? response;

  const AddCommentSuccess({this.response});

  @override
  List<Object?> get props => [response];
}

class AddCommentError extends CommentState {
  final Failure error;

  const AddCommentError({required this.error});

  @override
  List<Object?> get props => [error];
} 