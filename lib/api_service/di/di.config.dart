// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/data_sources/authentication/authentication_remote_data_sourse_impl_with_api.dart'
    as _i758;
import '../../data/data_sources/forget_reset_password_remote_data_sourse/forget_reset_password_remote_data_Sourse_impl.dart'
    as _i767;
import '../../data/data_sources/push_notification_data_source_/push_notification_data_sorce_impl.dart'
    as _i71;
import '../../data/repositries/authentication/authentication%20_repo_impl.dart'
    as _i972;
import '../../data/repositries/forget_password_repositry_impl.dart' as _i423;
import '../../data/repositries/push_notification_repositry/push_notification_repositry_impl.dart'
    as _i672;
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/authentication.dart'
    as _i430;
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/forget_reset_password_remote_data_sourse.dart'
    as _i822;
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/push_notification_data_sourse.dart'
    as _i667;
import '../../domain/repositries_and_data_sources/repositries/authentication_repositry.dart'
    as _i817;
import '../../domain/repositries_and_data_sources/repositries/forget_reset_password_repositry.dart'
    as _i255;
import '../../domain/repositries_and_data_sources/repositries/push%20_notification_%20repositry.dart'
    as _i1072;
import '../../domain/use_cases/authentication/register_usecase.dart' as _i456;
import '../../domain/use_cases/authentication/signin_usecase.dart' as _i96;
import '../../domain/use_cases/forget_reset_password_usecse/forget_password_usecase.dart'
    as _i458;
import '../../domain/use_cases/push_notification_use_case/push_notification_use_case.dart'
    as _i172;
import '../../feauture/authentication/forgrt_password/forget_password/controller/forget_passwors_cubit.dart'
    as _i155;
import '../../feauture/authentication/register/controller/register_cubit.dart'
    as _i257;
import '../../feauture/authentication/signin/controller/sigin_cubit.dart'
    as _i938;
import '../../feauture/push_notification/push_notification_controller/push_notification_cubit.dart'
    as _i901;
import '../../firebase_service/firestore_service/firestore_service.dart'
    as _i664;
import '../../firebase_service/notification_service/local%20notification.dart'
    as _i470;
import '../../firebase_service/notification_service/push%20notification_manager.dart'
    as _i329;
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
    gh.factory<_i329.FirebaseMessagingService>(
        () => _i329.FirebaseMessagingService());
    gh.singleton<_i1069.ApiManager>(() => _i1069.ApiManager());
    gh.singleton<_i664.FireBaseUtilies>(() => _i664.FireBaseUtilies());
    gh.singleton<_i470.LocalNotification>(() => _i470.LocalNotification());
    gh.factory<_i822.ForgrtPasswordRemoteDataSource>(() =>
        _i767.ForgetResetPasswordRemoteDataSourseImpl(gh<_i1069.ApiManager>()));
    gh.factory<_i430.AuthenticationRemoteDataSource>(() =>
        _i758.AuthenticationRemoteDataSourceImplWithApi(
            gh<_i1069.ApiManager>()));
    gh.factory<_i667.PushNotificationDataSourse>(() =>
        _i71.PushNotificationDataSourseImpl(
            gh<_i329.FirebaseMessagingService>()));
    gh.factory<_i817.AuthenticationRepositry>(() =>
        _i972.AuthenticationRepositryImpl(
            gh<_i430.AuthenticationRemoteDataSource>()));
    gh.factory<_i456.RegisterUseCase>(
        () => _i456.RegisterUseCase(gh<_i817.AuthenticationRepositry>()));
    gh.factory<_i96.SignInUseCase>(
        () => _i96.SignInUseCase(gh<_i817.AuthenticationRepositry>()));
    gh.factory<_i255.ForgetPasswordRepositry>(() =>
        _i423.ForgrtPasswordRepositryImpl(
            gh<_i822.ForgrtPasswordRemoteDataSource>()));
    gh.factory<_i1072.PushNotificationRepositry>(() =>
        _i672.PushNotificationRepositryImpl(
            gh<_i667.PushNotificationDataSourse>()));
    gh.factory<_i257.RegisterCubit>(
        () => _i257.RegisterCubit(gh<_i456.RegisterUseCase>()));
    gh.factory<_i938.SignInCubit>(
        () => _i938.SignInCubit(gh<_i96.SignInUseCase>()));
    gh.factory<_i458.ForgetPasswordUseCase>(
        () => _i458.ForgetPasswordUseCase(gh<_i255.ForgetPasswordRepositry>()));
    gh.factory<_i172.PushNotificationUseCase>(() =>
        _i172.PushNotificationUseCase(gh<_i1072.PushNotificationRepositry>()));
    gh.factory<_i155.ForgetPassworsCubit>(
        () => _i155.ForgetPassworsCubit(gh<_i458.ForgetPasswordUseCase>()));
    gh.factory<_i901.PushNotificationCubit>(
        () => _i901.PushNotificationCubit(gh<_i172.PushNotificationUseCase>()));
    return this;
  }
}
