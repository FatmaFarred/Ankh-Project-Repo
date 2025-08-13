// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
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
import '../../data/data_sources/client_remote_data_source_impl.dart' as _i722;
import '../../data/data_sources/cs_roles_remote_data_source_impl.dart'
    as _i1067;
import '../../data/data_sources/edit_product_remote_data_source.dart' as _i101;
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
import '../../data/data_sources/installment_offers_by_marketer_id_remote_data_source.dart'
    as _i981;
import '../../data/data_sources/installment_offers_by_marketer_id_remote_data_source_impl.dart'
    as _i749;
import '../../data/data_sources/installment_pending_remote_data_source.dart'
    as _i696;
import '../../data/data_sources/installment_pending_remote_data_source_impl.dart'
    as _i861;
import '../../data/data_sources/marketer_add_request_remote_data_source_impl.dart'
    as _i0;
import '../../data/data_sources/marketer_assign%20_get_products_remote_data_source_impl.dart'
    as _i407;
import '../../data/data_sources/marketer_invite_code_remote_data_source_impl.dart'
    as _i655;
import '../../data/data_sources/marketer_requsts_for_inspection_remote_data_source_impl.dart'
    as _i976;
import '../../data/data_sources/point_request_data_source_impl.dart' as _i434;
import '../../data/data_sources/price_offer_remote_data_source.dart' as _i1039;
import '../../data/data_sources/price_offers_by_marketer_id_remote_data_source.dart'
    as _i773;
import '../../data/data_sources/price_offers_by_marketer_id_remote_data_source_impl.dart'
    as _i433;
import '../../data/data_sources/product_details_remote_data_source_impl.dart'
    as _i500;
import '../../data/data_sources/product_management_remote_data_source.dart'
    as _i1010;
import '../../data/data_sources/product_name_remote_data_source_impl.dart'
    as _i339;
import '../../data/data_sources/product_rating_remote_data_source_impl.dart'
    as _i521;
import '../../data/data_sources/products_by_brand_remote_data_source_impl.dart'
    as _i832;
import '../../data/data_sources/profile_remote_data_source_impl.dart' as _i446;
import '../../data/data_sources/push_notification_data_source_/push_notification_data_sorce_impl.dart'
    as _i71;
import '../../data/data_sources/remote_data_source.dart' as _i264;
import '../../data/data_sources/remote_data_source_impl.dart' as _i176;
import '../../data/data_sources/top_brand_remote_data_source.dart' as _i773;
import '../../data/repositries/admin_permissiom_repositry_impl.dart' as _i1037;
import '../../data/repositries/all_products_repository_impl.dart' as _i799;
import '../../data/repositries/authentication/authentication%20_repo_impl.dart'
    as _i972;
import '../../data/repositries/authentication/inspector_authentication_repo_impl.dart'
    as _i471;
import '../../data/repositries/client_repositry_impl.dart' as _i182;
import '../../data/repositries/cs_roles_repositry_impl.dart' as _i551;
import '../../data/repositries/forget_password_repositry_impl.dart' as _i423;
import '../../data/repositries/get_all_price_offer_repository_impl.dart'
    as _i325;
import '../../data/repositries/home_get_all_products_repositry_impl.dart'
    as _i212;
import '../../data/repositries/inspection_request_details_repository_impl.dart'
    as _i413;
import '../../data/repositries/inspection_submission_repository_impl.dart'
    as _i1017;
import '../../data/repositries/inspections_repository_impl.dart' as _i413;
import '../../data/repositries/inspector%20_home_get_all_repositry_impl.dart'
    as _i868;
import '../../data/repositries/installment_actions_repository_impl.dart'
    as _i1029;
import '../../data/repositries/installment_offers_by_marketer_id_repository_impl.dart'
    as _i807;
import '../../data/repositries/installment_pending_repository_impl.dart'
    as _i587;
import '../../data/repositries/installment_request_repository_impl.dart'
    as _i908;
import '../../data/repositries/marketer_add_request_repositry_impl.dart'
    as _i105;
import '../../data/repositries/marketer_assign%20_get_products_repositry_impl.dart'
    as _i894;
import '../../data/repositries/marketer_invite_code_repositry_impl.dart'
    as _i842;
import '../../data/repositries/marketer_requsts_for_inspection_repositry_impl.dart'
    as _i942;
import '../../data/repositries/PointsRepositryImpl.dart' as _i301;
import '../../data/repositries/post_product_repository_impl.dart' as _i734;
import '../../data/repositries/price_offer_repository_impl.dart' as _i229;
import '../../data/repositries/price_offers_by_marketer_id_repository_impl.dart'
    as _i873;
import '../../data/repositries/product_details_repositry_impl.dart' as _i288;
import '../../data/repositries/product_management_repository_impl.dart'
    as _i744;
import '../../data/repositries/product_name_repository_impl.dart' as _i970;
import '../../data/repositries/product_rating_repository_impl.dart' as _i199;
import '../../data/repositries/products_by_brand_repository_impl.dart' as _i827;
import '../../data/repositries/profile_repositry_impl.dart' as _i509;
import '../../data/repositries/push_notification_repositry/push_notification_repositry_impl.dart'
    as _i672;
import '../../data/repositries/reset_passwors_repositry_impl.dart' as _i584;
import '../../data/repositries/top_brand_repository_impl.dart' as _i908;
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/admin_permission_remote_data_source.dart'
    as _i14;
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/all_products_remote_data_source.dart'
    as _i0;
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/authentication.dart'
    as _i430;
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/client_remote_data_source.dart'
    as _i209;
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
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/marketer_invite_code_remote_data_source.dart'
    as _i287;
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/marketer_requsts_for_inspection_remote_data_sourse.dart'
    as _i44;
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/PointsRemoteDataSource.dart'
    as _i200;
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/product_details_remote_data_Source.dart'
    as _i526;
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/product_name_remote_data_source.dart'
    as _i559;
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/product_rating_remote_data_source.dart'
    as _i616;
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/products_by_brand_remote_data_source.dart'
    as _i677;
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/profile_remote_data_source.dart'
    as _i55;
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/push_notification_data_sourse.dart'
    as _i667;
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/reset_password_remote_data_sourse.dart'
    as _i223;
import '../../domain/repositries_and_data_sources/repositories/product_rating_repository.dart'
    as _i617;
import '../../domain/repositries_and_data_sources/repositries/admin_permissions_repositry.dart'
    as _i551;
import '../../domain/repositries_and_data_sources/repositries/all_products_repository.dart'
    as _i629;
import '../../domain/repositries_and_data_sources/repositries/authentication_repositry.dart'
    as _i817;
import '../../domain/repositries_and_data_sources/repositries/client_repositry.dart'
    as _i1039;
import '../../domain/repositries_and_data_sources/repositries/cs_roles_repositry.dart'
    as _i203;
import '../../domain/repositries_and_data_sources/repositries/forget_reset_password_repositry.dart'
    as _i255;
import '../../domain/repositries_and_data_sources/repositries/get_all_price_offer_repository.dart'
    as _i444;
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
import '../../domain/repositries_and_data_sources/repositries/installment_actions_repository.dart'
    as _i103;
import '../../domain/repositries_and_data_sources/repositries/installment_offers_by_marketer_id_repository.dart'
    as _i523;
import '../../domain/repositries_and_data_sources/repositries/installment_pending_repository.dart'
    as _i485;
import '../../domain/repositries_and_data_sources/repositries/installment_request_repository.dart'
    as _i500;
import '../../domain/repositries_and_data_sources/repositries/marketer_add_request_inspection.dart'
    as _i233;
import '../../domain/repositries_and_data_sources/repositries/marketer_assign%20_get_products_repositry.dart'
    as _i863;
import '../../domain/repositries_and_data_sources/repositries/marketer_invite_code_reppositry.dart'
    as _i966;
