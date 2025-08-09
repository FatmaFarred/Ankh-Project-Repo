import 'dart:io';

import 'package:ankh_project/domain/entities/all_users_entity.dart';
import 'package:ankh_project/domain/entities/product_details_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../api_service/failure/error_handling.dart';
import '../../../entities/comment_entity.dart';


abstract class ClientRemoteDataSource {
  Future <Either<Failure,List<AllUsersEntity>>> getAllUsers();
  Future <Either<Failure,List<ProductDetailsEntity>>> getUserFavourite( String userId );
  Future <Either<Failure,List<AllUsersEntity>>> searchUsers(String keyword);
  Future <Either<Failure,String?>> addFavourite( String userId , num productId );
  Future <Either<Failure,String?>> removeFavourite( String userId , num productId );
  Future <Either<Failure,List<CommentEntity>>> getComment(num productId);
  Future <Either<Failure,String?>> addComment(num productId, String token, String comment);



}
