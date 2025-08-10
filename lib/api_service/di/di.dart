import 'package:ankh_project/api_service/di/di.config.dart';
import 'package:ankh_project/domain/repositries_and_data_sources/repositries/top_brand_repository.dart';
import 'package:ankh_project/domain/use_cases/add_product_name_use_case.dart';
import 'package:ankh_project/domain/use_cases/delete_product_name_use_case.dart';
import 'package:ankh_project/domain/use_cases/delete_top_brand_use_case.dart';
import 'package:ankh_project/domain/use_cases/edit_top_brand_use_case.dart';
import 'package:ankh_project/feauture/dashboard/product_names_management/cubit/product_names_cubit.dart';
import 'package:ankh_project/feauture/dashboard/products_management/cubit/product_names_dropdown_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../../data/data_sources/product_name_remote_data_source_impl.dart';
import '../../data/repositries/product_name_repository_impl.dart';
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/product_name_remote_data_source.dart';
import '../../domain/repositries_and_data_sources/repositries/product_name_repository.dart';
import '../../domain/use_cases/get_product_names_use_case.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default

  asExtension: true, // default
)
void configureDependencies() {
  getIt.init();

  // Manually register the use cases that were causing issues
  if (!getIt.isRegistered<EditTopBrandUseCase>()) {
    getIt.registerLazySingleton<EditTopBrandUseCase>(
      () => EditTopBrandUseCase(getIt<TopBrandRepository>()),
    );
  }

  if (!getIt.isRegistered<DeleteTopBrandUseCase>()) {
    getIt.registerLazySingleton<DeleteTopBrandUseCase>(
      () => DeleteTopBrandUseCase(getIt<TopBrandRepository>()),
    );
  }

  // Register Product Names Management dependencies
  if (!getIt.isRegistered<http.Client>()) {
    getIt.registerLazySingleton<http.Client>(() => http.Client());
  }

  if (!getIt.isRegistered<ProductNameRemoteDataSource>()) {
    getIt.registerLazySingleton<ProductNameRemoteDataSource>(
      () => ProductNameRemoteDataSourceImpl(getIt<http.Client>()),
    );
  }

  if (!getIt.isRegistered<ProductNameRepository>()) {
    getIt.registerLazySingleton<ProductNameRepository>(
      () => ProductNameRepositoryImpl(getIt<ProductNameRemoteDataSource>()),
    );
  }

  if (!getIt.isRegistered<GetProductNamesUseCase>()) {
    getIt.registerLazySingleton<GetProductNamesUseCase>(
      () => GetProductNamesUseCase(getIt<ProductNameRepository>()),
    );
  }

  if (!getIt.isRegistered<AddProductNameUseCase>()) {
    getIt.registerLazySingleton<AddProductNameUseCase>(
      () => AddProductNameUseCase(getIt<ProductNameRepository>()),
    );
  }

  if (!getIt.isRegistered<DeleteProductNameUseCase>()) {
    getIt.registerLazySingleton<DeleteProductNameUseCase>(
      () => DeleteProductNameUseCase(getIt<ProductNameRepository>()),
    );
  }

  if (!getIt.isRegistered<ProductNamesCubit>()) {
    getIt.registerFactory<ProductNamesCubit>(
      () => ProductNamesCubit(
        getIt<GetProductNamesUseCase>(),
        getIt<AddProductNameUseCase>(),
        getIt<DeleteProductNameUseCase>(),
      ),
    );
  }
  
  // Register ProductNamesDropdownCubit for dropdown menus
  if (!getIt.isRegistered<ProductNamesDropdownCubit>()) {
    getIt.registerFactory<ProductNamesDropdownCubit>(
      () => ProductNamesDropdownCubit(
        getIt<GetProductNamesUseCase>(),
      ),
    );
  }
}