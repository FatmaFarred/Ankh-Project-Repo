import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import '../../data/data_sources/edit_product_remote_data_source.dart';
import '../../data/repositries/get_all_price_offer_repository_impl.dart';
import '../../domain/repositries_and_data_sources/repositries/get_all_price_offer_repository.dart';
import '../../domain/use_cases/edit_product_usecase.dart';
import '../../domain/use_cases/update_price_offer_status_usecase.dart';
import '../../feauture/dashboard/offers_management/cubit/price_offer_cubit.dart';
import '../../feauture/dashboard/products_management/edit_product_screen/edit_product_cubit.dart';

import '../../data/data_sources/price_offer_remote_data_source.dart';
import '../../domain/repositries_and_data_sources/repositries/price_offer_repository.dart';
import '../../domain/use_cases/get_pending_price_offers_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  sl.registerLazySingleton(() => Dio());

  // Data sources
  sl.registerLazySingleton<EditProductRemoteDataSource>(
        () => EditProductRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<PriceOfferRemoteDataSource>(
        () => PriceOfferRemoteDataSourceImpl(),
  );

  // Repositories
  sl.registerLazySingleton<PriceOfferRepository>(
        () => PriceOfferRepositoryImpl(sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => EditProductUseCase(sl()));
  sl.registerLazySingleton(() => GetPendingPriceOffersUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePriceOfferStatusUseCase(sl()));

  // Cubits
  sl.registerFactory(() => EditProductCubit(sl()));
  sl.registerFactory(() => PriceOfferCubit(
    sl<GetPendingPriceOffersUseCase>(),
    sl<UpdatePriceOfferStatusUseCase>(),
  ));
}
