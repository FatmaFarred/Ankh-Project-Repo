import 'package:ankh_project/api_service/di/di.dart';
import 'package:ankh_project/data/data_sources/products_by_brand_remote_data_source_impl.dart';
import 'package:ankh_project/data/repositries/products_by_brand_repository_impl.dart';
import 'package:ankh_project/domain/repositries_and_data_sources/data_sources/remote_data_source/products_by_brand_remote_data_source.dart';
import 'package:ankh_project/domain/repositries_and_data_sources/repositries/products_by_brand_repository.dart';
import 'package:ankh_project/domain/use_cases/get_products_by_brand_use_case.dart';
import 'package:ankh_project/feauture/home_screen/top_brands/cubit/products_by_brand_cubit.dart';

/// Register the ProductsByBrand dependencies manually
/// Call this function in main.dart after configureDependencies()
void registerProductsByBrandDependencies() {
  // Register the remote data source if not already registered
  if (!getIt.isRegistered<ProductsByBrandRemoteDataSource>()) {
    getIt.registerLazySingleton<ProductsByBrandRemoteDataSource>(
      () => ProductsByBrandRemoteDataSourceImpl(getIt()),
    );
  }

  // Register the repository if not already registered
  if (!getIt.isRegistered<ProductsByBrandRepository>()) {
    getIt.registerLazySingleton<ProductsByBrandRepository>(
      () => ProductsByBrandRepositoryImpl(getIt<ProductsByBrandRemoteDataSource>()),
    );
  }

  // Register the use case if not already registered
  if (!getIt.isRegistered<GetProductsByBrandUseCase>()) {
    getIt.registerLazySingleton<GetProductsByBrandUseCase>(
      () => GetProductsByBrandUseCase(getIt<ProductsByBrandRepository>()),
    );
  }

  // Register the cubit if not already registered
  if (!getIt.isRegistered<ProductsByBrandCubit>()) {
    getIt.registerFactory<ProductsByBrandCubit>(
      () => ProductsByBrandCubit(getIt<GetProductsByBrandUseCase>()),
    );
  }
}