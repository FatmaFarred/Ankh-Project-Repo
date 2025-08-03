import 'package:ankh_project/core/constants/assets_manager.dart';
import 'package:ankh_project/domain/entities/product_entity.dart';
import 'package:ankh_project/domain/use_cases/get_favorite_use_case.dart';
import 'package:ankh_project/feauture/details_screen/controller/product_details_states.dart';
import 'package:ankh_project/feauture/details_screen/widgets/add_comment_section.dart';
import 'package:ankh_project/feauture/details_screen/widgets/status_section.dart';
import 'package:ankh_project/feauture/details_screen/widgets/comment_list_widget.dart';
import 'package:ankh_project/feauture/details_screen/cubit/comment_cubit.dart';
import 'package:ankh_project/feauture/request_inspection_screen/request_inspection_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import 'package:ankh_project/feauture/home_screen/section_header.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../../api_service/di/di.dart';
import '../../core/customized_widgets/reusable_widgets/custom_dialog.dart';
import '../../l10n/app_localizations.dart';
import '../authentication/user_controller/user_cubit.dart';
import '../home_screen/cubit/add_favorite_cubit.dart';
import '../home_screen/cubit/add_remove_favorite_state.dart';
import '../welcome_screen/welcome_screen.dart';
import 'controller/product_details_cubit.dart';
import 'widgets/car_detail_info.dart';
import 'widgets/section_title.dart';
import 'widgets/support_team_section.dart';
import 'dart:async';

class DetailsScreen extends StatefulWidget {
  static const String detailsScreenRouteName = "detailsScreen";
  final bool? showButton  ; // Control visibility of the button

  const DetailsScreen({super.key, this.showButton= false});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  final favoriteCubit = getIt<FavoriteCubit>();
  Timer? _refreshTimer;

