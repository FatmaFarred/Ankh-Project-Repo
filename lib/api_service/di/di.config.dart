// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:http/http.dart' as _i519;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/data_sources/admin_permission_remote_data_source_impl.dart'
    as _i865;
import '../../data/data_sources/all_products_remote_data_source.dart' as _i682;
import '../../data/data_sources/authentication/authentication_remote_data_sourse_impl_with_api.dart'
    as _i758;
import '../../data/data_sources/authentication/inspector_authentication_remote_data_source_impl.dart'
    as _i47;
import '../../data/data_sources/cs_roles_remote_data_source_impl.dart'
    as _i1067;
import '../../data/data_sources/forget_reset_password_remote_data_sourse/forget_reset_password_remote_data_Sourse_impl.dart'
    as _i767;
import '../../data/data_sources/forget_reset_password_remote_data_sourse/reset_password_data_sourse_impl.dart'
    as _i1065;
import '../../data/data_sources/home_get_all_products_remote_data_source.dart'
    as _i105;
import '../../data/data_sources/inspection_request_details_remote_data_source.dart'
    as _i147;
import '../../data/data_sources/inspection_submission_remote_data_source.dart'
    as _i212;
import '../../data/data_sources/inspections_remote_data_source_impl.dart'
    as _i422;
import '../../data/data_sources/inspector%20_home_get_all_remote_data_source_impl.dart'
    as _i98;
import '../../data/data_sources/marketer_add_request_remote_data_source_impl.dart'
    as _i0;
import '../../data/data_sources/marketer_assign%20_get_products_remote_data_source_impl.dart'
    as _i407;
import '../../data/data_sources/marketer_requsts_for_inspection_remote_data_source_impl.dart'
    as _i976;
import '../../data/data_sources/point_request_data_source_impl.dart' as _i434;
import '../../data/data_sources/product_details_remote_data_source_impl.dart'
    as _i500;
import '../../data/data_sources/push_notification_data_source_/push_notification_data_sorce_impl.dart'
    as _i71;
import '../../data/repositries/admin_permissiom_repositry_impl.dart' as _i1037;
import '../../data/repositries/all_products_repository_impl.dart' as _i799;
import '../../data/repositries/authentication/authentication%20_repo_impl.dart'
    as _i972;
import '../../data/repositries/authentication/inspector_authentication_repo_impl.dart'
    as _i471;
import '../../data/repositries/cs_roles_repositry_impl.dart' as _i551;
import '../../data/repositries/forget_password_repositry_impl.dart' as _i423;
import '../../data/repositries/home_get_all_products_repositry_impl.dart'
    as _i212;
import '../../data/repositries/inspection_request_details_repository_impl.dart'
    as _i413;
import '../../data/repositries/inspection_submission_repository_impl.dart'
    as _i1017;
import '../../data/repositries/inspections_repository_impl.dart' as _i413;
import '../../data/repositries/inspector%20_home_get_all_repositry_impl.dart'
    as _i868;
import '../../data/repositries/marketer_add_request_repositry_impl.dart'
    as _i105;
import '../../data/repositries/marketer_assign%20_get_products_repositry_impl.dart'
    as _i894;
import '../../data/repositries/marketer_requsts_for_inspection_repositry_impl.dart'
    as _i942;
import '../../data/repositries/PointsRepositryImpl.dart' as _i301;
import '../../data/repositries/product_details_repositry_impl.dart' as _i288;
import '../../data/repositries/push_notification_repositry/push_notification_repositry_impl.dart'
    as _i672;
import '../../data/repositries/reset_passwors_repositry_impl.dart' as _i584;
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/admin_permission_remote_data_source.dart'
    as _i14;
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
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/inspections_remote_data_source.dart'
    as _i362;
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/inspector%20_home_get_all_remote_data_source.dart'
    as _i77;
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/inspector_authentication_remote_data_course.dart'
    as _i545;
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/marketer_add_request_inspection%20_data_source.dart'
    as _i583;
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/marketer_assign%20_get_products_remote_data_source.dart'
    as _i686;
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/marketer_requsts_for_inspection_remote_data_sourse.dart'
    as _i44;
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/PointsRemoteDataSource.dart'
    as _i200;
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/product_details_remote_data_Source.dart'
    as _i526;
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/push_notification_data_sourse.dart'
    as _i667;
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/reset_password_remote_data_sourse.dart'
    as _i223;
