import 'package:ankh_project/data/models/user_model.dart';
import 'package:ankh_project/feauture/authentication/register/controller/register_cubit.dart';
import 'package:ankh_project/feauture/authentication/signin/controller/sigin_cubit.dart';
import 'package:ankh_project/feauture/onboarding/onboarding.dart';
import 'package:ankh_project/firebase_service/firestore_service/firestore_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'api_service/di/di.dart';
import 'core/customized_widgets/reusable_widgets/custom_dialog.dart';
import 'core/theme/my_app_theme.dart';
import 'feauture/authentication/email_verfication/email_verfication_screen.dart';
import 'feauture/authentication/forgrt_password/forget_password/forget_password_screen.dart';
import 'feauture/authentication/forgrt_password/set_new_password/set_new_password_screen.dart';
import 'feauture/authentication/forgrt_password/verify_otp/verify_otp_screen/verify_otp_screen.dart';
import 'feauture/authentication/register/controller/register_states.dart';
import 'feauture/authentication/register/register _screen.dart';
import 'feauture/authentication/signin/controller/sigin_states.dart';
import 'feauture/authentication/signin/signin_screen.dart';
import 'feauture/authentication/user_cubit/user_cubit.dart';
import 'feauture/choose_cs_role/choose_cs_role_cubit/choose_cs_role_cubit.dart';
import 'feauture/choose_cs_role/choose_cs_role_cubit/choose_cs_type.dart';
import 'feauture/choose_role/choose_role_cubit/choose_role_cubit.dart';
import 'feauture/choose_role/choose_role_screen.dart';
import 'feauture/home_screen/bottom_nav_bar.dart';
import 'feauture/push_notification/push_notification_controller/push_notification_cubit.dart';
import 'feauture/welcome_screen/welcome_screen.dart';
import 'firebase_options.dart';
import 'firebase_service/notification_service/fcm_api_service.dart';
import 'firebase_service/notification_service/local notification.dart';
import 'firebase_service/notification_service/push notification_manager.dart';
import 'l10n/app_localizations.dart';
import 'l10n/languge_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();



  await Firebase.initializeApp();
   configureDependencies();

  await getIt.allReady();
  await ScreenUtil.ensureScreenSize();
  await LocalNotification().initNotification();

  await FcmApi().initNotification();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LanguageCubit()),

        BlocProvider(create: (context) => UserCubit()),
        BlocProvider(create: (context) => RoleCubit()),
        BlocProvider(create: (context) => RoleCsCubit()),

      ],

      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<LanguageCubit>().state;

    return ScreenUtilInit(
      designSize: const Size(428, 926.76),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
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
          initialRoute:  OnBoarding.onBoardingRouteName,
          routes:{
            OnBoarding.onBoardingRouteName:(context) =>  OnBoarding(),
            WelcomeScreen.welcomeScreenRouteName:(context) =>  WelcomeScreen(),
            RegisterScreen.registerScreenRouteName:(context) =>  RegisterScreen(),
            ChooseRoleScreen.chooseRoleScreenRouteName:(context) =>  ChooseRoleScreen(),
            ChooseCsTypeScreen.chooseCsTypeScreenRouteName:(context) =>  ChooseCsTypeScreen(),
            SignInScreen.signInScreenRouteName:(context) =>  SignInScreen(),
            EmailVerficationScreen.emailVerficationScreenRouteName:(context) =>  EmailVerficationScreen(),
            ForgetPasswordScreen.forgetPasswordScreenRouteName:(context) =>  ForgetPasswordScreen(),
            OtpVerficationScreen.otpVerficationScreenRouteName:(context) =>  OtpVerficationScreen(),
            ResetPasswordScreen.resetPasswordScreenRouteName:(context) =>  ResetPasswordScreen(),
            BottomNavBar.bottomNavBarRouteName:(context) =>  BottomNavBar(),

          } ,
        );
      },
    );
  }
}

/*
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  RegisterCubit registerViewModel = getIt<RegisterCubit>();
  SignInCubit signInViewModel = getIt<SignInCubit>();
  PushNotificationCubit pushNotificationCubit  = getIt<PushNotificationCubit>();

  late List<String> devicesToken;

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<LanguageCubit>().state;
    final currentUser = context.read<UserCubit>().state;

    return BlocListener<SignInCubit, SignInState>(
      bloc: signInViewModel,
      listener: (context, state) {
        if (state is SignInLoading) {
          CustomDialog.loading(
            context: context,
            message: "LOADING",
            cancelable: false,
          );
        } else if (state is SignInFailure) {
          Navigator.of(context).pop();
          CustomDialog.positiveButton(
            context: context,
            title: "error",
            message: state.error.message,
          );
        } else if (state is SignInSuccess) {
          Navigator.of(context).pop();
          CustomDialog.positiveButton(
            cancelable: true,
            context: context,
            title: "success",
            message: "SUCCESS",
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            //
            // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
            // action in the IDE, or press "p" in the console), to see the
            // wireframe for each widget.
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(AppLocalizations.of(context)!.language),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),

              ElevatedButton(
                onPressed: () async {
                  final user = await signInViewModel.signIn();

                  var tokens = await FireBaseUtilies.getDeviceToken(
                    "${user?.uid}",
                  );
                  devicesToken = tokens;
                },
                child: Text('Get Device Token First'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await pushNotificationCubit.sendNotificationToAll(
                    tokens: devicesToken,
                    title: 'New Task Assigned',
                    body: 'You have a new task to complete!!!',
                  );
                  print("notification Sent to $devicesToken");
                },
                child: Text('Send Notification to User'),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            onSignInClick();
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  void onSignInClick() async {
    final user = await signInViewModel.signIn();
    print(user?.name ?? " user name is empty");
    if (user != null) {
      context.read<UserCubit>().changeUser(user);
      signInViewModel.signIn();
    }
  }
}
*/