  void _showCustomOverlay(BuildContext context, String message,
      {bool isError = false}) {
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) =>
          Positioned(
            top: MediaQuery
                .of(context)
                .size
                .height * 0.7,
            left: 20,
            right: 20,
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: REdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  color: isError ? Colors.red.shade100 : ColorManager
                      .lightprimary,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: isError ? Colors.red.shade300 : ColorManager
                        .lightprimary,
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
                      isError ? Icons.error_outline : Icons
                          .check_circle_outline,
                      color: isError ? Colors.red.shade700 : ColorManager.white,
                      size: 24.sp,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        message,
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: isError ? Colors.red.shade700 : ColorManager
                              .white,
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


  @override
  void dispose() {
    _refreshTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }


  Widget _buildSmallText(String text, Color color) =>
      Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: color,
        ),
      );

  Widget _buildSectionDivider() =>
      Divider(thickness: 1, color: const Color(0xff91929526).withOpacity(0.15));

  final productDetailsCubit = getIt<ProductDetailsCubit>();
  final GetFavoriteUseCase getFavoritesUseCase = getIt<GetFavoriteUseCase>();
  final CommentCubit commentCubit = getIt<CommentCubit>();

  num? productId;


  @override
  void initState() {
    super.initState();
    print('🔍 DetailsScreen: initState called');
    // Delay reading arguments until context is ready
    Future.microtask(() {
      final args = ModalRoute
          .of(context)
          ?.settings
          .arguments as num?;
      if (args != null) {
        print('🔍 DetailsScreen: Product ID received: $args');
        setState(() {
          productId = args;
        });
        productDetailsCubit.fetchDetails(productId: args);
        print('🔍 DetailsScreen: Calling fetchComments for productId: $args');
        commentCubit.fetchComments(args);

        // Start automatic refresh timer
        _startRefreshTimer();
      } else {
        print('❌ DetailsScreen: No product ID received');
      }
    });
  }

  void _startRefreshTimer() {
    _refreshTimer?.cancel();
    _refreshTimer = Timer.periodic(const Duration(seconds: 60), (timer) {
      if (productId != null) {
        print('🔄 Auto-refreshing details and comments');
        productDetailsCubit.fetchDetails(productId: productId!);
        commentCubit.fetchComments(productId!);
      }
    });
  }

  Future<void> _onRefresh() async {
    if (productId != null) {
      print('🔄 Manual refresh triggered');
      await Future.wait([
        productDetailsCubit.fetchDetails(productId: productId!),
        commentCubit.fetchComments(productId!),
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context
        .watch<UserCubit>()
        .state;


    if (productId == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.details),

        ),
        body: Center(child: Text(AppLocalizations.of(context)!.noDataFound)),
      );
    }


    return BlocListener<FavoriteCubit, FavoriteToggleState>(
        bloc: favoriteCubit,
        listener: (context, state) {
          if (state is FavoriteSuccess) {
            _showCustomOverlay(context, state.response);
            // No need to refresh entire product details - favorite state is managed locally
          } else if (state is FavoriteFailure) {
            _showCustomOverlay(
                context,
                state.error?.errorMessage ?? "Error updating favorites",
                isError: true
            );
          }
        },

        child: Scaffold(
          floatingActionButton: (user?.roles?[0] == "Marketer")
              ? null
              : FloatingActionButton(
            onPressed: () {},
            tooltip: AppLocalizations.of(context)!.haveADeal,
            backgroundColor: ColorManager.lightprimary,
            child: Icon(
                Icons.chat_bubble_outline_sharp, color: ColorManager.white),
          ),
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(CupertinoIcons.back),
              color: Colors.white,
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(AppLocalizations.of(context)!.details),
            centerTitle: true,
            backgroundColor: ColorManager.lightprimary,

          ),
          body: RefreshIndicator(
            onRefresh: _onRefresh,
            child: BlocBuilder<ProductDetailsCubit, ProductDetailsStates>(
              bloc: productDetailsCubit,
              builder: (context, state) {
                if (state is ProductDetailsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ProductDetailsError) {
                  return Center(child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(state.error?.errorMessage ?? "",
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyMedium,

                        ),
                        CustomizedElevatedButton(
                          bottonWidget: Text(
                            AppLocalizations.of(context)!.tryAgain,
                            style: Theme
                                .of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                color: ColorManager.white, fontSize: 14.sp),
                          ),
                          color: ColorManager.lightprimary,
                          borderColor: ColorManager.lightprimary,
                          onPressed: () =>
                              productDetailsCubit.fetchDetails(
                                  productId: productId!),
                        )
                      ],
                    ),
                  ));
                } else if (state is ProductDetailsSuccess) {
                  final product = state.productDetails;
                  bool isFavorite = state.isFavorite; // ✅ Read from state

                  final List<String> images = (product.imageUrls?.isNotEmpty ??
                      false)
                      ? product.imageUrls!.map((
                      img) => "https://ankhapi.runasp.net/$img").toList()
                      : [ImageAssets.brokenImage];
                  return SingleChildScrollView(
                    padding: REdgeInsets.all(22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image Slider (just the main image shown)
                        Stack(
                          children: [

                            SizedBox(
                              height: 200.h,
                              child: PageView.builder(
                                controller: _pageController,
                                itemCount: images.length,
                                onPageChanged: (index) =>
                                    setState(() => _currentIndex = index),
                                itemBuilder: (context, index) =>
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16.r),
                                      child: Image.network(
                                        images[index],
                                        fit: BoxFit.contain,
                                        width: double.infinity,
                                        errorBuilder: (_, __, ___) =>
                                            Image.asset(ImageAssets.brokenImage,
                                                fit: BoxFit.scaleDown),
                                      ),
                                    ),
                              ),


                            ),

                            product.status == "Available" ? Positioned(
                              right: 13.w,
                              child: Chip(label: Text(
                                AppLocalizations.of(context)!.active, style:
                              Theme
                                  .of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(fontSize: 14.sp,
                                  color: ColorManager.darkGreen)
                                ,), backgroundColor: ColorManager.lightGreen,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.w, vertical: 4.h),

                                shape: const StadiumBorder(side: BorderSide(
                                    color: Colors
                                        .transparent)), // makes it circular

                              ),
                            ) : SizedBox.shrink(),
                            user?.roles?[0] == "Admin" ||
                                user?.roles?[0] == "LeaderMarketer" ||
                                user?.roles?[0] == "Marketer" ||
                                user?.roles?[0] == "Inspector" ?
                            SizedBox.shrink() :
                            Positioned(
                              left: 13.w,
                              child: StatefulBuilder(
                                builder: (context, setFavoriteState) {
                                  return GestureDetector(
                                    onTap: () {
                                      final user = context
                                          .read<UserCubit>()
                                          .state;
                                      final String? userId = user?.id;
                                      final num productId = this.productId!;

                                      if (userId == null) {
                                        CustomDialog.positiveAndNegativeButton(
                                            context: context,
                                            positiveText: AppLocalizations.of(
                                                context)!.loginNow,
                                            positiveOnClick: () {
                                              Navigator.of(context).pushNamed(
                                                  WelcomeScreen
                                                      .welcomeScreenRouteName);
                                            },
                                            title: AppLocalizations.of(context)!
                                                .loginNow,
                                            message: AppLocalizations.of(
                                                context)!.reactDenied);
                                        return;
                                      }

                                      // Toggle UI immediately (better UX) - only rebuild the favorite icon
                                      setFavoriteState(() {
                                        isFavorite = !isFavorite;
                                      });

                                      // Call the correct cubit method
                                      if (isFavorite) {
                                        favoriteCubit.addFavorite(
                                            userId: userId,
                                            productId: productId);
                                      } else {
                                        favoriteCubit.removeFavorite(
                                            userId: userId,
                                            productId: productId);
                                      }
                                    },
                                    child: CircleAvatar(
                                      radius: 30.r,
                                      backgroundColor: ColorManager.white,
                                      child: Icon(
                                        Iconsax.heart5,
                                        color: isFavorite ? ColorManager
                                            .lightprimary : ColorManager.grey,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),


                          ],
                        ),
                        if (images.length > 1)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              images.length,
                                  (index) =>
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 4.w,
                                      vertical: 8.h,
                                    ),
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _currentIndex == index
                                          ? ColorManager.lightprimary
                                          : Colors.grey,
                                    ),
                                  ),
                            ),
                          ),
                        SizedBox(height: 16.h),

                        // Title & Rating
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product?.title ?? "",
                                    style: GoogleFonts.manrope(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w600,
                                      color: ColorManager.lightprimary,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      RatingBarIndicator(
                                        rating: (product?.rating ?? 0.0)
                                            .toDouble(),
                                        itemBuilder: (context, index) =>
                                        const Icon(
                                          Icons.star,
                                          color: ColorManager.starRateColor,
                                        ),
                                        itemCount: 5,
                                        itemSize: 16.sp,
                                      ),

                                      _buildSmallText(
                                          "  ${(product?.rating ?? 0.0)
                                              .toDouble()}"
                                          , ColorManager.hintColor),
                                    ],
                                  ),
                                  _buildSmallText(
                                    product?.transmission ?? "",
                                    const Color(0xFF404147),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "${AppLocalizations.of(context)!.egp} ${product
                                    .price}",
                                style: GoogleFonts.poppins(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: ColorManager.lightprimary,
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 18.h),
                        StatusSection(product: product,),
                        SizedBox(height: 17.h),
                        SectionTitle(
                            title: AppLocalizations.of(context)!.carCode),
                        SizedBox(height: 4.h),
                        Text(
                          product.code ?? "",
                          style: GoogleFonts.poppins(
                            fontSize: 14.sp,
                            color: const Color(0xff404147),
                          ),
                        ),

                        SectionTitle(
                            title: AppLocalizations.of(context)!.description),
                        SizedBox(height: 4.h),
                        Text(
                          product?.description ?? "",
                          style: GoogleFonts.poppins(
                            fontSize: 14.sp,
                            color: const Color(0xff404147),
                          ),
                        ),

                        SectionTitle(
                            title: AppLocalizations.of(context)!.carCode),
                        SizedBox(height: 4.h),
                        Text(
                          product?.description ?? "",
                          style: GoogleFonts.poppins(
                            fontSize: 14.sp,
                            color: const Color(0xff404147),
                          ),),
                        SizedBox(height: 12.h),
                        _buildSmallText(
                          "${AppLocalizations.of(context)!.created}:   ${product
                              .createdAt != null
                              ? DateFormat('dd/MM/yyyy').format(
                              DateTime.parse(product.createdAt!))
                              : AppLocalizations.of(context)!.notAvailable}",
                          const Color(0xff6B7280),
                        ),
                        _buildSmallText(
                          "${AppLocalizations.of(context)!
                              .lastEdited}:   ${product.lastEditedAt != null
                              ? DateFormat('dd/MM/yyyy').format(
                              DateTime.parse(product.lastEditedAt!))
                              : AppLocalizations.of(context)!.notAvailable}",
                          const Color(0xff6B7280),
                        ),

                        SizedBox(height: 24.h),
                        SectionTitle(title: AppLocalizations.of(context)!
                            .details),
                        SizedBox(height: 12.h),
                        CarDetailInfo(product: product),

                        SizedBox(height: 16.h),
                        SectionHeader(title: AppLocalizations.of(context)!
                            .images, imageUrl: product.imageUrls,),
                        SizedBox(
                          height: 115.h,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: product.imageUrls?.length ?? 0,
                            itemBuilder: (context, index) =>
                                Container(
                                  width: 115.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.r),
                                    color: const Color(0xFFF9FAFB),
                                  ),
                                  child: Image.network(
                                    'https://ankhapi.runasp.net/${product
                                        .imageUrls?[index]}',
                                    fit: BoxFit.contain,
                                    errorBuilder: (_, __, ___) =>
                                        Image.asset(ImageAssets.brokenImage,
                                            fit: BoxFit.scaleDown),
                                  ),
                                ),
                            separatorBuilder: (context, index) =>
                                SizedBox(width: 20.w),
                          ),
                        ),

                        SizedBox(height: 16.h),
                        // Debug: Show user role
                        // Comments Section
                        SectionTitle(title: AppLocalizations.of(context)!
                            .comments),
                        SizedBox(height: 12.h),
                        user?.roles?[0] == "Admin" ||
                            user?.roles?[0] == "Marketer" ||
                            user?.roles?[0] == "LeaderMarketer"||
                        user?.roles?[0] == "Inspector" ?
                        SizedBox.shrink() :
                        AddCommentSection(
                            productId: productId!, commentCubit: commentCubit),
                        SizedBox(height: 16.h),

                        CommentListWidget(
                            productId: productId!, commentCubit: commentCubit),
                        SizedBox(height: 16.h),
                        user?.roles?[0] == "Admin" ?
                        SizedBox.shrink() :

                        SectionTitle(
                            title: AppLocalizations.of(context)!.supportTeam),
                        SizedBox(height: 12.h),
                        user?.roles?[0] == "Admin" ?
                        SizedBox.shrink() :

                        const SupportTeamSection(),

                        SizedBox(height: 74.h),
                        (user?.roles?[0] == "Marketer"||user?.roles?[0] == "LeaderMarketer") &&
                            widget.showButton == true ?
                        CustomizedElevatedButton(
                          bottonWidget: Text(
                            AppLocalizations.of(context)!.requestInspection,
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                              color: ColorManager.white,
                              fontSize: 16.sp,
                            ),
                          ),
                          color: Theme
                              .of(context)
                              .primaryColor,
                          borderColor: Theme
                              .of(context)
                              .primaryColor,
                          //todo: add the request inspection screen
                          onPressed: () {
                            Navigator.pushNamed(context, RequestInspectionScreen
                                .requestInspectionScreenRouteName,
                                arguments: product
                            );
                          },
                        ) :
                        const SizedBox.shrink()
                      ],
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
        ));
  }
}