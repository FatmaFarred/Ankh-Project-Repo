import 'package:ankh_project/api_service/di/di.config.dart';
import 'package:ankh_project/domain/repositries_and_data_sources/repositries/top_brand_repository.dart';
import 'package:ankh_project/domain/use_cases/delete_top_brand_use_case.dart';
import 'package:ankh_project/domain/use_cases/edit_top_brand_use_case.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';


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
}