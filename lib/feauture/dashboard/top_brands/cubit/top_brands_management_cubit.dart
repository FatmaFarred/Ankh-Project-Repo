import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/top_brand_entity.dart';
import '../../../../domain/use_cases/add_top_brand_use_case.dart';
import '../../../../domain/use_cases/delete_top_brand_use_case.dart';
import '../../../../domain/use_cases/edit_top_brand_use_case.dart';
import '../../../../domain/use_cases/get_top_brands_use_case.dart';

part 'top_brands_management_state.dart';

@injectable
class TopBrandsManagementCubit extends Cubit<TopBrandsManagementState> {
  final GetTopBrandsUseCase getTopBrandsUseCase;
  final AddTopBrandUseCase addTopBrandUseCase;
  final EditTopBrandUseCase editTopBrandUseCase;
  final DeleteTopBrandUseCase deleteTopBrandUseCase;

  TopBrandsManagementCubit(
    this.getTopBrandsUseCase,
    this.addTopBrandUseCase,
    this.editTopBrandUseCase,
    this.deleteTopBrandUseCase,
  ) : super(TopBrandsManagementInitial());

  Future<void> getTopBrands() async {
    emit(TopBrandsManagementLoading());
    try {
      final brands = await getTopBrandsUseCase();
      emit(TopBrandsManagementLoaded(brands));
    } catch (e) {
      emit(TopBrandsManagementError('Failed to load brands: ${e.toString()}'));
    }
  }

  Future<void> addTopBrand({required String name, required File imageFile}) async {
    emit(TopBrandsManagementLoading());
    try {
      final success = await addTopBrandUseCase(name: name, imageFile: imageFile);
      if (success) {
        // Reload the brands list after successful addition
        await getTopBrands();
        emit(TopBrandAddSuccess());
      } else {
        emit(TopBrandsManagementError('Failed to add brand'));
      }
    } catch (e) {
      emit(TopBrandsManagementError('Failed to add brand: ${e.toString()}'));
    }
  }
  
  Future<void> editTopBrand({required int id, required String name, required File? imageFile}) async {
    emit(TopBrandsManagementLoading());
    try {
      final success = await editTopBrandUseCase(id: id, name: name, imageFile: imageFile);
      if (success) {
        // Reload the brands list after successful edit
        await getTopBrands();
        emit(TopBrandEditSuccess());
      } else {
        emit(TopBrandsManagementError('Failed to edit brand'));
      }
    } catch (e) {
      emit(TopBrandsManagementError('Failed to edit brand: ${e.toString()}'));
    }
  }
  
  Future<void> deleteTopBrand({required int id}) async {
    emit(TopBrandsManagementLoading());
    try {
      final success = await deleteTopBrandUseCase(id: id);
      if (success) {
        // Reload the brands list after successful deletion
        await getTopBrands();
        emit(TopBrandDeleteSuccess());
      } else {
        emit(TopBrandsManagementError('Failed to delete brand'));
      }
    } catch (e) {
      emit(TopBrandsManagementError('Failed to delete brand: ${e.toString()}'));
    }
  }
}