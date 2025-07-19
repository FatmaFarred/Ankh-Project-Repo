// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/data_sources/all_products_remote_data_source.dart' as _i682;
import '../../data/data_sources/authentication/authentication_remote_data_sourse_impl_with_api.dart'
    as _i758;
import '../../data/data_sources/cs_roles_remote_data_source_impl.dart'
    as _i1067;
import '../../data/data_sources/forget_reset_password_remote_data_sourse/forget_reset_password_remote_data_Sourse_impl.dart'
    as _i767;
import '../../data/data_sources/forget_reset_password_remote_data_sourse/reset_password_data_sourse_impl.dart'
    as _i1065;
import '../../data/data_sources/home_get_all_products_remote_data_source.dart'
    as _i105;
import '../../data/data_sources/inspector%20_home_get_all_remote_data_source_impl.dart'
    as _i98;
import '../../data/data_sources/marketer_add_request_remote_data_source_impl.dart'
    as _i0;
import '../../data/data_sources/marketer_assign%20_get_products_remote_data_source_impl.dart'
    as _i407;
import '../../data/data_sources/marketer_requsts_for_inspection_remote_data_source_impl.dart'
    as _i976;
import '../../data/data_sources/product_details_remote_data_source_impl.dart'
    as _i500;
import '../../data/data_sources/push_notification_data_source_/push_notification_data_sorce_impl.dart'
    as _i71;
import '../../data/repositries/all_products_repository_impl.dart' as _i799;
import '../../data/repositries/authentication/authentication%20_repo_impl.dart'
    as _i972;
import '../../data/repositries/cs_roles_repositry_impl.dart' as _i551;
import '../../data/repositries/forget_password_repositry_impl.dart' as _i423;
import '../../data/repositries/home_get_all_products_repositry_impl.dart'
    as _i212;
import '../../data/repositries/inspector%20_home_get_all_repositry_impl.dart'
    as _i868;
import '../../data/repositries/marketer_add_request_repositry_impl.dart'
    as _i105;
import '../../data/repositries/marketer_assign%20_get_products_repositry_impl.dart'
    as _i894;
import '../../data/repositries/marketer_requsts_for_inspection_repositry_impl.dart'
    as _i942;
import '../../data/repositries/product_details_repositry_impl.dart' as _i288;
import '../../data/repositries/push_notification_repositry/push_notification_repositry_impl.dart'
    as _i672;
import '../../data/repositries/reset_passwors_repositry_impl.dart' as _i584;
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/all_products_remote_data_source.dart'
    as _i0;
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/authentication.dart'
    as _i430;
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/cs_roles_remote_data_source.dart'
    as _i460;
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/forget_reset_password_remote_data_sourse.dart'
    as _i822;
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/home_get_all_products_remote_data_source.dart'
    as _i1054;
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/inspector%20_home_get_all_remote_data_source.dart'
    as _i77;
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/marketer_add_request_inspection%20_data_source.dart'
    as _i583;
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/marketer_assign%20_get_products_remote_data_source.dart'
    as _i686;
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/marketer_requsts_for_inspection_remote_data_sourse.dart'
    as _i44;
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/product_details_remote_data_Source.dart'
    as _i526;
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/push_notification_data_sourse.dart'
    as _i667;
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/reset_password_remote_data_sourse.dart'
    as _i223;
import '../../domain/repositries_and_data_sources/repositries/all_products_repository.dart'
    as _i629;
import '../../domain/repositries_and_data_sources/repositries/authentication_repositry.dart'
    as _i817;
import '../../domain/repositries_and_data_sources/repositries/cs_roles_repositry.dart'
    as _i203;
import '../../domain/repositries_and_data_sources/repositries/forget_reset_password_repositry.dart'
    as _i255;
import '../../domain/repositries_and_data_sources/repositries/home_get_all_products_repositry.dart'
    as _i77;
import '../../domain/repositries_and_data_sources/repositries/inspector%20_home_get_all_repositry.dart'
    as _i700;
import '../../domain/repositries_and_data_sources/repositries/marketer_add_request_inspection.dart'
    as _i233;
import '../../domain/repositries_and_data_sources/repositries/marketer_assign%20_get_products_repositry.dart'
    as _i863;
import '../../domain/repositries_and_data_sources/repositries/marketer_requsts_for_inspection_repositry.dart'
    as _i1072;
import '../../domain/repositries_and_data_sources/repositries/product_details_repositry.dart'
    as _i404;
import '../../domain/repositries_and_data_sources/repositries/push%20_notification_%20repositry.dart'
    as _i1072;
import '../../domain/repositries_and_data_sources/repositries/reset_password_repositry.dart'
    as _i234;