import '../../domain/repositries_and_data_sources/repositries/admin_permissions_repositry.dart'
    as _i551;
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
import '../../domain/repositries_and_data_sources/repositries/inspection_request_details_repository.dart'
    as _i110;
import '../../domain/repositries_and_data_sources/repositries/inspection_submission_repository.dart'
    as _i836;
import '../../domain/repositries_and_data_sources/repositries/inspections_repository.dart'
    as _i17;
import '../../domain/repositries_and_data_sources/repositries/inspector%20_home_get_all_repositry.dart'
    as _i700;
import '../../domain/repositries_and_data_sources/repositries/inspector_authentication_repositry.dart'
    as _i339;
import '../../domain/repositries_and_data_sources/repositries/marketer_add_request_inspection.dart'
    as _i233;
import '../../domain/repositries_and_data_sources/repositries/marketer_assign%20_get_products_repositry.dart'
    as _i863;
import '../../domain/repositries_and_data_sources/repositries/marketer_requsts_for_inspection_repositry.dart'
    as _i1072;
import '../../domain/repositries_and_data_sources/repositries/points_repositry.dart'
    as _i147;
import '../../domain/repositries_and_data_sources/repositries/product_details_repositry.dart'
    as _i404;
import '../../domain/repositries_and_data_sources/repositries/push%20_notification_%20repositry.dart'
    as _i1072;
import '../../domain/repositries_and_data_sources/repositries/reset_password_repositry.dart'
    as _i234;
import '../../domain/use_cases/accept_point_request_use_case.dart' as _i962;
import '../../domain/use_cases/appoint_as_team_leader_use_case.dart' as _i416;
import '../../domain/use_cases/authentication/inspector_register_usecase.dart'
    as _i33;
import '../../domain/use_cases/authentication/register_usecase.dart' as _i456;
import '../../domain/use_cases/authentication/signin_usecase.dart' as _i96;
import '../../domain/use_cases/block_user_use_case.dart' as _i808;
import '../../domain/use_cases/cs_roles_usecase.dart' as _i941;
import '../../domain/use_cases/forget_reset_password_usecse/forget_password_usecase.dart'
    as _i458;
import '../../domain/use_cases/forget_reset_password_usecse/reset_password_use_case.dart'
    as _i416;
import '../../domain/use_cases/get_all_insepctors_use_case.dart' as _i769;
import '../../domain/use_cases/get_All_inspection_by_id_use_cae.dart' as _i1025;
import '../../domain/use_cases/get_all_marketers_use_case.dart' as _i91;
import '../../domain/use_cases/get_all_point_request_use_case.dart' as _i557;
import '../../domain/use_cases/get_all_products_use_case.dart' as _i939;
import '../../domain/use_cases/get_inspection_request_details_use_case.dart'
    as _i194;
import '../../domain/use_cases/get_inspections_use_case.dart' as _i147;
import '../../domain/use_cases/get_inspector_inspections_use_case.dart'
    as _i747;
import '../../domain/use_cases/get_report_details_use_case.dart' as _i708;
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
import '../../domain/use_cases/reject_point_request_use_case.dart' as _i552;
import '../../domain/use_cases/search_inspectors_use_case.dart' as _i215;
import '../../domain/use_cases/search_marketers_use_case.dart' as _i871;
import '../../domain/use_cases/submit_inspection_report_usecase.dart' as _i1015;
import '../../domain/use_cases/unblock_user_use_case.dart' as _i877;
import '../../domain/use_cases/unssign_prodcut_from_marketer_use_case.dart'
    as _i537;
import '../../domain/use_cases/update_marketer_account_status_use_case.dart'
    as _i598;
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
import '../../feauture/dashboard/inspector_management/cubit/block_inspector_cubit.dart'
    as _i32;
import '../../feauture/dashboard/inspector_management/cubit/inspector_management_cubit.dart'
    as _i538;
import '../../feauture/dashboard/inspector_management/cubit/unblock_inspector_cubit.dart'
    as _i714;
import '../../feauture/dashboard/marketer_mangemnet/cubit/appoint_as_team_leader_cubit.dart'
    as _i270;
import '../../feauture/dashboard/marketer_mangemnet/cubit/block_user_cubit.dart'
    as _i338;
import '../../feauture/dashboard/marketer_mangemnet/cubit/marketer_management_cubit.dart'
    as _i956;
