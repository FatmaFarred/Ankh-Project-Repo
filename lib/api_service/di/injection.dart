// lib/core/injection.dart
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import '../../data/data_sources/edit_product_remote_data_source.dart';
import '../../domain/use_cases/edit_product_usecase.dart';
import '../../feauture/dashboard/products_management/edit_product_screen/edit_product_cubit.dart';

// Import your data sources, use cases, cubits here


final sl = GetIt.instance;

Future<void> init() async {
  // External
  sl.registerLazySingleton(() => Dio());

  // Data sources
  sl.registerLazySingleton<EditProductRemoteDataSource>(
        () => EditProductRemoteDataSourceImpl(sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => EditProductUseCase(sl()));

  // Cubits
  sl.registerFactory(() => EditProductCubit(sl()));
}