import '../../domain/use_cases/authentication/register_usecase.dart' as _i456;
import '../../domain/use_cases/authentication/signin_usecase.dart' as _i96;
import '../../domain/use_cases/cs_roles_usecase.dart' as _i941;
import '../../domain/use_cases/forget_reset_password_usecse/forget_password_usecase.dart'
    as _i458;
import '../../domain/use_cases/forget_reset_password_usecse/reset_password_use_case.dart'
    as _i416;
import '../../domain/use_cases/get_all_products_use_case.dart' as _i939;
import '../../domain/use_cases/home_get_all_products_use_case.dart' as _i873;
import '../../domain/use_cases/inspection_home_search_use_case.dart' as _i826;
import '../../domain/use_cases/inspector_assign_inspection_use_case.dart'
    as _i119;
import '../../domain/use_cases/inspector_get_all_inspection_use_case.dart'
    as _i868;
import '../../domain/use_cases/marketer_add_request_inspection_usecase.dart'
    as _i176;
import '../../domain/use_cases/marketer_assign_product_use_case.dart' as _i674;
import '../../domain/use_cases/marketer_products_use_case.dart' as _i527;
import '../../domain/use_cases/marketer_request_inspection_details_usecase.dart'
    as _i805;
import '../../domain/use_cases/marketer_requsts_for_inspection_usecase.dart'
    as _i749;
import '../../domain/use_cases/marketer_serach_home_usecase.dart' as _i43;
import '../../domain/use_cases/product_details_use_case.dart' as _i385;
import '../../domain/use_cases/push_notification_use_case/push_notification_use_case.dart'
    as _i172;
import '../../feauture/authentication/forgrt_password/forget_password/controller/forget_passwors_cubit.dart'
    as _i155;
import '../../feauture/authentication/forgrt_password/set_new_password/controller/reset_password_cubit.dart'
    as _i809;
import '../../feauture/authentication/register/controller/register_cubit.dart'
    as _i257;
import '../../feauture/authentication/signin/controller/sigin_cubit.dart'
    as _i938;
import '../../feauture/authentication/user_controller/user_cubit.dart' as _i354;
import '../../feauture/choose_cs_role/choose_cs_role_cubit/choose_cs_role_cubit.dart'
    as _i495;
import '../../feauture/client_search_screen/cubit/search_cubit.dart' as _i355;
import '../../feauture/details_screen/controller/product_details_cubit.dart'
    as _i447;
import '../../feauture/inspector_screen/inspector_home/assign_inspection_controller/marketer_product_cubit.dart'
    as _i1049;
import '../../feauture/inspector_screen/inspector_home/controller/inspector_home_cubit.dart'
    as _i635;
import '../../feauture/marketer_home/assign_product_controller/marketer_product_cubit.dart'
    as _i300;
import '../../feauture/marketer_home/controller/marketer_home_product_cubit.dart'
    as _i158;
import '../../feauture/marketer_products/get_product_controller/marketer_product_cubit.dart'
    as _i954;
import '../../feauture/myrequest/controller/cubit.dart' as _i789;
import '../../feauture/myrequest/my_request_details/details_controller/details_request_cubit.dart'
    as _i214;
import '../../feauture/push_notification/push_notification_controller/push_notification_cubit.dart'
    as _i901;