import '../../feauture/dashboard/marketer_mangemnet/cubit/marketer_unassign_product_cubit.dart'
    as _i239;
import '../../feauture/dashboard/marketer_mangemnet/cubit/unblock_user_cubit.dart'
    as _i209;
import '../../feauture/dashboard/marketer_mangemnet/cubit/update_marketer_status_cubit.dart'
    as _i42;
import '../../feauture/dashboard/points_management/cubit/points_cubit.dart'
    as _i561;
import '../../feauture/details_screen/controller/product_details_cubit.dart'
    as _i447;
import '../../feauture/inspector_screen/authentication/inspector_register_controller/inspector_register_cubit.dart'
    as _i203;
import '../../feauture/inspector_screen/inspection_details/inspection_request_details_cubit.dart'
    as _i738;
import '../../feauture/inspector_screen/inspection_details/submit_inspection_cubit.dart'
    as _i425;
import '../../feauture/inspector_screen/inspector_home/assign_inspection_controller/marketer_product_cubit.dart'
    as _i1049;
import '../../feauture/inspector_screen/inspector_home/controller/inspector_home_cubit.dart'
    as _i635;
import '../../feauture/inspector_screen/my_inspections/my_inspections_cubit.dart'
    as _i215;
import '../../feauture/marketer_home/assign_product_controller/marketer_product_cubit.dart'
    as _i300;
import '../../feauture/marketer_home/controller/marketer_home_product_cubit.dart'
    as _i158;
import '../../feauture/marketer_products/get_product_controller/marketer_product_cubit.dart'
    as _i954;
