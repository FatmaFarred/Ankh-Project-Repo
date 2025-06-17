// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/data_sources/authentication/authentication_remote_data_source_impl.dart'
    as _i699;
import '../../data/repositries/authentication/authentication%20_repo_impl.dart'
    as _i972;
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/authentication.dart'
    as _i430;
import '../../domain/repositries_and_data_sources/repositries/authentication_repositry.dart'
    as _i817;
import '../../domain/use_cases/authentication/register_usecase.dart' as _i456;
import '../../feauture/authentication/register/controller/register_cubit.dart'
    as _i257;
import '../../firebase_service/firestore_service/firestore_service.dart'
    as _i664;
import '../api_manager.dart' as _i1069;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i1069.ApiManager>(() => _i1069.ApiManager());
    gh.singleton<_i664.FireBaseUtilies>(() => _i664.FireBaseUtilies());
    gh.factory<_i430.RegisterRemoteDataSource>(
        () => _i699.RegisterRemoteDataSourceImpl());
    gh.factory<_i817.RegisterRepositry>(() =>
        _i972.RegisterRepositryImpl(gh<_i430.RegisterRemoteDataSource>()));
    gh.factory<_i456.RegisterUseCase>(
        () => _i456.RegisterUseCase(gh<_i817.RegisterRepositry>()));
    gh.factory<_i257.RegisterCubit>(
        () => _i257.RegisterCubit(gh<_i456.RegisterUseCase>()));
    return this;
  }
}
