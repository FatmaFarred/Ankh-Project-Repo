import 'dart:async';
import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/feauture/client_favourite_screen/favourite_product_card.dart';
import 'package:ankh_project/feauture/home_screen/bottom_nav_bar.dart';
import 'package:ankh_project/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../api_service/di/di.dart';
import '../../core/constants/assets_manager.dart';
import '../../data/models/authentication_response_dm.dart';
import '../authentication/user_controller/user_cubit.dart';
import '../dashboard/users_management/cubit/user_favorites_cubit.dart';
import '../dashboard/users_management/cubit/user_favorites_states.dart';
import '../details_screen/details_screen.dart';
import '../home_screen/cubit/add_favorite_cubit.dart';
import '../home_screen/cubit/add_remove_favorite_state.dart';

class ClientFavouriteScreen extends StatefulWidget {
  const ClientFavouriteScreen({super.key});

  @override
  State<ClientFavouriteScreen> createState() => _ClientFavouriteScreenState();
}

class _ClientFavouriteScreenState extends State<ClientFavouriteScreen> with WidgetsBindingObserver {
   UserFavoritesCubit userFavoritesCubit=getIt<UserFavoritesCubit>();
   FavoriteCubit  deleteFavoriteCubit=getIt<FavoriteCubit>();
   Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Initial refresh after a short delay to ensure context is ready
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        _refreshFavorites();
      }
    });
    
    // Start periodic refresh every 5 seconds
    _refreshTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      if (mounted) {
        print("⏰ Periodic refresh triggered");
        _refreshFavorites();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Refresh favorites when dependencies change (like when navigating back to this screen)
    print("🔄 didChangeDependencies called");
    _refreshFavorites();
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      // Refresh favorites when app resumes
      _refreshFavorites();
    }
  }

  void _showCustomOverlay(BuildContext context, String message, {bool isError = false}) {
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).size.height * 0.7,
        left: 20,
        right: 20,

        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: REdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: isError ? Colors.red.shade100 : ColorManager.lightprimary,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: isError ? Colors.red.shade300 : ColorManager.lightprimary,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isError ? Icons.error_outline : Icons.check_circle_outline,
                  color: isError ? Colors.red.shade700 : Colors.green.shade700,
                  size: 24.sp,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    message,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: isError ? ColorManager.white :ColorManager.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry);

    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }

  void _refreshFavorites() {
    final user = context.read<UserCubit>().state;
    final userId = user?.id;
    print("🔄 Refreshing favorites - User ID: $userId");
    if (userId != null && userId.isNotEmpty) {
      print("✅ Calling fetchUserFavorites with userId: $userId");
      userFavoritesCubit.fetchUserFavorites(userId);
    } else {
      print("❌ User ID is null or empty: $userId");
    }
  }

  @override


  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserCubit>().state;

    return BlocListener<UserCubit, UserDm?>(
      listener: (context, userState) {
        // Refresh favorites when user state changes (login/logout)
        final userId = userState?.id;
        if (userId != null && userId.isNotEmpty) {
          print("👤 User state changed, refreshing favorites");
          _refreshFavorites();
        }
      },
      child: BlocListener<FavoriteCubit, FavoriteToggleState>(
      bloc: deleteFavoriteCubit,
      listener: (context, state) {
        if (state is FavoriteSuccess) {
          _showCustomOverlay(context, state.response);
          // Refresh favorites after successful deletion
          _refreshFavorites();
        } else if (state is FavoriteFailure) {
          _showCustomOverlay(
            context, 
            state.error?.errorMessage ?? "Error removing from favorites",
            isError: true
          );
        }
      },

      child:  Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(CupertinoIcons.back),
              color: Colors.white,
              onPressed: () {
                Navigator.pushReplacementNamed(context, BottomNavBar.bottomNavBarRouteName);
              },
            ),
            title: Text(AppLocalizations.of(context)!.myFavorites),
            centerTitle: true,
            backgroundColor: ColorManager.lightprimary,
          ),
          body:  BlocBuilder<UserFavoritesCubit, UserFavoritesState>(
            bloc: userFavoritesCubit,
            builder: (context, state) {
              if (state is UserFavoritesLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is UserFavoritesSuccess) {
                return RefreshIndicator(
                  onRefresh: () async {
                    _refreshFavorites();
                  },
                  child: state.favoritesList.isEmpty
                      ? ListView(
                          children: [
                            SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.favorite_border,
                                    size: 80.sp,
                                    color: ColorManager.lightprimary.withOpacity(0.5),
                                  ),
                                  SizedBox(height: 16.h),
                                  Text(
                                    AppLocalizations.of(context)!.noFavoritesFound,
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: ColorManager.darkGrey,
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    'Add products to your favorites to see them here',
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: ColorManager.hintColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : ListView.separated(
                          padding: REdgeInsets.all(20.0),
                          physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.favoritesList.length,
                          separatorBuilder: (context, index) => SizedBox(height: 10.h),
                          itemBuilder: (context, index) {
                            final product = state.favoritesList[index];
                            print(product.productId);
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailsScreen(),
                                    settings: RouteSettings(
                                      arguments: product.productId,
                                    ),
                                  ),
                                );
                              },
                              child: FavouriteProductCard(
                                onDelete: () {
                                  deleteFavoriteCubit.removeFavorite(
                                    productId: product.productId ?? 0,
                                    userId: user?.id ?? ''
                                  );
                                },
                                product: product,
                              ),
                            );
                          },
                        ),
                );
              } else if (state is UserFavoritesEmpty) {
                return RefreshIndicator(
                  onRefresh: () async {
                    _refreshFavorites();
                  },
                  child: ListView(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.favorite_border,
                              size: 80.sp,
                              color: ColorManager.lightprimary.withOpacity(0.5),
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              AppLocalizations.of(context)!.noFavoritesFound,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: ColorManager.darkGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state is UserFavoritesError) {
                return RefreshIndicator(
                  onRefresh: () async {
                    _refreshFavorites();
                  },
                  child: ListView(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 80.sp,
                              color: ColorManager.error,
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              state.error.errorMessage ?? "Error loading favorites",
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: ColorManager.error,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 16.h),
                            ElevatedButton(
                              onPressed: () {
                                userFavoritesCubit.fetchUserFavorites(user?.id ?? '');
                              },
                              child: Text(AppLocalizations.of(context)!.tryAgain),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
