part of 'top_brands_management_cubit.dart';

abstract class TopBrandsManagementState {}

class TopBrandsManagementInitial extends TopBrandsManagementState {}

class TopBrandsManagementLoading extends TopBrandsManagementState {}

class TopBrandsManagementLoaded extends TopBrandsManagementState {
  final List<TopBrandEntity> brands;

  TopBrandsManagementLoaded(this.brands);
}

class TopBrandsManagementError extends TopBrandsManagementState {
  final String message;

  TopBrandsManagementError(this.message);
}

class TopBrandAddSuccess extends TopBrandsManagementState {}

class TopBrandEditSuccess extends TopBrandsManagementState {}

class TopBrandDeleteSuccess extends TopBrandsManagementState {}