import '../../feauture/marketer_Reports/marketer_report_details/report_details/report_details_cubit.dart'
    as _i356;
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
import 'injectable_module.dart' as _i109;

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
    final injectableModule = _$InjectableModule();
    gh.factory<_i329.FirebaseMessagingService>(
        () => _i329.FirebaseMessagingService());
    gh.singleton<_i1069.ApiManager>(() => _i1069.ApiManager());
    gh.singleton<_i354.UserCubit>(() => _i354.UserCubit());
    gh.singleton<_i664.FireBaseUtilies>(() => _i664.FireBaseUtilies());
    gh.singleton<_i470.LocalNotification>(() => _i470.LocalNotification());
    gh.lazySingleton<_i519.Client>(() => injectableModule.client);
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
    gh.factory<_i200.PointsRemoteDataSource>(
        () => _i434.PointRemoteDataSourceImpl(gh<_i1069.ApiManager>()));
    gh.factory<_i822.ForgrtPasswordRemoteDataSource>(() =>
        _i767.ForgetResetPasswordRemoteDataSourseImpl(gh<_i1069.ApiManager>()));
    gh.factory<_i430.AuthenticationRemoteDataSource>(() =>
        _i758.AuthenticationRemoteDataSourceImplWithApi(
            gh<_i1069.ApiManager>()));
    gh.factory<_i14.AdminPermissionsRemoteDataSource>(() =>
        _i865.AdminPermissionsRemoteDataSourceImpl(gh<_i1069.ApiManager>()));
    gh.factory<_i551.AdminPermissionsRepositry>(() =>
        _i1037.AdminPermissionsRepositryimpl(
            gh<_i14.AdminPermissionsRemoteDataSource>()));
    gh.factory<_i91.GetAllMarketersUseCase>(() => _i91.GetAllMarketersUseCase(
        gh<_i863.MarketerAssignGetProductsRepositry>()));
    gh.factory<_i362.MyInspectionsRemoteDataSource>(
        () => _i422.MyInspectionsRemoteDataSourceImpl(gh<_i1069.ApiManager>()));
    gh.factory<_i583.MarketerAddRequestInspectionRemoteDataSource>(() =>
        _i0.MarketerAddRequestInspectionRemoteDataSourseImpl(
            apiManager: gh<_i1069.ApiManager>()));
    gh.factory<_i545.InspectorAuthenticationRemoteDataSource>(() =>
        _i47.InspectorAuthenticationRemoteDataSourceImpl(
            gh<_i1069.ApiManager>()));
    gh.factory<_i416.AppointAsTeamLeaderUseCase>(() =>
        _i416.AppointAsTeamLeaderUseCase(
            gh<_i551.AdminPermissionsRepositry>()));
    gh.factory<_i808.BlockUserUseCase>(
        () => _i808.BlockUserUseCase(gh<_i551.AdminPermissionsRepositry>()));
    gh.factory<_i877.UnBlockUserUseCase>(
        () => _i877.UnBlockUserUseCase(gh<_i551.AdminPermissionsRepositry>()));
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
    gh.factory<_i209.UnblockUserCubit>(
        () => _i209.UnblockUserCubit(gh<_i877.UnBlockUserUseCase>()));
    gh.factory<_i714.UnblockInspectorCubit>(
        () => _i714.UnblockInspectorCubit(gh<_i877.UnBlockUserUseCase>()));
    gh.factory<_i939.GetAllProductsUseCase>(
        () => _i939.GetAllProductsUseCase(gh<_i629.AllProductsRepository>()));
    gh.factory<_i233.MarketerAddRequestInspectionRepositry>(() =>
        _i105.MarketerAddRequestInspectionRepositryImpl(
            marketerAddRequestInspectionRemoteDataSource:
                gh<_i583.MarketerAddRequestInspectionRemoteDataSource>()));
    gh.factory<_i674.MarketerAssignProductUseCase>(() =>
        _i674.MarketerAssignProductUseCase(
            gh<_i863.MarketerAssignGetProductsRepositry>()));
    gh.factory<_i527.MarketerProductsUseCase>(() =>
        _i527.MarketerProductsUseCase(
            gh<_i863.MarketerAssignGetProductsRepositry>()));
    gh.factory<_i871.MarketerSearchUseCase>(() => _i871.MarketerSearchUseCase(
        gh<_i863.MarketerAssignGetProductsRepositry>()));
    gh.factory<_i598.UpdateMarketerAccountStatusUseCase>(() =>
        _i598.UpdateMarketerAccountStatusUseCase(
            gh<_i863.MarketerAssignGetProductsRepositry>()));
    gh.factory<_i537.MarketerUnAssignProductUseCase>(() =>
        _i537.MarketerUnAssignProductUseCase(
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
    gh.factory<_i339.InspectorAuthenticationRepositry>(() =>
        _i471.InspectorAuthenticationRepositryImpl(
            gh<_i545.InspectorAuthenticationRemoteDataSource>()));
    gh.factory<_i203.CsRolesRepositry>(
        () => _i551.CsRolesRepositryImpl(gh<_i460.CsRolesRemoteDataSource>()));
    gh.factory<_i234.ResetPasswordRepositry>(() =>
        _i584.ResetPasswordsRepositryImpl(
            gh<_i223.ResetPasswordRemoteDataSourse>()));
    gh.factory<_i147.PointsRepositry>(
        () => _i301.Pointsrepositryimpl(gh<_i200.PointsRemoteDataSource>()));
    gh.factory<_i338.BlockUserCubit>(
        () => _i338.BlockUserCubit(gh<_i808.BlockUserUseCase>()));
    gh.factory<_i32.BlockInspectorCubit>(
        () => _i32.BlockInspectorCubit(gh<_i808.BlockUserUseCase>()));
    gh.factory<_i1072.MarketerRequestsForInspectionRepositry>(() =>
        _i942.MarketerRequestsForInspectionRepositryImpl(
            gh<_i44.MarketerRequestsForInspectionRemoteDataSource>()));
    gh.lazySingleton<_i212.InspectionSubmissionRemoteDataSource>(() =>
        _i212.InspectionSubmissionRemoteDataSourceImpl(gh<_i519.Client>()));
    gh.factory<_i17.MyInspectionsRepository>(() =>
        _i413.MyInspectionsRepositoryImpl(
            remoteDataSource: gh<_i362.MyInspectionsRemoteDataSource>()));
    gh.factory<_i805.MarketerRequestsInspectionDetailsUseCase>(() =>
        _i805.MarketerRequestsInspectionDetailsUseCase(
            gh<_i1072.MarketerRequestsForInspectionRepositry>()));
    gh.factory<_i749.MarketerRequestsForInspectionUseCase>(() =>
        _i749.MarketerRequestsForInspectionUseCase(
            gh<_i1072.MarketerRequestsForInspectionRepositry>()));
    gh.lazySingleton<_i147.InspectionRequestDetailsRemoteDataSource>(() =>
        _i147.InspectionRequestDetailsRemoteDataSourceImpl(gh<_i519.Client>()));
    gh.factory<_i956.MarketerManagementCubit>(
        () => _i956.MarketerManagementCubit(
              gh<_i91.GetAllMarketersUseCase>(),
              gh<_i871.MarketerSearchUseCase>(),
            ));
    gh.factory<_i300.MarketerAssignProductCubit>(() =>
        _i300.MarketerAssignProductCubit(
            gh<_i674.MarketerAssignProductUseCase>()));
    gh.factory<_i404.ProductDetailsRepositry>(() =>
        _i288.ProductDetailsRepositryImpl(
            gh<_i526.ProductDetailsRemoteDataSource>()));
    gh.factory<_i962.AcceptPointRequestUseCase>(
        () => _i962.AcceptPointRequestUseCase(gh<_i147.PointsRepositry>()));
    gh.factory<_i557.GetAllPointRequestUseCase>(
        () => _i557.GetAllPointRequestUseCase(gh<_i147.PointsRepositry>()));
    gh.factory<_i552.RejectPointRequestUseCase>(
        () => _i552.RejectPointRequestUseCase(gh<_i147.PointsRepositry>()));
    gh.factory<_i456.RegisterUseCase>(
        () => _i456.RegisterUseCase(gh<_i817.AuthenticationRepositry>()));
    gh.factory<_i96.SignInUseCase>(
        () => _i96.SignInUseCase(gh<_i817.AuthenticationRepositry>()));
    gh.factory<_i954.MarketerProductCubit>(
        () => _i954.MarketerProductCubit(gh<_i527.MarketerProductsUseCase>()));
    gh.factory<_i270.AppointAsTeamLeaderCubit>(() =>
        _i270.AppointAsTeamLeaderCubit(gh<_i416.AppointAsTeamLeaderUseCase>()));
    gh.factory<_i789.MarketerRequestCubit>(() => _i789.MarketerRequestCubit(
        gh<_i749.MarketerRequestsForInspectionUseCase>()));
    gh.factory<_i176.MarketerAddRequestInspectionUseCase>(() =>
        _i176.MarketerAddRequestInspectionUseCase(
            gh<_i233.MarketerAddRequestInspectionRepositry>()));
    gh.factory<_i147.GetMyInspectionsUseCase>(() =>
        _i147.GetMyInspectionsUseCase(gh<_i17.MyInspectionsRepository>()));
    gh.factory<_i708.GetReportDetailsUseCase>(() =>
        _i708.GetReportDetailsUseCase(gh<_i17.MyInspectionsRepository>()));
    gh.factory<_i1025.GetAllInspectionByIdUseCase>(() =>
        _i1025.GetAllInspectionByIdUseCase(gh<_i17.MyInspectionsRepository>()));
    gh.lazySingleton<_i110.InspectionRequestDetailsRepository>(() =>
        _i413.InspectionRequestDetailsRepositoryImpl(
            gh<_i147.InspectionRequestDetailsRemoteDataSource>()));
    gh.factory<_i255.ForgetPasswordRepositry>(() =>
        _i423.ForgrtPasswordRepositryImpl(
            gh<_i822.ForgrtPasswordRemoteDataSource>()));
    gh.lazySingleton<_i194.GetInspectionRequestDetailsUseCase>(() =>
        _i194.GetInspectionRequestDetailsUseCase(
            gh<_i110.InspectionRequestDetailsRepository>()));
    gh.factory<_i42.UpdateMarketerStatusCubit>(() =>
        _i42.UpdateMarketerStatusCubit(
            gh<_i598.UpdateMarketerAccountStatusUseCase>()));
    gh.factory<_i385.ProductDetailsUseCase>(
        () => _i385.ProductDetailsUseCase(gh<_i404.ProductDetailsRepositry>()));
    gh.factory<_i769.GetAllInspectorsUseCase>(() =>
        _i769.GetAllInspectorsUseCase(
            gh<_i700.HomeGetAllInspectionRepositry>()));
    gh.factory<_i215.SearchInspectorsUseCase>(() =>
        _i215.SearchInspectorsUseCase(
            gh<_i700.HomeGetAllInspectionRepositry>()));
    gh.factory<_i239.MarketerUnassignProductCubit>(() =>
        _i239.MarketerUnassignProductCubit(
            gh<_i537.MarketerUnAssignProductUseCase>()));
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
    gh.factory<_i747.GetInspectorInspectionsUseCase>(() =>
        _i747.GetInspectorInspectionsUseCase(
            gh<_i700.HomeGetAllInspectionRepositry>()));
    gh.factory<_i635.InspectorHomeProductCubit>(() =>
        _i635.InspectorHomeProductCubit(
            gh<_i868.InspectorHomeGetAllInspectionUseCase>()));
    gh.factory<_i77.HomeGetAllProductsRepositry>(() =>
        _i212.HomeGetAllProductsRepositryImpl(
            gh<_i1054.HomeGetAllProductsRemoteDataSource>()));
    gh.factory<_i1072.PushNotificationRepositry>(() =>
        _i672.PushNotificationRepositryImpl(
            gh<_i667.PushNotificationDataSourse>()));
    gh.lazySingleton<_i836.InspectionSubmissionRepository>(() =>
        _i1017.InspectionSubmissionRepositoryImpl(
            gh<_i212.InspectionSubmissionRemoteDataSource>()));
    gh.factory<_i1015.SubmitInspectionReportUseCase>(() =>
        _i1015.SubmitInspectionReportUseCase(
            gh<_i836.InspectionSubmissionRepository>()));
    gh.factory<_i538.InspectorManagementCubit>(
        () => _i538.InspectorManagementCubit(
              gh<_i769.GetAllInspectorsUseCase>(),
              gh<_i215.SearchInspectorsUseCase>(),
            ));
    gh.factory<_i215.MyInspectionsCubit>(() => _i215.MyInspectionsCubit(
          getInspectionsUseCase: gh<_i147.GetMyInspectionsUseCase>(),
          searchProductsUseCase: gh<_i826.InspectorHomeSearchUseCase>(),
          getAllInspectionByIdUseCase: gh<_i1025.GetAllInspectionByIdUseCase>(),
        ));
    gh.factory<_i257.RegisterCubit>(
        () => _i257.RegisterCubit(gh<_i456.RegisterUseCase>()));
    gh.factory<_i416.ResetPasswordUseCase>(
        () => _i416.ResetPasswordUseCase(gh<_i234.ResetPasswordRepositry>()));
    gh.factory<_i938.SignInCubit>(
        () => _i938.SignInCubit(gh<_i96.SignInUseCase>()));
    gh.factory<_i738.InspectionRequestDetailsCubit>(() =>
        _i738.InspectionRequestDetailsCubit(
            gh<_i194.GetInspectionRequestDetailsUseCase>()));
    gh.factory<_i561.PointsCubit>(() => _i561.PointsCubit(
          getAllPointRequestUseCase: gh<_i557.GetAllPointRequestUseCase>(),
          acceptPointRequestUseCase: gh<_i962.AcceptPointRequestUseCase>(),
          rejectPointRequestUseCase: gh<_i552.RejectPointRequestUseCase>(),
        ));
    gh.factory<_i33.InspectorRegisterUseCase>(() =>
        _i33.InspectorRegisterUseCase(
            gh<_i339.InspectorAuthenticationRepositry>()));
    gh.factory<_i425.SubmitInspectionCubit>(() => _i425.SubmitInspectionCubit(
        gh<_i1015.SubmitInspectionReportUseCase>()));
    gh.factory<_i214.MarketerRequestDetailsCubit>(() =>
        _i214.MarketerRequestDetailsCubit(
            gh<_i805.MarketerRequestsInspectionDetailsUseCase>()));
    gh.factory<_i458.ForgetPasswordUseCase>(
        () => _i458.ForgetPasswordUseCase(gh<_i255.ForgetPasswordRepositry>()));
    gh.factory<_i941.CsRolesUseCase>(
        () => _i941.CsRolesUseCase(gh<_i203.CsRolesRepositry>()));
    gh.factory<_i356.MarketerReportDetailsCubit>(() =>
        _i356.MarketerReportDetailsCubit(gh<_i708.GetReportDetailsUseCase>()));
    gh.factory<_i447.ProductDetailsCubit>(
        () => _i447.ProductDetailsCubit(gh<_i385.ProductDetailsUseCase>()));
    gh.factory<_i1049.InspectorAssignProductCubit>(() =>
        _i1049.InspectorAssignProductCubit(
            gh<_i119.InspectorAssignInspectionUseCase>()));
    gh.factory<_i203.InspectorRegisterCubit>(() =>
        _i203.InspectorRegisterCubit(gh<_i33.InspectorRegisterUseCase>()));
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

class _$InjectableModule extends _i109.InjectableModule {}
