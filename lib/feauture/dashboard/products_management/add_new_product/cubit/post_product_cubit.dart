import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart'; // ✅ ADD THIS

import '../../../../../domain/entities/product_post_entity.dart';
import '../../../../../domain/use_cases/post_product_usecase.dart';

part 'post_product_state.dart';

@injectable // ✅ ADD THIS
class PostProductCubit extends Cubit<PostProductState> {
  final PostProductUseCase postProductUseCase;

  PostProductCubit(this.postProductUseCase) : super(PostProductInitial());

  Future<void> postProduct(ProductPostEntity entity) async {
    emit(PostProductLoading());
    try {
      await postProductUseCase(entity);
      emit(PostProductSuccess());
    } catch (e) {
      emit(PostProductError(e.toString())); // This will carry server errors too
    }
  }
}