import '../../domain/repositries_and_data_sources/repositries/marketer_requsts_for_inspection_repositry.dart'
    as _i1072;
import '../../domain/repositries_and_data_sources/repositries/points_repositry.dart'
    as _i147;
import '../../domain/repositries_and_data_sources/repositries/post_product_repository.dart'
    as _i846;
import '../../domain/repositries_and_data_sources/repositries/price_offer_repository.dart'
    as _i807;
import '../../domain/repositries_and_data_sources/repositries/price_offers_by_marketer_id_repository.dart'
    as _i653;
import '../../domain/repositries_and_data_sources/repositries/product_details_repositry.dart'
    as _i404;
import '../../domain/repositries_and_data_sources/repositries/product_management_repository.dart'
    as _i127;
import '../../domain/repositries_and_data_sources/repositries/product_name_repository.dart'
    as _i756;
import '../../domain/repositries_and_data_sources/repositries/products_by_brand_repository.dart'
    as _i129;
import '../../domain/repositries_and_data_sources/repositries/profile_repositry.dart'
    as _i883;
import '../../domain/repositries_and_data_sources/repositries/push%20_notification_%20repositry.dart'
    as _i1072;
import '../../domain/repositries_and_data_sources/repositries/reset_password_repositry.dart'
    as _i234;
import '../../domain/repositries_and_data_sources/repositries/top_brand_repository.dart'
    as _i68;
import '../../domain/use_cases/accept_point_request_use_case.dart' as _i962;
import '../../domain/use_cases/add_comment_use_case.dart' as _i282;
import '../../domain/use_cases/add_favorite_use_case.dart' as _i886;
import '../../domain/use_cases/add_point_request_use_case.dart' as _i391;
import '../../domain/use_cases/add_product_name_use_case.dart' as _i731;
import '../../domain/use_cases/add_product_rating_use_case.dart' as _i395;
import '../../domain/use_cases/add_top_brand_use_case.dart' as _i422;
import '../../domain/use_cases/adjust_commission_for_roles_use_case.dart'
    as _i991;
import '../../domain/use_cases/adjust_commission_for_team_leader_use_case.dart'
    as _i122;
import '../../domain/use_cases/adjust_user_points.dart' as _i286;
import '../../domain/use_cases/appoint_as_team_leader_use_case.dart' as _i416;
import '../../domain/use_cases/authentication/client_register_use_case.dart'
    as _i920;
import '../../domain/use_cases/authentication/email_verfication.dart' as _i280;
import '../../domain/use_cases/authentication/foget_password_use_case.dart'
    as _i1062;
import '../../domain/use_cases/authentication/inspector_register_usecase.dart'
    as _i33;
import '../../domain/use_cases/authentication/register_usecase.dart' as _i456;
import '../../domain/use_cases/authentication/resent_email_verfication.dart'
    as _i358;
import '../../domain/use_cases/authentication/reset_password_use_case.dart'
    as _i217;
import '../../domain/use_cases/authentication/signin_usecase.dart' as _i96;
import '../../domain/use_cases/authentication/team_member_register.dart'
    as _i370;
import '../../domain/use_cases/block_user_use_case.dart' as _i808;
import '../../domain/use_cases/cs_roles_usecase.dart' as _i941;
import '../../domain/use_cases/delete_favorite_use_case.dart' as _i367;
import '../../domain/use_cases/delete_product_name_use_case.dart' as _i479;
import '../../domain/use_cases/delete_product_usecase.dart' as _i578;
import '../../domain/use_cases/delete_top_brand_use_case.dart' as _i282;
import '../../domain/use_cases/edit_point_price_use_case.dart' as _i341;
import '../../domain/use_cases/edit_product_usecase.dart' as _i151;
import '../../domain/use_cases/edit_profile_use_case.dart' as _i775;
import '../../domain/use_cases/edit_top_brand_use_case.dart' as _i720;
import '../../domain/use_cases/get_all_insepctors_use_case.dart' as _i769;
import '../../domain/use_cases/get_all_inspection_admin_use_case.dart' as _i273;
import '../../domain/use_cases/get_All_inspection_by_id_use_cae.dart' as _i1025;
import '../../domain/use_cases/get_all_marketer_codes_use_case.dart' as _i348;
import '../../domain/use_cases/get_all_marketers_use_case.dart' as _i91;
import '../../domain/use_cases/get_all_point_price_use_case.dart' as _i429;
import '../../domain/use_cases/get_all_point_request_use_case.dart' as _i557;
import '../../domain/use_cases/get_all_products_use_case.dart' as _i939;
import '../../domain/use_cases/get_all_users_use_case.dart' as _i795;
import '../../domain/use_cases/get_balance_use_case.dart' as _i78;
import '../../domain/use_cases/get_comment_use_case.dart' as _i960;
import '../../domain/use_cases/get_favorite_use_case.dart' as _i590;
import '../../domain/use_cases/get_inspection_request_details_use_case.dart'
    as _i194;
import '../../domain/use_cases/get_inspections_use_case.dart' as _i147;
import '../../domain/use_cases/get_inspector_inspections_use_case.dart'
    as _i747;
import '../../domain/use_cases/get_installment_pending_usecase.dart' as _i587;
import '../../domain/use_cases/get_pending_price_offers_usecase.dart' as _i865;
import '../../domain/use_cases/get_product_management_details_usecase.dart'
    as _i508;
import '../../domain/use_cases/get_product_management_usecase.dart' as _i683;
import '../../domain/use_cases/get_product_names_use_case.dart' as _i90;
import '../../domain/use_cases/get_products_by_brand_use_case.dart' as _i208;
import '../../domain/use_cases/get_profile_use_case.dart' as _i305;
import '../../domain/use_cases/get_report_details_use_case.dart' as _i708;
import '../../domain/use_cases/get_team_member_use_case.dart' as _i142;
import '../../domain/use_cases/get_top_brands_use_case.dart' as _i939;
import '../../domain/use_cases/home_get_all_products_use_case.dart' as _i873;
import '../../domain/use_cases/inspection_home_search_use_case.dart' as _i826;
import '../../domain/use_cases/inspector_assign_inspection_use_case.dart'
    as _i119;
import '../../domain/use_cases/inspector_get_all_inspection_use_case.dart'
    as _i868;
import '../../domain/use_cases/installment_offers_by_marketer_id_usecase.dart'
    as _i967;
import '../../domain/use_cases/marketer_add_request_inspection_usecase.dart'
    as _i176;
import '../../domain/use_cases/marketer_assign_product_use_case.dart' as _i674;
import '../../domain/use_cases/marketer_products_use_case.dart' as _i527;
import '../../domain/use_cases/marketer_request_inspection_details_usecase.dart'
    as _i805;
import '../../domain/use_cases/marketer_requsts_for_inspection_usecase.dart'
    as _i749;
import '../../domain/use_cases/marketer_serach_home_usecase.dart' as _i43;
import '../../domain/use_cases/markter_generate_code_use_case.dart' as _i371;
import '../../domain/use_cases/post_product_usecase.dart' as _i1002;
import '../../domain/use_cases/price_offers_by_marketer_id_usecase.dart'
    as _i421;
import '../../domain/use_cases/process_installment_request_usecase.dart'
    as _i908;
import '../../domain/use_cases/product_details_use_case.dart' as _i385;
import '../../domain/use_cases/push_notification_use_case/get_notification_use_case.dart'
    as _i186;
import '../../domain/use_cases/push_notification_use_case/post_notification_use_case.dart'
    as _i349;
import '../../domain/use_cases/push_notification_use_case/push_notification_use_case.dart'
    as _i172;
