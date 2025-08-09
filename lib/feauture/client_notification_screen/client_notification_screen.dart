import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/feauture/client_notification_screen/notification_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' ;

import '../../api_service/di/di.dart';
import '../../core/customized_widgets/reusable_widgets/custom_loading.dart';
import '../../core/customized_widgets/shared_preferences .dart';
import '../../domain/entities/notification_entity.dart';
import '../../l10n/app_localizations.dart';
import '../authentication/user_controller/user_cubit.dart';
import '../dashboard/notification/push_notification/cubit/get_notification_cubit.dart';

class ClientNotificationScreen extends StatefulWidget {
  const ClientNotificationScreen({super.key});

  @override
  State<ClientNotificationScreen> createState() => _ClientNotificationScreenState();
}

class _ClientNotificationScreenState extends State<ClientNotificationScreen> {
  GetNotificationCubit getNotificationCubit = getIt<GetNotificationCubit>();
  String? token;

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    try {
      // Step 1: Get user ID from UserCubit
      final userState = context.read<UserCubit>().state;
      final userId = userState?.id;

      if (userId == null || userId.isEmpty) {
        debugPrint("User ID is null or empty");
        getNotificationCubit.emit(GetNotificationFailure(errorMessage: "User not authenticated"));
        return;
      }

      // Step 2: Load token (this is async)
      final token = await SharedPrefsManager.getData(key: 'user_token');
      if (token == null || token.isEmpty) {
        debugPrint("Token is null or empty");
        getNotificationCubit.emit(GetNotificationFailure(errorMessage: "Authentication token missing"));
        return;
      }

      // Step 3: Now both are ready — fetch notifications
      getNotificationCubit.getNotifications(userId: userId, token: token);
      _loadToken();
    } catch (e) {
      debugPrint("Error loading notifications: $e");
      getNotificationCubit.emit(GetNotificationFailure(errorMessage: "Failed to load notifications"));
    }
  }

  Future<void> _loadToken() async {
    final fetchedToken = await SharedPrefsManager.getData(key: 'user_token');
    setState(() {
      token = fetchedToken;
    });
    print("👤 User token: $token");
  }


  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;



    return Scaffold(

      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(AppLocalizations.of(context)!.notifications),
        centerTitle: true,
        backgroundColor: ColorManager.lightprimary,
      ),
      body: BlocBuilder<GetNotificationCubit, GetNotificationState>(
        bloc: getNotificationCubit,
        builder: (context, state) {
          if (state is GetNotificationLoading) {
            return const CustomLoading();
          } else if (state is GetNotificationSuccess) {
            return _buildNotificationsList(state.notifications);
          } else if (state is GetNotificationEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_none,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n.noNotificationsFound,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            );
          } else if (state is GetNotificationFailure) {
            final user = context.read<UserCubit>().state;
            final userId = user?.id;


            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    state.error?.errorMessage ?? 'An error occurred',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      await _loadNotifications();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.lightprimary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: Text(l10n.tryAgain),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildNotificationsList(List<NotificationEntity> notifications) {
    return RefreshIndicator(
      onRefresh: () async {
        await _loadNotifications();
      },
      color: ColorManager.lightprimary,
      backgroundColor: Colors.white,
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return NotificationCard(notification: notification);
        },
      ),
    );
  }
}
