import 'package:ankh_project/feauture/dashboard/installment_requests_management/cubit/installment_pending_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'api_service/di/di.dart';
import 'core/customized_widgets/shared_preferences .dart';
import 'core/theme/my_app_theme.dart';
import 'domain/use_cases/get_team_member_use_case.dart';
import 'feauture/authentication/email_verfication/email_verfication_screen.dart';
import 'feauture/authentication/forgrt_password/forget_password/forget_password_screen.dart';
import 'feauture/authentication/forgrt_password/set_new_password/reset_password.dart';
import 'feauture/authentication/forgrt_password/verify_otp/verify_otp_screen/verify_otp_screen.dart';
import 'feauture/authentication/register/register _screen.dart';
import 'feauture/chat_screen/chat_screen.dart';
import 'feauture/chat_screen/cubit/team_chat_list_cubit.dart';
import 'feauture/chat_screen/team_chat_list_screen.dart';
import 'feauture/choose_cs_role/choose_cs_role_cubit/choose_cs_role_cubit.dart';
import 'feauture/dashboard/dashboard_main screen _drawer/dashboard_main_screen _drawer.dart';
import 'feauture/dashboard/inspector_management/cubit/inspector_management_cubit.dart';
import 'feauture/dashboard/inspector_management/inspector_details_screen.dart';
import 'feauture/dashboard/marketer_mangemnet/cubit/marketer_management_cubit.dart';
import 'feauture/dashboard/marketer_mangemnet/cubit/rate_user_cubit.dart';
import 'feauture/dashboard/marketer_mangemnet/marketer_details_screen.dart';
import 'feauture/dashboard/products_management/add_new_product/cubit/post_product_cubit.dart';
import 'feauture/dashboard/products_management/product_details_screen/cubit/product_details_cubit.dart';
import 'feauture/dashboard/products_management/product_details_screen/delete_product/delete_product_cubit.dart';
import 'feauture/dashboard/users_management/user_details_screen.dart';
import 'feauture/home_screen/top_brands/cubit/top_brand_cubit.dart';
import 'feauture/inspector_screen/authentication/inspector_register_screen.dart';
import 'feauture/authentication/signin/signin_screen.dart';
import 'feauture/authentication/user_controller/user_cubit.dart';
import 'feauture/choose_cs_role/choose_cs_role_cubit/choose_cs_type.dart';
import 'feauture/choose_role/choose_role_cubit/choose_role_cubit.dart';
import 'feauture/choose_role/choose_role_screen.dart';
import 'feauture/details_screen/all_Images_screen.dart';
import 'feauture/details_screen/details_screen.dart';
import 'feauture/home_screen/bottom_nav_bar.dart';
import 'feauture/inspector_screen/my_inspections/my_inspections_cubit.dart';
import 'feauture/invite_team_member/invite_team_member_screen.dart';
import 'feauture/marketer_price_offers/cubit/price_offers_by_marketer_id_cubit.dart';
import 'feauture/onboarding/onboarding.dart';
import 'feauture/request_inspection_screen/cubit/marketer_add_request_cubit.dart';
import 'feauture/teams_and_codes/teams_and_codes_screen.dart';
import 'feauture/marketer_Reports/marketer_report_details/report_details.dart';
import 'feauture/marketer_Reports/marketer_reports_screen.dart';
import 'feauture/myrequest/my_request_details/my_request_details.dart';
import 'feauture/profile/cubit/profile_cubit.dart';
import 'feauture/profile/cubit/edit_profile_cubit.dart';
import 'feauture/profile/profile_screen.dart';
import 'feauture/profile/edit_profile_screen.dart';
import 'feauture/request_inspection_screen/confirm_request_screen.dart';
import 'feauture/request_inspection_screen/request_inspection_screen.dart';
import 'feauture/request_inspection_screen/request_submitted.dart';
import 'feauture/welcome_screen/welcome_screen.dart';
import 'firebase_options.dart';
import 'firebase_service/notification_service/fcm_api_service.dart';
import 'firebase_service/notification_service/local notification.dart';
import 'firebase_service/notification_service/push notification_manager.dart';
import 'l10n/app_localizations.dart';
import 'l10n/languge_cubit.dart';
import '/api_service/di/injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  configureDependencies();
  await getIt.allReady();
  await getIt<UserCubit>().loadUserFromPrefs();

  await ScreenUtil.ensureScreenSize();
  await LocalNotification().initNotification();
  await FcmApi().initNotification();

  final String? token = await SharedPrefsManager.getData(key: 'user_token');
  final String? id = await SharedPrefsManager.getData(key: 'user_id');

  // Fetch profile after initializing the app
  if (token != null && id != null) {
    print("👤 Token12: $token");
    print("👤 User ID12: $id");
    final profileCubit = getIt<ProfileCubit>();
    // Start loading state immediately
    profileCubit.preloadProfileData();
    // Fetch profile data
    await profileCubit.fetchProfile(token, id);
  }

  final user = getIt<UserCubit>().state;
  final String? role = user?.roles?.isNotEmpty == true
      ? user!.roles!.first
      : null;

  runApp(

    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LanguageCubit()),
        BlocProvider<UserCubit>.value(value: getIt<UserCubit>()),
        BlocProvider(create: (context) => RoleCubit()),
        BlocProvider(create: (context) => getIt<RoleCsCubit>()),
        BlocProvider(create: (_) => getIt<ProfileCubit>()),
        BlocProvider(create: (_) => getIt<MarketerManagementCubit>()),
        BlocProvider(create: (_) => getIt<InspectorManagementCubit>()),
        BlocProvider(create: (_) => getIt<RateUserCubit>()),

        BlocProvider(create: (context) => getIt<ProfileCubit>()),

        BlocProvider(create: (context) => getIt<MyInspectionsCubit>()),
        BlocProvider(create: (context) => getIt<MarketerAddRequestCubit>()),
        BlocProvider(
          create: (context) =>
              getIt<InstallmentPendingCubit>()..fetchPendingInstallments(),
        ),
        BlocProvider(create: (_) => getIt<ProductDetailsCubit>()),
        BlocProvider(create: (_) => getIt<DeleteProductCubit>()),
        BlocProvider<PostProductCubit>(
          create: (_) => getIt<PostProductCubit>(),
        ),
        BlocProvider<TeamChatListCubit>(
          create: (_) => getIt<TeamChatListCubit>(),
        ),
        BlocProvider<TopBrandCubit>(create: (_) => getIt<TopBrandCubit>()),
      ],
      child: MyApp(isLoggedIn: token != null, userRole: role),
    ),
  );
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.isLoggedIn, this.userRole});

  final bool isLoggedIn;
  final String? userRole;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _initDynamicLinks();
  }

  Future<void> _initDynamicLinks() async {
    // Handle dynamic link when app is opened from terminated state
    final PendingDynamicLinkData? initialLink = await FirebaseDynamicLinks
        .instance
        .getInitialLink();
    _handleDynamicLink(initialLink?.link);

    // Handle dynamic link when app is opened from background
    FirebaseDynamicLinks.instance.onLink
        .listen((dynamicLinkData) {
          _handleDynamicLink(dynamicLinkData.link);
        })
        .onError((error) {
          print('Dynamic Link Failed: $error');
        });
  }

  void _handleDynamicLink(Uri? uri) {
    if (uri == null) return;

    print('Received dynamic link: $uri');

    // Unwrap Firebase link if needed
    final deepLink = uri.queryParameters['link'];
    if (deepLink != null) {
      final innerUri = Uri.parse(deepLink);
      print('Unwrapped deep link: $innerUri');
      _handleDynamicLink(innerUri);
      return;
    }

    if (uri.path == '/reset-password') {
      final token = uri.queryParameters['token'];
      final email = uri.queryParameters['email'];

      if (token != null && email != null) {
        print('Deep Link - Email: $email, Token: $token');
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pushNamed(
            ResetPasswordScreen.resetPasswordScreenRouteName,
            arguments: {'email': email, 'token': token},
          );
        });
      } else {
        print('Invalid link: missing token or eemail');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<LanguageCubit>().state;
    String initialRoute;
    if (!widget.isLoggedIn) {
      initialRoute = '/';
    } else if (widget.userRole == 'Admin') {
      initialRoute = DashboardMainScreen.mainScreenRouteName;
    } else {
      initialRoute = BottomNavBar.bottomNavBarRouteName;
    }

    return ScreenUtilInit(

      designSize: const Size(428, 926.76),

      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            ...AppLocalizations.localizationsDelegates,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          locale: locale,
          title: 'Flutter Demo',
          theme: MyAppTheme.lightTheme(context),
          builder: (context, child) => child!,

          initialRoute: initialRoute,
          routes: {
            '/': (context) => OnBoarding(),
            OnBoarding.onBoardingRouteName: (context) => OnBoarding(),
            WelcomeScreen.welcomeScreenRouteName: (context) => WelcomeScreen(),
            RegisterScreen.registerScreenRouteName: (context) =>
                RegisterScreen(),
            InspectorRegisterScreen.inspectorRegisterScreenRouteName:
                (context) => InspectorRegisterScreen(),
            ChooseRoleScreen.chooseRoleScreenRouteName: (context) =>
                ChooseRoleScreen(),
            ChooseCsTypeScreen.chooseCsTypeScreenRouteName: (context) =>
                ChooseCsTypeScreen(),
            SignInScreen.signInScreenRouteName: (context) => SignInScreen(),
            EmailVerficationScreen.emailVerficationScreenRouteName: (context) =>
                EmailVerficationScreen(),
            ForgetPasswordScreen.forgetPasswordScreenRouteName: (context) =>
                ForgetPasswordScreen(),
            OtpVerficationScreen.otpVerficationScreenRouteName: (context) =>
                OtpVerficationScreen(),
            ResetPasswordScreen.resetPasswordScreenRouteName: (context) {
              final args =
                  ModalRoute.of(context)!.settings.arguments
                      as Map<String, String>;

              return ResetPasswordScreen(
                email: args['email']!,
                token: args['token']!,
              );
            },
            BottomNavBar.bottomNavBarRouteName: (context) {
              final args =
                  ModalRoute.of(context)?.settings.arguments
                      as Map<String, dynamic>?;
              final initialIndex = args?['initialIndex'] as int? ?? 0;
              return BottomNavBar(initialIndex: initialIndex);
            },
            MyRequestDetails.myRequestDetailsRouteName: (context) =>
                MyRequestDetails(),
            DetailsScreen.detailsScreenRouteName: (context) => DetailsScreen(),
            //AllImagesScreen.allImagesScreenRouteName: (context) => AllImagesScreen(imageUrl: '',),
            RequestInspectionScreen.requestInspectionScreenRouteName:
                (context) => RequestInspectionScreen(),
            ConfirmRequestScreen.confirmRequestRouteName: (context) =>
                ConfirmRequestScreen(),
            RequestSubmittedScreen.requestSubmittedRouteName: (context) =>
                RequestSubmittedScreen(),
            AccountScreen.accountScreenRouteName: (context) => AccountScreen(),
            EditProfileScreen.routeName: (context) => EditProfileScreen(),
            MarketerReportDetails.reportDetailsRouteName: (context) =>
                MarketerReportDetails(),
            DashboardMainScreen.mainScreenRouteName: (context) =>
                DashboardMainScreen(),
            UserDetailsScreen.routeName: (context) => UserDetailsScreen(),
            MarketerDetailsScreen.routeName: (context) =>
                MarketerDetailsScreen(),
            InspectorDetailsScreen.routeName: (context) =>
                InspectorDetailsScreen(),
            InviteTeamMemberScreen.inviteTeamMemberRouteName: (context) =>
                InviteTeamMemberScreen(),
            TeamsAndCodesScreen.teamsAndCodesRouteName: (context) =>
                TeamsAndCodesScreen(),
            TeamChatScreen.routeName: (context) => TeamChatScreen(),
            TeamChatListScreen.routeName: (context) => BlocProvider(
        create: (context) => TeamChatListCubit(getIt<GetTeamMemberUseCase>()),
        child: const TeamChatListScreen(),
      ),
            
          },
        );
      },
    );
  }
}