import '../../domain/use_cases/rate_user_use_case.dart' as _i531;
import '../../domain/use_cases/reject_point_request_use_case.dart' as _i552;
import '../../domain/use_cases/reschedule_inspection_use_case.dart' as _i1001;
import '../../domain/use_cases/search_inspection_admin_use_case.dart' as _i699;
import '../../domain/use_cases/search_inspectors_use_case.dart' as _i215;
import '../../domain/use_cases/search_marketers_use_case.dart' as _i871;
import '../../domain/use_cases/search_users_use_case.dart' as _i384;
import '../../domain/use_cases/send_installment_request_usecase.dart' as _i247;
import '../../domain/use_cases/send_price_offer_usecase.dart' as _i527;
import '../../domain/use_cases/submit_inspection_report_usecase.dart' as _i1015;
import '../../domain/use_cases/unblock_user_use_case.dart' as _i877;
import '../../domain/use_cases/unssign_prodcut_from_marketer_use_case.dart'
    as _i537;
import '../../domain/use_cases/update_marketer_account_status_use_case.dart'
    as _i598;
import '../../domain/use_cases/update_price_offer_status_usecase.dart' as _i966;
import '../../feauture/authentication/email_verfication/cubit/email_verification_cubit.dart'
    as _i322;
import '../../feauture/authentication/forgrt_password/forget_password/controller/forget_passwors_cubit.dart'
    as _i155;
import '../../feauture/authentication/forgrt_password/set_new_password/controller/reset_password_cubit.dart'
    as _i809;
import '../../feauture/authentication/register/controller/register_cubit.dart'
    as _i257;
import '../../feauture/authentication/signin/controller/sigin_cubit.dart'
    as _i938;
import '../../feauture/authentication/user_controller/user_cubit.dart' as _i354;
import '../../feauture/balance_screen/cubit/add_point_request_cubit.dart'
    as _i752;
import '../../feauture/balance_screen/cubit/balance_cubit.dart' as _i419;
import '../../feauture/chat_screen/cubit/team_chat_list_cubit.dart' as _i881;
import '../../feauture/choose_cs_role/choose_cs_role_cubit/choose_cs_role_cubit.dart'
    as _i495;
import '../../feauture/client_search_screen/cubit/search_cubit.dart' as _i355;
import '../../feauture/dashboard/cubit/adjust_user_points_cubit.dart' as _i46;
import '../../feauture/dashboard/inspection_managemnt/cubit.dart' as _i411;
import '../../feauture/dashboard/inspection_managemnt/reschedule_cubit.dart'
    as _i852;
import '../../feauture/dashboard/inspector_management/cubit/block_inspector_cubit.dart'
    as _i32;
import '../../feauture/dashboard/inspector_management/cubit/inspector_management_cubit.dart'
    as _i538;
import '../../feauture/dashboard/inspector_management/cubit/unblock_inspector_cubit.dart'
    as _i714;
import '../../feauture/dashboard/installment_requests_management/cubit/installment_pending_cubit.dart'
    as _i129;
import '../../feauture/dashboard/marketer_mangemnet/cubit/appoint_as_team_leader_cubit.dart'
    as _i270;
import '../../feauture/dashboard/marketer_mangemnet/cubit/block_user_cubit.dart'
    as _i338;
import '../../feauture/dashboard/marketer_mangemnet/cubit/marketer_management_cubit.dart'
    as _i956;
import '../../feauture/dashboard/marketer_mangemnet/cubit/marketer_unassign_product_cubit.dart'
    as _i239;
import '../../feauture/dashboard/marketer_mangemnet/cubit/rate_user_cubit.dart'
    as _i629;
import '../../feauture/dashboard/marketer_mangemnet/cubit/unblock_user_cubit.dart'
    as _i209;
import '../../feauture/dashboard/marketer_mangemnet/cubit/update_marketer_status_cubit.dart'
    as _i42;
import '../../feauture/dashboard/notification/push_notification/cubit/get_notification_cubit.dart'
    as _i225;
import '../../feauture/dashboard/notification/push_notification/cubit/push_notification_cubit.dart'
    as _i1031;
import '../../feauture/dashboard/offers_management/cubit/price_offer_cubit.dart'
    as _i413;
import '../../feauture/dashboard/points_management/cubit/commission_rate_cubit.dart'
    as _i898;
import '../../feauture/dashboard/points_management/cubit/point_prices_cubit.dart'
    as _i614;
import '../../feauture/dashboard/points_management/cubit/points_cubit.dart'
    as _i561;
import '../../feauture/dashboard/product_names_management/cubit/product_names_cubit.dart'
    as _i78;
import '../../feauture/dashboard/products_management/add_new_product/cubit/post_product_cubit.dart'
    as _i745;
import '../../feauture/dashboard/products_management/cubit/product_management_cubit.dart'
    as _i27;
import '../../feauture/dashboard/products_management/cubit/product_names_dropdown_cubit.dart'
    as _i245;
import '../../feauture/dashboard/products_management/edit_product_screen/edit_product_cubit.dart'
    as _i1006;
import '../../feauture/dashboard/products_management/product_details_screen/cubit/product_details_cubit.dart'
    as _i710;
import '../../feauture/dashboard/products_management/product_details_screen/delete_product/delete_product_cubit.dart'
    as _i411;
import '../../feauture/dashboard/top_brands/cubit/top_brands_management_cubit.dart'
    as _i244;
import '../../feauture/dashboard/users_management/cubit/user_favorites_cubit.dart'
    as _i709;
import '../../feauture/dashboard/users_management/cubit/users_management_cubit.dart'
    as _i612;
import '../../feauture/details_screen/controller/product_details_cubit.dart'
    as _i447;
import '../../feauture/details_screen/cubit/comment_cubit.dart' as _i620;
import '../../feauture/details_screen/cubit/rating_cubit.dart' as _i730;
import '../../feauture/home_screen/cubit/add_favorite_cubit.dart' as _i906;
import '../../feauture/home_screen/top_brands/cubit/products_by_brand_cubit.dart'
    as _i74;
import '../../feauture/home_screen/top_brands/cubit/top_brand_cubit.dart'
    as _i124;
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
import '../../feauture/invite_team_member/cubit/invite_team_member_cubit.dart'
    as _i329;
import '../../feauture/marketer_home/assign_product_controller/marketer_product_cubit.dart'
    as _i300;
import '../../feauture/marketer_home/controller/marketer_home_product_cubit.dart'
    as _i158;
import '../../feauture/marketer_installment_offers/cubit/installment_offers_by_marketer_id_cubit.dart'
    as _i551;
import '../../feauture/marketer_price_offers/cubit/price_offers_by_marketer_id_cubit.dart'
    as _i710;
import '../../feauture/marketer_products/get_product_controller/marketer_product_cubit.dart'
    as _i954;
import '../../feauture/marketer_Reports/marketer_report_details/report_details/report_details_cubit.dart'
    as _i356;
import '../../feauture/myrequest/controller/cubit.dart' as _i789;
import '../../feauture/myrequest/my_request_details/details_controller/details_request_cubit.dart'
    as _i214;
import '../../feauture/profile/cubit/edit_profile_cubit.dart' as _i235;
import '../../feauture/profile/cubit/profile_cubit.dart' as _i383;
import '../../feauture/request_inspection_screen/cubit/marketer_add_request_cubit.dart'
    as _i280;
