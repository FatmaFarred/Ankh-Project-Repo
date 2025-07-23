import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import 'package:ankh_project/core/customized_widgets/shared_preferences .dart';
import 'package:ankh_project/feauture/inspector_screen/inspection_details/inspection_details_screen.dart';
import 'package:ankh_project/feauture/inspector_screen/my_inspections/my_inspections_cubit.dart';
import 'package:ankh_project/feauture/inspector_screen/my_inspections/my_inspections_state.dart';
import 'package:ankh_project/feauture/marketer_home/home_app_bar.dart';
import 'package:ankh_project/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../domain/entities/all_inpection_entity.dart';
import '../../authentication/user_controller/user_cubit.dart';
import '../../home_screen/header_section.dart';
import '../../../api_service/di/di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyInspectionsScreen extends StatefulWidget {
  const MyInspectionsScreen({super.key});

  @override
  State<MyInspectionsScreen> createState() => _MyInspectionsScreenState();
}

class _MyInspectionsScreenState extends State<MyInspectionsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late MyInspectionsCubit myInspectionsCubit;
  final TextEditingController _searchController = TextEditingController();

  String? currentKeyword;

  String? token;
  final List<String> filters = [
    'today',
    'tomorrow',
    'Pending',
    'Completed',
    'ClientDidNotRespond',
    'Postponed',
    'ReturnedToMarketer',
    'ClientRejected'
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 8, vsync: this);
    myInspectionsCubit = getIt<MyInspectionsCubit>();
    _loadTokenAndFetch();
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;
      _fetchForTab(_tabController.index);
    });
  }

  Future<void> _loadTokenAndFetch() async {
    final fetchedToken = await SharedPrefsManager.getData(key: 'user_token');
    setState(() {
      token = fetchedToken;
    });
    if (token != null) {
      myInspectionsCubit.fetchInspections(token: token!, filter: filters[0]);
    }
  }

  void _fetchForTab(int index) {
    if (token != null) {
      myInspectionsCubit.fetchInspections(token: token!, filter:filters[index] );
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    myInspectionsCubit.close();
    super.dispose();
  }

  Future<void> _refreshData(int index) async {
    print("🔄 inspector Products Refresh triggered!"); // Debug print
    final user = context.read<UserCubit>().state;
    final userId = user?.id;
    if (token!= null ) {
      await myInspectionsCubit.fetchInspections(token: token!, filter: filters[index]);
    }
    /* print("👤 User ID: $userId"); // Debug print
    if (userId != null && userId.isNotEmpty) {
      await inspectorHomeProductCubit.fetchProducts();

    }
    print("✅ Marketer Products Refresh completed!"); // Debug print
  }*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, _) => [
          SliverToBoxAdapter(child: HomeAppBar(
            onSearch: (keyword) {
              if (keyword.isNotEmpty) {
                myInspectionsCubit.searchProducts(keyword: keyword, token: token!);
              } else {
                myInspectionsCubit.fetchInspections(token : token!, filter: filters[_tabController.index]);
              }
            },

          )),
          SliverToBoxAdapter(child: SizedBox(height: 12.h)),
        ],
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 17.w, vertical: 13.h),
              child: TabBar(
                controller: _tabController,
                tabAlignment: TabAlignment.center,
                dividerColor: ColorManager.transparent,
                isScrollable: true,
                indicator: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                labelStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: ColorManager.white),
                unselectedLabelStyle: Theme.of(context).textTheme.bodyMedium,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [
                  Tab(text: AppLocalizations.of(context)!.today),
                  Tab(text: AppLocalizations.of(context)!.tomorrow),
                  Tab(text: AppLocalizations.of(context)!.pending),
                  Tab(text: AppLocalizations.of(context)!.completed),
                  Tab(text: AppLocalizations.of(context)!.clientDidNotRespond),
                  Tab(text: AppLocalizations.of(context)!.postponed),
                  Tab(text: AppLocalizations.of(context)!.returnedToMarketer),
                  Tab(text: AppLocalizations.of(context)!.clientRejected),
                ],
                onTap: (index) => _fetchForTab(index),
              ),
            ),
            Expanded(
              child: BlocBuilder<MyInspectionsCubit, MyInspectionsState>(
                bloc: myInspectionsCubit,
                builder: (context, state) {
                  if (state is MyInspectionsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is MyInspectionsError) {
                    print('--- MyInspectionsError State ---');
                    print(StackTrace.current);
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(state.error.errorMessage ?? 'Error'),
                            SizedBox(height: 16),
                            CustomizedElevatedButton(
                              bottonWidget: Text(AppLocalizations.of(context)!.tryAgain,
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: ColorManager.white),
                              ),
                              color: ColorManager.lightprimary,
                              borderColor: ColorManager.lightprimary,
                              onPressed: () {
                                print('--- Try Again Button Pressed ---');
                                print(StackTrace.current);
                                _fetchForTab(_tabController.index);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  } else if (state is MyInspectionsEmpty) {
                    print('--- MyInspectionsEmpty State ---');
                    print(StackTrace.current);
                    return RefreshIndicator(
                      onRefresh: () => _refreshData(_tabController.index),
                      child: ListView(
                        physics: const AlwaysScrollableScrollPhysics(), // Ensures it can always be pulled
                        children: [
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.hourglass_empty, size: 64, color: ColorManager.darkGrey),
                                SizedBox(height: 16),
                                Text(
                                  AppLocalizations.of(context)!.noInspectionsFound,
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: ColorManager.darkGrey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (state is MyInspectionsLoaded) {
                    final inspections = state.inspections;
                    return RefreshIndicator(
                      onRefresh: () => _refreshData(_tabController.index),
                      child: Padding(
                        padding: REdgeInsets.symmetric(horizontal: 16),
                        child: ListView.separated(
                          itemCount: inspections.length,
                          separatorBuilder: (context, index) => SizedBox(height: 12.h),
                          itemBuilder: (context, index) {
                            final inspection = inspections[index];
                            return _buildInspectionCard(context, inspection);
                          },
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInspectionCard(BuildContext context, AllInpectionEntity inspection) {
    return Container(
      padding: REdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF777777).withOpacity(0.5)),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                inspection.clientName ?? '',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: Color(0xFFFEF9C3),
                ),
                child: Text(
                  inspection.status ?? '',
                  style: GoogleFonts.inter(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF166534),
                  ),
                ),
              ),
            ],
          ),
          Text(
            inspection.productName ?? '',
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w300,
              color: Color(0xFF4f4f4f),
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Icon(
                Icons.access_time_rounded,
                size: 14,
                color: ColorManager.lightprimary,
              ),
              SizedBox(width: 6.w),
              Text(
                (inspection.preferredDate != null && inspection.preferredTime != null)
                    ? "${DateFormat('MMMM d, yyyy').format(DateTime.parse(inspection.preferredDate!))} – ${inspection.preferredTime}"
                    : AppLocalizations.of(context)!.noDataFound,
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w300,
                  color: Color(0xFF4f4f4f),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.location_on_rounded,
                size: 14,
                color: ColorManager.lightprimary,
              ),
              SizedBox(width: 6.w),
              Text(
                inspection.address ?? '',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w300,
                  color: Color(0xFF4f4f4f),
                ),
              ),
            ],
          ),
          SizedBox(height: 26.h),
          CustomizedElevatedButton(
            bottonWidget: Text(
              AppLocalizations.of(context)!.startInspect,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: ColorManager.white,
                fontSize: 16.sp,
              ),
            ),
            color: Theme.of(context).primaryColor,
            borderColor: Theme.of(context).primaryColor,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InspectionDetailsScreen(requestId:inspection.id ,),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}