import '../../feauture/request_inspection_screen/cubit/marketer_add_request_cubit.dart'
    as _i280;
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
    gh.singleton<_i354.UserCubit>(() => _i354.UserCubit());
    gh.factory<_i686.MarketerAssignGetProductsRemoteDataSource>(() =>
        _i407.MarketerAssignGetProductsRemoteDataSourceImpl(
            gh<_i1069.ApiManager>()));
    gh.lazySingleton<_i0.AllProductsRemoteDataSource>(
        () => _i682.AllProductsRemoteDataSourceImpl(gh<_i1069.ApiManager>()));
    gh.factory<_i863.MarketerAssignGetProductsRepositry>(() =>
        _i894.MarketerAssignGetProductsRepositryImpl(
            gh<_i686.MarketerAssignGetProductsRemoteDataSource>()));
    gh.factory<_i460.CsRolesRemoteDataSource>(
        () => _i1067.CsRolesRemoteDataSourceImpl(gh<_i1069.ApiManager>()));
    gh.factory<_i822.ForgrtPasswordRemoteDataSource>(() =>
        _i767.ForgetResetPasswordRemoteDataSourseImpl(gh<_i1069.ApiManager>()));
    gh.factory<_i430.AuthenticationRemoteDataSource>(() =>
        _i758.AuthenticationRemoteDataSourceImplWithApi(
            gh<_i1069.ApiManager>()));
    gh.factory<_i583.MarketerAddRequestInspectionRemoteDataSource>(() =>
        _i0.MarketerAddRequestInspectionRemoteDataSourseImpl(
            apiManager: gh<_i1069.ApiManager>()));
    gh.factory<_i223.ResetPasswordRemoteDataSourse>(
        () => _i1065.ResetPasswordDataSourceImpl(gh<_i1069.ApiManager>()));
    gh.lazySingleton<_i629.AllProductsRepository>(() =>
        _i799.AllProductsRepositoryImpl(gh<_i0.AllProductsRemoteDataSource>()));
    gh.factory<_i44.MarketerRequestsForInspectionRemoteDataSource>(() =>
        _i976.MarkertRequestsForInspectionRemoteDataSourceImpl(
            gh<_i1069.ApiManager>()));
    gh.factory<_i1054.HomeGetAllProductsRemoteDataSource>(() =>
        _i105.HomeGetAllProductsRemoteDataSourceImpl(gh<_i1069.ApiManager>()));
    gh.factory<_i77.HomeGetAllInspectionRemoteDataSource>(() =>
        _i98.HomeGetAllInspectionRemoteDataSourceImpl(gh<_i1069.ApiManager>()));
    gh.factory<_i526.ProductDetailsRemoteDataSource>(() =>
        _i500.ProductDetailsRemoteDataSourceImpl(gh<_i1069.ApiManager>()));
    gh.factory<_i939.GetAllProductsUseCase>(
        () => _i939.GetAllProductsUseCase(gh<_i629.AllProductsRepository>()));
    gh.factory<_i233.MarketerAddRequestInspectionRepositry>(() =>
        _i105.MarketerAddRequestInspectionRepositryImpl(
            marketerAddRequestInspectionRemoteDataSource:
                gh<_i583.MarketerAddRequestInspectionRemoteDataSource>()));
    gh.factory<_i527.MarketerProductsUseCase>(() =>
        _i527.MarketerProductsUseCase(
            gh<_i863.MarketerAssignGetProductsRepositry>()));
    gh.factory<_i674.MarketerAssignProductUseCase>(() =>
        _i674.MarketerAssignProductUseCase(
            gh<_i863.MarketerAssignGetProductsRepositry>()));
    gh.factory<_i667.PushNotificationDataSourse>(() =>
        _i71.PushNotificationDataSourseImpl(
            gh<_i329.FirebaseMessagingService>()));
    gh.factory<_i817.AuthenticationRepositry>(() =>
        _i972.AuthenticationRepositryImpl(
            gh<_i430.AuthenticationRemoteDataSource>()));
    gh.factory<_i700.HomeGetAllInspectionRepositry>(() =>
        _i868.HomeGetAllInspectionRepositryImpl(
            gh<_i77.HomeGetAllInspectionRemoteDataSource>()));
    gh.factory<_i355.AllProductsSearchCubit>(
        () => _i355.AllProductsSearchCubit(gh<_i939.GetAllProductsUseCase>()));
    gh.factory<_i203.CsRolesRepositry>(
        () => _i551.CsRolesRepositryImpl(gh<_i460.CsRolesRemoteDataSource>()));
    gh.factory<_i234.ResetPasswordRepositry>(() =>
        _i584.ResetPasswordsRepositryImpl(
            gh<_i223.ResetPasswordRemoteDataSourse>()));
    gh.factory<_i1072.MarketerRequestsForInspectionRepositry>(() =>
        _i942.MarketerRequestsForInspectionRepositryImpl(
            gh<_i44.MarketerRequestsForInspectionRemoteDataSource>()));
    gh.factory<_i805.MarketerRequestsInspectionDetailsUseCase>(() =>
        _i805.MarketerRequestsInspectionDetailsUseCase(
            gh<_i1072.MarketerRequestsForInspectionRepositry>()));
    gh.factory<_i749.MarketerRequestsForInspectionUseCase>(() =>
        _i749.MarketerRequestsForInspectionUseCase(
            gh<_i1072.MarketerRequestsForInspectionRepositry>()));
    gh.factory<_i300.MarketerAssignProductCubit>(() =>
        _i300.MarketerAssignProductCubit(
            gh<_i674.MarketerAssignProductUseCase>()));
    gh.factory<_i404.ProductDetailsRepositry>(() =>
        _i288.ProductDetailsRepositryImpl(
            gh<_i526.ProductDetailsRemoteDataSource>()));
    gh.factory<_i456.RegisterUseCase>(
        () => _i456.RegisterUseCase(gh<_i817.AuthenticationRepositry>()));
    gh.factory<_i96.SignInUseCase>(
        () => _i96.SignInUseCase(gh<_i817.AuthenticationRepositry>()));
    gh.factory<_i954.MarketerProductCubit>(
        () => _i954.MarketerProductCubit(gh<_i527.MarketerProductsUseCase>()));
    gh.factory<_i789.MarketerRequestCubit>(() => _i789.MarketerRequestCubit(
        gh<_i749.MarketerRequestsForInspectionUseCase>()));
    gh.factory<_i176.MarketerAddRequestInspectionUseCase>(() =>
        _i176.MarketerAddRequestInspectionUseCase(
            gh<_i233.MarketerAddRequestInspectionRepositry>()));
    gh.factory<_i255.ForgetPasswordRepositry>(() =>
        _i423.ForgrtPasswordRepositryImpl(
            gh<_i822.ForgrtPasswordRemoteDataSource>()));
    gh.factory<_i385.ProductDetailsUseCase>(
        () => _i385.ProductDetailsUseCase(gh<_i404.ProductDetailsRepositry>()));
    gh.factory<_i280.MarketerAddRequestCubit>(() =>
        _i280.MarketerAddRequestCubit(
            gh<_i176.MarketerAddRequestInspectionUseCase>()));
    gh.factory<_i826.InspectorHomeSearchUseCase>(() =>
        _i826.InspectorHomeSearchUseCase(
            gh<_i700.HomeGetAllInspectionRepositry>()));
    gh.factory<_i119.InspectorAssignInspectionUseCase>(() =>
        _i119.InspectorAssignInspectionUseCase(
            gh<_i700.HomeGetAllInspectionRepositry>()));
    gh.factory<_i868.InspectorHomeGetAllInspectionUseCase>(() =>
        _i868.InspectorHomeGetAllInspectionUseCase(
            gh<_i700.HomeGetAllInspectionRepositry>()));
    gh.factory<_i77.HomeGetAllProductsRepositry>(() =>
        _i212.HomeGetAllProductsRepositryImpl(
            gh<_i1054.HomeGetAllProductsRemoteDataSource>()));
    gh.factory<_i1072.PushNotificationRepositry>(() =>
        _i672.PushNotificationRepositryImpl(
            gh<_i667.PushNotificationDataSourse>()));
    gh.factory<_i635.InspectorHomeProductCubit>(
        () => _i635.InspectorHomeProductCubit(
              gh<_i868.InspectorHomeGetAllInspectionUseCase>(),
              gh<_i826.InspectorHomeSearchUseCase>(),
            ));
    gh.factory<_i257.RegisterCubit>(
        () => _i257.RegisterCubit(gh<_i456.RegisterUseCase>()));
    gh.factory<_i416.ResetPasswordUseCase>(
        () => _i416.ResetPasswordUseCase(gh<_i234.ResetPasswordRepositry>()));
    gh.factory<_i938.SignInCubit>(
        () => _i938.SignInCubit(gh<_i96.SignInUseCase>()));
    gh.factory<_i214.MarketerRequestDetailsCubit>(() =>
        _i214.MarketerRequestDetailsCubit(
            gh<_i805.MarketerRequestsInspectionDetailsUseCase>()));
    gh.factory<_i458.ForgetPasswordUseCase>(
        () => _i458.ForgetPasswordUseCase(gh<_i255.ForgetPasswordRepositry>()));
    gh.factory<_i941.CsRolesUseCase>(
        () => _i941.CsRolesUseCase(gh<_i203.CsRolesRepositry>()));
    gh.factory<_i447.ProductDetailsCubit>(
        () => _i447.ProductDetailsCubit(gh<_i385.ProductDetailsUseCase>()));
    gh.factory<_i1049.InspectorAssignProductCubit>(() =>
        _i1049.InspectorAssignProductCubit(
            gh<_i119.InspectorAssignInspectionUseCase>()));
    gh.factory<_i172.PushNotificationUseCase>(() =>
        _i172.PushNotificationUseCase(gh<_i1072.PushNotificationRepositry>()));
    gh.factory<_i873.HomeGetAllProductsUseCase>(() =>
        _i873.HomeGetAllProductsUseCase(
            gh<_i77.HomeGetAllProductsRepositry>()));
    gh.factory<_i43.MarketerSearchProductsUseCase>(() =>
        _i43.MarketerSearchProductsUseCase(
            gh<_i77.HomeGetAllProductsRepositry>()));
    gh.factory<_i809.ResetPasswordCubit>(
        () => _i809.ResetPasswordCubit(gh<_i416.ResetPasswordUseCase>()));
    gh.factory<_i155.ForgetPassworsCubit>(
        () => _i155.ForgetPassworsCubit(gh<_i458.ForgetPasswordUseCase>()));
    gh.factory<_i901.PushNotificationCubit>(
        () => _i901.PushNotificationCubit(gh<_i172.PushNotificationUseCase>()));
    gh.factory<_i495.RoleCsCubit>(
        () => _i495.RoleCsCubit(csRolesUseCase: gh<_i941.CsRolesUseCase>()));
    gh.factory<_i158.MarketerHomeProductCubit>(
        () => _i158.MarketerHomeProductCubit(
              gh<_i873.HomeGetAllProductsUseCase>(),
              gh<_i43.MarketerSearchProductsUseCase>(),
            ));
    return this;
  }
}