import '../../feauture/teams_and_codes/cubit/teams_and_codes_cubit.dart'
    as _i800;
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
    gh.factory<_i361.Dio>(() => injectableModule.dio);
    gh.factory<_i329.FirebaseMessagingService>(
        () => _i329.FirebaseMessagingService());
    gh.singleton<_i1069.ApiManager>(() => _i1069.ApiManager());
    gh.singleton<_i354.UserCubit>(() => _i354.UserCubit());
    gh.singleton<_i664.FireBaseUtilies>(() => _i664.FireBaseUtilies());
    gh.singleton<_i470.LocalNotification>(() => _i470.LocalNotification());
    gh.lazySingleton<_i519.Client>(() => injectableModule.client);
    gh.factory<_i209.ClientRemoteDataSource>(
        () => _i722.ClientRemoteDataSourceImpl(gh<_i1069.ApiManager>()));
    gh.factory<_i287.MarketerInviteCodeRemoteDataSource>(() =>
        _i655.MarketerInviteCodeRemoteDataSourceImpl(gh<_i1069.ApiManager>()));
    gh.factory<_i686.MarketerAssignGetProductsRemoteDataSource>(() =>
        _i407.MarketerAssignGetProductsRemoteDataSourceImpl(
            gh<_i1069.ApiManager>()));
    gh.lazySingleton<_i773.TopBrandRemoteDataSource>(
        () => _i773.TopBrandRemoteDataSourceImpl(
              client: gh<_i519.Client>(),
              apiManager: gh<_i1069.ApiManager>(),
            ));
    gh.lazySingleton<_i0.AllProductsRemoteDataSource>(
        () => _i682.AllProductsRemoteDataSourceImpl(gh<_i1069.ApiManager>()));
    gh.factory<_i863.MarketerAssignGetProductsRepositry>(() =>
        _i894.MarketerAssignGetProductsRepositryImpl(
            gh<_i686.MarketerAssignGetProductsRemoteDataSource>()));
    gh.factory<_i264.RemoteDataSource>(
        () => _i176.RemoteDataSourceImpl(gh<_i361.Dio>()));
    gh.factory<_i460.CsRolesRemoteDataSource>(
        () => _i1067.CsRolesRemoteDataSourceImpl(gh<_i1069.ApiManager>()));
    gh.factory<_i1039.ClientRepositry>(() => _i182.ClientRepositryImpl(
        clientRemoteDataSource: gh<_i209.ClientRemoteDataSource>()));
    gh.lazySingleton<_i981.InstallmentOffersByMarketerIdRemoteDataSource>(
        () => _i749.InstallmentOffersByMarketerIdRemoteDataSourceImpl());
    gh.lazySingleton<_i103.InstallmentActionsRepository>(
        () => _i1029.InstallmentActionsRepositoryImpl());
    gh.factory<_i200.PointsRemoteDataSource>(
        () => _i434.PointRemoteDataSourceImpl(gh<_i1069.ApiManager>()));
    gh.lazySingleton<_i485.InstallmentPendingRepository>(
        () => _i587.InstallmentPendingRepositoryImpl(gh<_i519.Client>()));
    gh.factory<_i587.GetInstallmentPendingUseCase>(() =>
        _i587.GetInstallmentPendingUseCase(
            gh<_i485.InstallmentPendingRepository>()));
    gh.lazySingleton<_i1039.PriceOfferRemoteDataSource>(
        () => _i1039.PriceOfferRemoteDataSourceImpl());
    gh.factory<_i822.ForgrtPasswordRemoteDataSource>(() =>
        _i767.ForgetResetPasswordRemoteDataSourseImpl(gh<_i1069.ApiManager>()));
    gh.factory<_i616.ProductRatingRemoteDataSource>(
        () => _i521.ProductRatingRemoteDataSourceImpl(gh<_i1069.ApiManager>()));
    gh.factory<_i430.AuthenticationRemoteDataSource>(() =>
        _i758.AuthenticationRemoteDataSourceImplWithApi(
            gh<_i1069.ApiManager>()));
    gh.factory<_i14.AdminPermissionsRemoteDataSource>(() =>
        _i865.AdminPermissionsRemoteDataSourceImpl(gh<_i1069.ApiManager>()));
    gh.factory<_i551.AdminPermissionsRepositry>(() =>
        _i1037.AdminPermissionsRepositryimpl(
            gh<_i14.AdminPermissionsRemoteDataSource>()));
    gh.lazySingleton<_i846.PostProductRepository>(
        () => _i734.PostProductRepositoryImpl(gh<_i361.Dio>()));
    gh.lazySingleton<_i773.PriceOffersByMarketerIdRemoteDataSource>(
        () => _i433.PriceOffersByMarketerIdRemoteDataSourceImpl());
    gh.lazySingleton<_i101.EditProductRemoteDataSource>(
        () => _i101.EditProductRemoteDataSourceImpl(gh<_i361.Dio>()));
    gh.factory<_i91.GetAllMarketersUseCase>(() => _i91.GetAllMarketersUseCase(
        gh<_i863.MarketerAssignGetProductsRepositry>()));
    gh.lazySingleton<_i68.TopBrandRepository>(() =>
        _i908.TopBrandRepositoryImpl(gh<_i773.TopBrandRemoteDataSource>()));
    gh.factory<_i362.MyInspectionsRemoteDataSource>(
        () => _i422.MyInspectionsRemoteDataSourceImpl(gh<_i1069.ApiManager>()));
    gh.factory<_i583.MarketerAddRequestInspectionRemoteDataSource>(() =>
        _i0.MarketerAddRequestInspectionRemoteDataSourseImpl(
            apiManager: gh<_i1069.ApiManager>()));
    gh.factory<_i545.InspectorAuthenticationRemoteDataSource>(() =>
        _i47.InspectorAuthenticationRemoteDataSourceImpl(
            gh<_i1069.ApiManager>()));
    gh.factory<_i151.EditProductUseCase>(
        () => _i151.EditProductUseCase(gh<_i846.PostProductRepository>()));
    gh.factory<_i1002.PostProductUseCase>(
        () => _i1002.PostProductUseCase(gh<_i846.PostProductRepository>()));
    gh.factory<_i129.InstallmentPendingCubit>(() =>
        _i129.InstallmentPendingCubit(
            gh<_i485.InstallmentPendingRepository>()));
    gh.lazySingleton<_i677.ProductsByBrandRemoteDataSource>(() =>
        _i832.ProductsByBrandRemoteDataSourceImpl(gh<_i1069.ApiManager>()));
    gh.lazySingleton<_i696.InstallmentPendingRemoteDataSource>(
        () => _i861.InstallmentPendingRemoteDataSourceImpl());
    gh.factory<_i416.AppointAsTeamLeaderUseCase>(() =>
        _i416.AppointAsTeamLeaderUseCase(
            gh<_i551.AdminPermissionsRepositry>()));
    gh.factory<_i808.BlockUserUseCase>(
        () => _i808.BlockUserUseCase(gh<_i551.AdminPermissionsRepositry>()));
    gh.factory<_i531.RateUserUseCase>(
        () => _i531.RateUserUseCase(gh<_i551.AdminPermissionsRepositry>()));
    gh.factory<_i877.UnBlockUserUseCase>(
        () => _i877.UnBlockUserUseCase(gh<_i551.AdminPermissionsRepositry>()));
    gh.factory<_i223.ResetPasswordRemoteDataSourse>(
        () => _i1065.ResetPasswordDataSourceImpl(gh<_i1069.ApiManager>()));
    gh.factory<_i55.UserProfileRemoteDataSource>(
        () => _i446.UserProfileRemoteDataSourceImpl(gh<_i1069.ApiManager>()));
    gh.lazySingleton<_i629.AllProductsRepository>(() =>
        _i799.AllProductsRepositoryImpl(gh<_i0.AllProductsRemoteDataSource>()));
    gh.lazySingleton<_i500.InstallmentRequestRepository>(
        () => _i908.InstallmentRequestRepositoryImpl());
    gh.factory<_i44.MarketerRequestsForInspectionRemoteDataSource>(() =>
        _i976.MarkertRequestsForInspectionRemoteDataSourceImpl(
            gh<_i1069.ApiManager>()));
    gh.factory<_i1054.HomeGetAllProductsRemoteDataSource>(() =>
        _i105.HomeGetAllProductsRemoteDataSourceImpl(gh<_i1069.ApiManager>()));
    gh.factory<_i77.HomeGetAllInspectionRemoteDataSource>(() =>
        _i98.HomeGetAllInspectionRemoteDataSourceImpl(gh<_i1069.ApiManager>()));
    gh.factory<_i908.ProcessInstallmentRequestUseCase>(() =>
        _i908.ProcessInstallmentRequestUseCase(
            gh<_i103.InstallmentActionsRepository>()));
    gh.factory<_i526.ProductDetailsRemoteDataSource>(() =>
        _i500.ProductDetailsRemoteDataSourceImpl(gh<_i1069.ApiManager>()));
    gh.factory<_i714.UnblockInspectorCubit>(
        () => _i714.UnblockInspectorCubit(gh<_i877.UnBlockUserUseCase>()));
    gh.factory<_i209.UnblockUserCubit>(
        () => _i209.UnblockUserCubit(gh<_i877.UnBlockUserUseCase>()));
    gh.factory<_i883.UserProfileRepositry>(() => _i509.ProfileRepositryImpl(
        userProfileRemoteDataSource: gh<_i55.UserProfileRemoteDataSource>()));
    gh.factory<_i939.GetAllProductsUseCase>(
        () => _i939.GetAllProductsUseCase(gh<_i629.AllProductsRepository>()));
    gh.factory<_i233.MarketerAddRequestInspectionRepositry>(() =>
        _i105.MarketerAddRequestInspectionRepositryImpl(
            marketerAddRequestInspectionRemoteDataSource:
                gh<_i583.MarketerAddRequestInspectionRemoteDataSource>()));
    gh.factory<_i282.AddCommentUseCase>(
        () => _i282.AddCommentUseCase(gh<_i1039.ClientRepositry>()));
    gh.factory<_i886.AddFavoriteUseCase>(
        () => _i886.AddFavoriteUseCase(gh<_i1039.ClientRepositry>()));
    gh.factory<_i367.DeleteFavoriteUseCase>(
        () => _i367.DeleteFavoriteUseCase(gh<_i1039.ClientRepositry>()));
    gh.factory<_i795.GetAllUsersUseCase>(
        () => _i795.GetAllUsersUseCase(gh<_i1039.ClientRepositry>()));
    gh.factory<_i960.GetCommentUseCase>(
        () => _i960.GetCommentUseCase(gh<_i1039.ClientRepositry>()));
    gh.factory<_i590.GetFavoriteUseCase>(
        () => _i590.GetFavoriteUseCase(gh<_i1039.ClientRepositry>()));
    gh.factory<_i384.SearchUsersUseCase>(
        () => _i384.SearchUsersUseCase(gh<_i1039.ClientRepositry>()));
    gh.lazySingleton<_i559.ProductNameRemoteDataSource>(
        () => _i339.ProductNameRemoteDataSourceImpl(gh<_i519.Client>()));
    gh.factory<_i674.MarketerAssignProductUseCase>(() =>
        _i674.MarketerAssignProductUseCase(
            gh<_i863.MarketerAssignGetProductsRepositry>()));
    gh.factory<_i527.MarketerProductsUseCase>(() =>
        _i527.MarketerProductsUseCase(
            gh<_i863.MarketerAssignGetProductsRepositry>()));
    gh.factory<_i871.MarketerSearchUseCase>(() => _i871.MarketerSearchUseCase(
        gh<_i863.MarketerAssignGetProductsRepositry>()));
    gh.factory<_i537.MarketerUnAssignProductUseCase>(() =>
        _i537.MarketerUnAssignProductUseCase(
            gh<_i863.MarketerAssignGetProductsRepositry>()));
    gh.factory<_i598.UpdateMarketerAccountStatusUseCase>(() =>
        _i598.UpdateMarketerAccountStatusUseCase(
            gh<_i863.MarketerAssignGetProductsRepositry>()));
    gh.factory<_i906.FavoriteCubit>(() => _i906.FavoriteCubit(
          gh<_i886.AddFavoriteUseCase>(),
          gh<_i367.DeleteFavoriteUseCase>(),
        ));
    gh.factory<_i966.MarketerInviteCodeReppositry>(() =>
        _i842.MarketerInviteCodeRepositryImpl(
            gh<_i287.MarketerInviteCodeRemoteDataSource>()));
    gh.factory<_i617.ProductRatingRepository>(() =>
        _i199.ProductRatingRepositoryImpl(
            gh<_i616.ProductRatingRemoteDataSource>()));
    gh.lazySingleton<_i523.InstallmentOffersByMarketerIdRepository>(() =>
        _i807.InstallmentOffersByMarketerIdRepositoryImpl(
            gh<_i981.InstallmentOffersByMarketerIdRemoteDataSource>()));
    gh.lazySingleton<_i807.MarketerRequestRepository>(
        () => _i229.PriceOfferRepositoryImpl(gh<_i519.Client>()));
    gh.factory<_i817.AuthenticationRepositry>(() =>
        _i972.AuthenticationRepositryImpl(
            gh<_i430.AuthenticationRemoteDataSource>()));
    gh.factory<_i709.UserFavoritesCubit>(
        () => _i709.UserFavoritesCubit(gh<_i590.GetFavoriteUseCase>()));
    gh.factory<_i700.HomeGetAllInspectionRepositry>(() =>
        _i868.HomeGetAllInspectionRepositryImpl(
            gh<_i77.HomeGetAllInspectionRemoteDataSource>()));
    gh.lazySingleton<_i444.PriceOfferRepository>(() =>
        _i325.PriceOfferRepositoryImpl(
            gh<_i1039.PriceOfferRemoteDataSource>()));
    gh.factory<_i355.AllProductsSearchCubit>(
        () => _i355.AllProductsSearchCubit(gh<_i939.GetAllProductsUseCase>()));
    gh.factory<_i339.InspectorAuthenticationRepositry>(() =>
        _i471.InspectorAuthenticationRepositryImpl(
            gh<_i545.InspectorAuthenticationRemoteDataSource>()));
    gh.factory<_i203.CsRolesRepositry>(
        () => _i551.CsRolesRepositryImpl(gh<_i460.CsRolesRemoteDataSource>()));
    gh.lazySingleton<_i653.PriceOffersByMarketerIdRepository>(() =>
        _i873.PriceOffersByMarketerIdRepositoryImpl(
            gh<_i773.PriceOffersByMarketerIdRemoteDataSource>()));
    gh.factory<_i234.ResetPasswordRepositry>(() =>
        _i584.ResetPasswordsRepositryImpl(
            gh<_i223.ResetPasswordRemoteDataSourse>()));
    gh.factory<_i147.PointsRepositry>(
        () => _i301.Pointsrepositryimpl(gh<_i200.PointsRemoteDataSource>()));
    gh.factory<_i32.BlockInspectorCubit>(
        () => _i32.BlockInspectorCubit(gh<_i808.BlockUserUseCase>()));
    gh.factory<_i338.BlockUserCubit>(
        () => _i338.BlockUserCubit(gh<_i808.BlockUserUseCase>()));
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
    gh.factory<_i620.CommentCubit>(() => _i620.CommentCubit(
          getCommentUseCase: gh<_i960.GetCommentUseCase>(),
          addCommentUseCase: gh<_i282.AddCommentUseCase>(),
        ));
    gh.lazySingleton<_i1010.ProductManagementRemoteDataSource>(
        () => _i1010.ProductManagementRemoteDataSourceImpl(gh<_i519.Client>()));
    gh.factory<_i667.PushNotificationDataSourse>(
        () => _i71.PushNotificationDataSourseImpl(
              gh<_i329.FirebaseMessagingService>(),
              gh<_i1069.ApiManager>(),
            ));
    gh.lazySingleton<_i147.InspectionRequestDetailsRemoteDataSource>(() =>
        _i147.InspectionRequestDetailsRemoteDataSourceImpl(gh<_i519.Client>()));
    gh.factory<_i956.MarketerManagementCubit>(
        () => _i956.MarketerManagementCubit(
              gh<_i91.GetAllMarketersUseCase>(),
              gh<_i871.MarketerSearchUseCase>(),
            ));
    gh.factory<_i395.AddProductRatingUseCase>(() =>
        _i395.AddProductRatingUseCase(gh<_i617.ProductRatingRepository>()));
    gh.factory<_i300.MarketerAssignProductCubit>(() =>
        _i300.MarketerAssignProductCubit(
            gh<_i674.MarketerAssignProductUseCase>()));
    gh.factory<_i404.ProductDetailsRepositry>(() =>
        _i288.ProductDetailsRepositryImpl(
            gh<_i526.ProductDetailsRemoteDataSource>()));
    gh.factory<_i962.AcceptPointRequestUseCase>(
        () => _i962.AcceptPointRequestUseCase(gh<_i147.PointsRepositry>()));
    gh.factory<_i391.AddPointRequestUseCase>(
        () => _i391.AddPointRequestUseCase(gh<_i147.PointsRepositry>()));
    gh.factory<_i286.AdjustUserPointsUseCase>(
        () => _i286.AdjustUserPointsUseCase(gh<_i147.PointsRepositry>()));
    gh.factory<_i341.EditPointPriceUseCase>(
        () => _i341.EditPointPriceUseCase(gh<_i147.PointsRepositry>()));
    gh.factory<_i429.GetAllPointPriceUseCase>(
        () => _i429.GetAllPointPriceUseCase(gh<_i147.PointsRepositry>()));
    gh.factory<_i557.GetAllPointRequestUseCase>(
        () => _i557.GetAllPointRequestUseCase(gh<_i147.PointsRepositry>()));
    gh.factory<_i78.GetBalanceUseCase>(
        () => _i78.GetBalanceUseCase(gh<_i147.PointsRepositry>()));
    gh.factory<_i552.RejectPointRequestUseCase>(
        () => _i552.RejectPointRequestUseCase(gh<_i147.PointsRepositry>()));
    gh.factory<_i991.AdjustCommissionForRolesUseCase>(() =>
        _i991.AdjustCommissionForRolesUseCase(gh<_i147.PointsRepositry>()));
    gh.factory<_i122.AdjustCommissionForTeamLeaderUseCase>(() =>
        _i122.AdjustCommissionForTeamLeaderUseCase(
            gh<_i147.PointsRepositry>()));
    gh.lazySingleton<_i939.GetTopBrandsUseCase>(
        () => _i939.GetTopBrandsUseCase(gh<_i68.TopBrandRepository>()));
    gh.lazySingleton<_i422.AddTopBrandUseCase>(
        () => _i422.AddTopBrandUseCase(gh<_i68.TopBrandRepository>()));
    gh.lazySingleton<_i282.DeleteTopBrandUseCase>(
        () => _i282.DeleteTopBrandUseCase(gh<_i68.TopBrandRepository>()));
    gh.lazySingleton<_i720.EditTopBrandUseCase>(
        () => _i720.EditTopBrandUseCase(gh<_i68.TopBrandRepository>()));
    gh.lazySingleton<_i939.GetTopBrandsUseCase>(
        () => _i939.GetTopBrandsUseCase(gh<_i68.TopBrandRepository>()));
    gh.factory<_i752.AddPointRequestCubit>(() => _i752.AddPointRequestCubit(
        addPointRequestUseCase: gh<_i391.AddPointRequestUseCase>()));
    gh.factory<_i247.SendInstallmentRequestUseCase>(() =>
        _i247.SendInstallmentRequestUseCase(
            gh<_i500.InstallmentRequestRepository>()));
    gh.factory<_i527.SendPriceOfferUseCase>(() =>
        _i527.SendPriceOfferUseCase(gh<_i807.MarketerRequestRepository>()));
    gh.factory<_i898.CommissionRateCubit>(() => _i898.CommissionRateCubit(
          adjustCommissionForRolesUseCase:
              gh<_i991.AdjustCommissionForRolesUseCase>(),
          adjustCommissionForTeamLeaderUseCase:
              gh<_i122.AdjustCommissionForTeamLeaderUseCase>(),
        ));
    gh.factory<_i614.PointPricesCubit>(() => _i614.PointPricesCubit(
          getAllPointPriceUseCase: gh<_i429.GetAllPointPriceUseCase>(),
          editPointPriceUseCase: gh<_i341.EditPointPriceUseCase>(),
        ));
    gh.factory<_i920.ClientRegisterUseCase>(
        () => _i920.ClientRegisterUseCase(gh<_i817.AuthenticationRepositry>()));
    gh.factory<_i456.RegisterUseCase>(
        () => _i456.RegisterUseCase(gh<_i817.AuthenticationRepositry>()));
    gh.factory<_i96.SignInUseCase>(
        () => _i96.SignInUseCase(gh<_i817.AuthenticationRepositry>()));
    gh.factory<_i370.TeamMemberRegister>(
        () => _i370.TeamMemberRegister(gh<_i817.AuthenticationRepositry>()));
    gh.factory<_i280.EmailVerificationUseCase>(() =>
        _i280.EmailVerificationUseCase(gh<_i817.AuthenticationRepositry>()));
    gh.factory<_i1062.ForgetPasswordUseCase>(() =>
        _i1062.ForgetPasswordUseCase(gh<_i817.AuthenticationRepositry>()));
    gh.factory<_i358.ResentEmailVerficationUseCase>(() =>
        _i358.ResentEmailVerficationUseCase(
            gh<_i817.AuthenticationRepositry>()));
    gh.factory<_i217.ResetPasswordUseCase>(
        () => _i217.ResetPasswordUseCase(gh<_i817.AuthenticationRepositry>()));
    gh.factory<_i954.MarketerProductCubit>(
        () => _i954.MarketerProductCubit(gh<_i527.MarketerProductsUseCase>()));
    gh.factory<_i270.AppointAsTeamLeaderCubit>(() =>
        _i270.AppointAsTeamLeaderCubit(gh<_i416.AppointAsTeamLeaderUseCase>()));
    gh.factory<_i789.MarketerRequestCubit>(() => _i789.MarketerRequestCubit(
        gh<_i749.MarketerRequestsForInspectionUseCase>()));
    gh.factory<_i46.AdjustUserPointsCubit>(() => _i46.AdjustUserPointsCubit(
        adjustUserPointsUseCase: gh<_i286.AdjustUserPointsUseCase>()));
    gh.factory<_i629.RateUserCubit>(
        () => _i629.RateUserCubit(gh<_i531.RateUserUseCase>()));
    gh.factory<_i176.MarketerAddRequestInspectionUseCase>(() =>
        _i176.MarketerAddRequestInspectionUseCase(
            gh<_i233.MarketerAddRequestInspectionRepositry>()));
    gh.factory<_i1025.GetAllInspectionByIdUseCase>(() =>
        _i1025.GetAllInspectionByIdUseCase(gh<_i17.MyInspectionsRepository>()));
    gh.factory<_i147.GetMyInspectionsUseCase>(() =>
        _i147.GetMyInspectionsUseCase(gh<_i17.MyInspectionsRepository>()));
    gh.factory<_i708.GetReportDetailsUseCase>(() =>
        _i708.GetReportDetailsUseCase(gh<_i17.MyInspectionsRepository>()));
    gh.lazySingleton<_i110.InspectionRequestDetailsRepository>(() =>
        _i413.InspectionRequestDetailsRepositoryImpl(
            gh<_i147.InspectionRequestDetailsRemoteDataSource>()));
    gh.factory<_i255.ForgetPasswordRepositry>(() =>
        _i423.ForgrtPasswordRepositryImpl(
            gh<_i822.ForgrtPasswordRemoteDataSource>()));
    gh.lazySingleton<_i194.GetInspectionRequestDetailsUseCase>(() =>
        _i194.GetInspectionRequestDetailsUseCase(
            gh<_i110.InspectionRequestDetailsRepository>()));
    gh.factory<_i967.GetInstallmentOffersByMarketerIdUseCase>(() =>
        _i967.GetInstallmentOffersByMarketerIdUseCase(
            gh<_i523.InstallmentOffersByMarketerIdRepository>()));
    gh.factory<_i42.UpdateMarketerStatusCubit>(() =>
        _i42.UpdateMarketerStatusCubit(
            gh<_i598.UpdateMarketerAccountStatusUseCase>()));
    gh.factory<_i385.ProductDetailsUseCase>(
        () => _i385.ProductDetailsUseCase(gh<_i404.ProductDetailsRepositry>()));
    gh.factory<_i244.TopBrandsManagementCubit>(
        () => _i244.TopBrandsManagementCubit(
              gh<_i939.GetTopBrandsUseCase>(),
              gh<_i422.AddTopBrandUseCase>(),
              gh<_i720.EditTopBrandUseCase>(),
              gh<_i282.DeleteTopBrandUseCase>(),
            ));
    gh.factory<_i769.GetAllInspectorsUseCase>(() =>
        _i769.GetAllInspectorsUseCase(
            gh<_i700.HomeGetAllInspectionRepositry>()));
    gh.factory<_i215.SearchInspectorsUseCase>(() =>
        _i215.SearchInspectorsUseCase(
            gh<_i700.HomeGetAllInspectionRepositry>()));
    gh.factory<_i239.MarketerUnassignProductCubit>(() =>
        _i239.MarketerUnassignProductCubit(
            gh<_i537.MarketerUnAssignProductUseCase>()));
    gh.factory<_i273.GetAllInspectionAdminUseCase>(() =>
        _i273.GetAllInspectionAdminUseCase(
            gh<_i700.HomeGetAllInspectionRepositry>()));
    gh.factory<_i747.GetInspectorInspectionsUseCase>(() =>
        _i747.GetInspectorInspectionsUseCase(
            gh<_i700.HomeGetAllInspectionRepositry>()));
    gh.factory<_i826.InspectorHomeSearchUseCase>(() =>
        _i826.InspectorHomeSearchUseCase(
            gh<_i700.HomeGetAllInspectionRepositry>()));
    gh.factory<_i119.InspectorAssignInspectionUseCase>(() =>
        _i119.InspectorAssignInspectionUseCase(
            gh<_i700.HomeGetAllInspectionRepositry>()));
    gh.factory<_i868.InspectorHomeGetAllInspectionUseCase>(() =>
        _i868.InspectorHomeGetAllInspectionUseCase(
            gh<_i700.HomeGetAllInspectionRepositry>()));
    gh.factory<_i1001.RescheduleInspectionUseCase>(() =>
        _i1001.RescheduleInspectionUseCase(
            gh<_i700.HomeGetAllInspectionRepositry>()));
    gh.factory<_i699.SearchInspectionAdminUseCase>(() =>
        _i699.SearchInspectionAdminUseCase(
            gh<_i700.HomeGetAllInspectionRepositry>()));
    gh.factory<_i635.InspectorHomeProductCubit>(() =>
        _i635.InspectorHomeProductCubit(
            gh<_i868.InspectorHomeGetAllInspectionUseCase>()));
    gh.factory<_i745.PostProductCubit>(
        () => _i745.PostProductCubit(gh<_i1002.PostProductUseCase>()));
    gh.factory<_i1006.EditProductCubit>(
        () => _i1006.EditProductCubit(gh<_i151.EditProductUseCase>()));
    gh.lazySingleton<_i129.ProductsByBrandRepository>(() =>
        _i827.ProductsByBrandRepositoryImpl(
            gh<_i677.ProductsByBrandRemoteDataSource>()));
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
    gh.factory<_i775.EditProfileUseCase>(
        () => _i775.EditProfileUseCase(gh<_i883.UserProfileRepositry>()));
    gh.factory<_i305.GetProfileUseCase>(
        () => _i305.GetProfileUseCase(gh<_i883.UserProfileRepositry>()));
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
    gh.factory<_i612.UsersManagementCubit>(() => _i612.UsersManagementCubit(
          gh<_i795.GetAllUsersUseCase>(),
          gh<_i384.SearchUsersUseCase>(),
        ));
    gh.factory<_i348.GetAllMarketerCodesUseCase>(() =>
        _i348.GetAllMarketerCodesUseCase(
            gh<_i966.MarketerInviteCodeReppositry>()));
    gh.factory<_i142.GetTeamMemberUseCase>(() =>
        _i142.GetTeamMemberUseCase(gh<_i966.MarketerInviteCodeReppositry>()));
    gh.factory<_i371.MarketerGenerateCodeUseCase>(() =>
        _i371.MarketerGenerateCodeUseCase(
            gh<_i966.MarketerInviteCodeReppositry>()));
    gh.factory<_i124.TopBrandCubit>(
        () => _i124.TopBrandCubit(gh<_i939.GetTopBrandsUseCase>()));
    gh.factory<_i938.SignInCubit>(
        () => _i938.SignInCubit(gh<_i96.SignInUseCase>()));
    gh.factory<_i756.ProductNameRepository>(() =>
        _i970.ProductNameRepositoryImpl(
            gh<_i559.ProductNameRemoteDataSource>()));
    gh.factory<_i738.InspectionRequestDetailsCubit>(() =>
        _i738.InspectionRequestDetailsCubit(
            gh<_i194.GetInspectionRequestDetailsUseCase>()));
    gh.factory<_i421.GetPriceOffersByMarketerIdUseCase>(() =>
        _i421.GetPriceOffersByMarketerIdUseCase(
            gh<_i653.PriceOffersByMarketerIdRepository>()));
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
    gh.factory<_i329.InviteTeamMemberCubit>(() => _i329.InviteTeamMemberCubit(
        marketerGenerateCodeUseCase: gh<_i371.MarketerGenerateCodeUseCase>()));
    gh.factory<_i865.GetPendingPriceOffersUseCase>(() =>
        _i865.GetPendingPriceOffersUseCase(gh<_i444.PriceOfferRepository>()));
    gh.factory<_i966.UpdatePriceOfferStatusUseCase>(() =>
        _i966.UpdatePriceOfferStatusUseCase(gh<_i444.PriceOfferRepository>()));
    gh.factory<_i214.MarketerRequestDetailsCubit>(() =>
        _i214.MarketerRequestDetailsCubit(
            gh<_i805.MarketerRequestsInspectionDetailsUseCase>()));
    gh.factory<_i852.RescheduleCubit>(
        () => _i852.RescheduleCubit(gh<_i1001.RescheduleInspectionUseCase>()));
    gh.factory<_i413.PriceOfferCubit>(() => _i413.PriceOfferCubit(
          gh<_i865.GetPendingPriceOffersUseCase>(),
          gh<_i966.UpdatePriceOfferStatusUseCase>(),
        ));
    gh.factory<_i809.ResetPasswordCubit>(
        () => _i809.ResetPasswordCubit(gh<_i217.ResetPasswordUseCase>()));
    gh.factory<_i322.EmailVerificationCubit>(() => _i322.EmailVerificationCubit(
          gh<_i280.EmailVerificationUseCase>(),
          gh<_i358.ResentEmailVerficationUseCase>(),
        ));
    gh.factory<_i731.AddProductNameUseCase>(
        () => _i731.AddProductNameUseCase(gh<_i756.ProductNameRepository>()));
    gh.factory<_i479.DeleteProductNameUseCase>(() =>
        _i479.DeleteProductNameUseCase(gh<_i756.ProductNameRepository>()));
    gh.factory<_i90.GetProductNamesUseCase>(
        () => _i90.GetProductNamesUseCase(gh<_i756.ProductNameRepository>()));

    gh.factory<_i90.GetProductNamesUseCase>(
        () => _i90.GetProductNamesUseCase(gh<_i756.ProductNameRepository>()));
    gh.factory<_i479.DeleteProductNameUseCase>(() =>
        _i479.DeleteProductNameUseCase(gh<_i756.ProductNameRepository>()));
    gh.factory<_i208.GetProductsByBrandUseCase>(() =>
        _i208.GetProductsByBrandUseCase(gh<_i129.ProductsByBrandRepository>()));
    gh.factory<_i941.CsRolesUseCase>(
        () => _i941.CsRolesUseCase(gh<_i203.CsRolesRepositry>()));
    gh.factory<_i155.ForgetPasswordCubit>(
        () => _i155.ForgetPasswordCubit(gh<_i1062.ForgetPasswordUseCase>()));
    gh.factory<_i730.RatingCubit>(
        () => _i730.RatingCubit(gh<_i395.AddProductRatingUseCase>()));
    gh.factory<_i710.PriceOffersByMarketerIdCubit>(() =>
        _i710.PriceOffersByMarketerIdCubit(
            gh<_i421.GetPriceOffersByMarketerIdUseCase>()));
    gh.singleton<_i383.ProfileCubit>(
        () => _i383.ProfileCubit(gh<_i305.GetProfileUseCase>()));
    gh.factory<_i551.InstallmentOffersByMarketerIdCubit>(() =>
        _i551.InstallmentOffersByMarketerIdCubit(
            gh<_i967.GetInstallmentOffersByMarketerIdUseCase>()));
    gh.factory<_i257.RegisterCubit>(() => _i257.RegisterCubit(
          gh<_i456.RegisterUseCase>(),
          gh<_i920.ClientRegisterUseCase>(),
          gh<_i370.TeamMemberRegister>(),
        ));
    gh.factory<_i419.BalanceCubit>(() =>
        _i419.BalanceCubit(getBalanceUseCase: gh<_i78.GetBalanceUseCase>()));
    gh.factory<_i800.TeamsAndCodesCubit>(() => _i800.TeamsAndCodesCubit(
          getAllMarketerCodesUseCase: gh<_i348.GetAllMarketerCodesUseCase>(),
          getTeamMemberUseCase: gh<_i142.GetTeamMemberUseCase>(),
        ));
    gh.factory<_i280.MarketerAddRequestCubit>(
        () => _i280.MarketerAddRequestCubit(
              gh<_i176.MarketerAddRequestInspectionUseCase>(),
              gh<_i527.SendPriceOfferUseCase>(),
              gh<_i247.SendInstallmentRequestUseCase>(),
            ));
    gh.lazySingleton<_i127.ProductManagementRepository>(() =>
        _i744.ProductManagementRepositoryImpl(
            gh<_i1010.ProductManagementRemoteDataSource>()));
    gh.factory<_i411.InspectionManagementCubit>(
        () => _i411.InspectionManagementCubit(
              gh<_i273.GetAllInspectionAdminUseCase>(),
              gh<_i699.SearchInspectionAdminUseCase>(),
            ));
    gh.factory<_i356.MarketerReportDetailsCubit>(() =>
        _i356.MarketerReportDetailsCubit(gh<_i708.GetReportDetailsUseCase>()));
    gh.factory<_i447.ProductDetailsCubit>(
        () => _i447.ProductDetailsCubit(gh<_i385.ProductDetailsUseCase>()));
    gh.factory<_i1049.InspectorAssignProductCubit>(() =>
        _i1049.InspectorAssignProductCubit(
            gh<_i119.InspectorAssignInspectionUseCase>()));
    gh.singleton<_i235.EditProfileCubit>(
        () => _i235.EditProfileCubit(gh<_i775.EditProfileUseCase>()));
    gh.factory<_i203.InspectorRegisterCubit>(() =>
        _i203.InspectorRegisterCubit(gh<_i33.InspectorRegisterUseCase>()));
    gh.factory<_i74.ProductsByBrandCubit>(
        () => _i74.ProductsByBrandCubit(gh<_i208.GetProductsByBrandUseCase>()));
    gh.factory<_i881.TeamChatListCubit>(
        () => _i881.TeamChatListCubit(gh<_i142.GetTeamMemberUseCase>()));
    gh.factory<_i186.GetNotificationUseCase>(() =>
        _i186.GetNotificationUseCase(gh<_i1072.PushNotificationRepositry>()));
    gh.factory<_i349.PostNotificationUseCase>(() =>
        _i349.PostNotificationUseCase(gh<_i1072.PushNotificationRepositry>()));
    gh.factory<_i172.PushNotificationUseCase>(() =>
        _i172.PushNotificationUseCase(gh<_i1072.PushNotificationRepositry>()));
    gh.factory<_i873.HomeGetAllProductsUseCase>(() =>
        _i873.HomeGetAllProductsUseCase(
            gh<_i77.HomeGetAllProductsRepositry>()));
    gh.factory<_i43.MarketerSearchProductsUseCase>(() =>
        _i43.MarketerSearchProductsUseCase(
            gh<_i77.HomeGetAllProductsRepositry>()));
    gh.factory<_i78.ProductNamesCubit>(() => _i78.ProductNamesCubit(
          gh<_i90.GetProductNamesUseCase>(),
          gh<_i731.AddProductNameUseCase>(),
          gh<_i479.DeleteProductNameUseCase>(),
        ));
    gh.factory<_i1031.PushNotificationCubit>(() => _i1031.PushNotificationCubit(
          gh<_i172.PushNotificationUseCase>(),
          gh<_i349.PostNotificationUseCase>(),
        ));
    gh.factory<_i225.GetNotificationCubit>(
        () => _i225.GetNotificationCubit(gh<_i186.GetNotificationUseCase>()));
    gh.factory<_i245.ProductNamesDropdownCubit>(() =>
        _i245.ProductNamesDropdownCubit(gh<_i90.GetProductNamesUseCase>()));
    gh.factory<_i578.DeleteProductUseCase>(() =>
        _i578.DeleteProductUseCase(gh<_i127.ProductManagementRepository>()));
    gh.factory<_i683.GetAllProductsUseCase>(() =>
        _i683.GetAllProductsUseCase(gh<_i127.ProductManagementRepository>()));
    gh.lazySingleton<_i508.GetProductManagementDetailsUseCase>(() =>
        _i508.GetProductManagementDetailsUseCase(
            gh<_i127.ProductManagementRepository>()));
    gh.factory<_i495.RoleCsCubit>(
        () => _i495.RoleCsCubit(csRolesUseCase: gh<_i941.CsRolesUseCase>()));
    gh.factory<_i27.ProductsManagementCubit>(
        () => _i27.ProductsManagementCubit(gh<_i683.GetAllProductsUseCase>()));
    gh.factory<_i710.ProductDetailsCubit>(() => _i710.ProductDetailsCubit(
        gh<_i508.GetProductManagementDetailsUseCase>()));
    gh.factory<_i158.MarketerHomeProductCubit>(
        () => _i158.MarketerHomeProductCubit(
              gh<_i873.HomeGetAllProductsUseCase>(),
              gh<_i43.MarketerSearchProductsUseCase>(),
            ));
    gh.factory<_i411.DeleteProductCubit>(
        () => _i411.DeleteProductCubit(gh<_i578.DeleteProductUseCase>()));
    return this;
  }
}

class _$InjectableModule extends _i109.InjectableModule {}
