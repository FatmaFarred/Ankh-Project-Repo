import 'package:ankh_project/api_service/di/di.dart';
import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/core/customized_widgets/shared_preferences .dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/custom_dialog.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import 'package:ankh_project/domain/entities/balance_response_entity.dart';
import 'package:ankh_project/feauture/balance_screen/cubit/balance_cubit.dart';
import 'package:ankh_project/feauture/balance_screen/cubit/balance_states.dart';
import 'package:ankh_project/feauture/balance_screen/cubit/add_point_request_cubit.dart';
import 'package:ankh_project/feauture/balance_screen/cubit/add_point_request_states.dart';
import 'package:ankh_project/feauture/balance_screen/transaction_card.dart';
import 'package:ankh_project/feauture/home_screen/bottom_nav_bar.dart';
import 'package:ankh_project/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/models/authentication_response_dm.dart';
import '../authentication/user_controller/user_cubit.dart';


class BalanceScreen extends StatefulWidget {
  const BalanceScreen({super.key});

  @override
  State<BalanceScreen> createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> with TickerProviderStateMixin {
  BalanceCubit balanceCubit = getIt<BalanceCubit>();
  AddPointRequestCubit addPointRequestCubit = getIt<AddPointRequestCubit>();
  final UserCubit userCubit = getIt<UserCubit>();
  String? userToken;
  late TabController _tabController;
  int _currentTabIndex = 0;
  
  // Controllers for the bottom sheet
  final TextEditingController _pointsController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentTabIndex = _tabController.index;
      });
    });
    _loadTokenAndFetchData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pointsController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _loadTokenAndFetchData() async {
    userToken = await SharedPrefsManager.getData(key: 'user_token');
    if (userToken != null) {
      balanceCubit.fetchBalance(context, userToken!);
    }
  }

  Future<void> _refreshData() async {
    print("🔄 Balance Refresh triggered!"); // Debug print
    if (userToken != null) {
      await balanceCubit.fetchBalance(context, userToken!);
    }
    print("✅ Balance Refresh completed!"); // Debug print
  }

  List<TransactionsEntity> _getFilteredTransactions(List<TransactionsEntity> transactions) {
    switch (_currentTabIndex) {
      case 0: // All
        return transactions;
      case 1: // Pending
        return transactions.where((transaction) => 
          transaction.status?.toLowerCase() == 'pending').toList();
      case 2: // Approved
        return transactions.where((transaction) => 
          transaction.status?.toLowerCase() == 'approved').toList();
      case 3: // Rejected
        return transactions.where((transaction) => 
          transaction.status?.toLowerCase() == 'rejected').toList();
      default:
        return transactions;
    }
  }

  void _showAddPointRequestBottomSheet() {
    _pointsController.clear();
    _descriptionController.clear();
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          padding: EdgeInsets.all(20.w),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.add_circle_outline,
                        size: 24.h,
                        color: ColorManager.balanceColor,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        AppLocalizations.of(context)!.requestPoints,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.close, size: 24.sp, color: ColorManager.darkGrey),
                      ),
                    ],
                  ),
                SizedBox(height: 8.h),
                Text(
                  AppLocalizations.of(context)!.description,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                ),
                SizedBox(height: 8.h),
                TextFormField(
                  style:Theme.of(context).textTheme.bodySmall ,

                  controller: _descriptionController,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.enterDescription,
                    hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14.sp,color: ColorManager.darkGrey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(color: ColorManager.lightGrey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(color: ColorManager.lightGrey),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.fieldRequired;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),
                Text(
                  AppLocalizations.of(context)!.points,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                ),
                SizedBox(height: 8.h),
                TextFormField(
                  style:Theme.of(context).textTheme.bodySmall ,
                  controller: _pointsController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.enterPointsCount,
                    hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14.sp,color: ColorManager.darkGrey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(color: ColorManager.lightGrey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(color: ColorManager.lightGrey),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.fieldRequired;
                    }
                    if (num.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    final points = num.tryParse(value);
                    if (points != null && points <= 0) {
                      return 'Points must be greater than 0';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24.h),
                BlocListener<AddPointRequestCubit, AddPointRequestState>(
                    bloc: addPointRequestCubit,
                    listener: (context, state) {
                      if (state is AddPointRequestSuccess) {
                        CustomDialog.positiveButton(
                          context: context,
                          title: AppLocalizations.of(context)!.success,
                          message: state.message ?? 'Request submitted successfully',
                          positiveOnClick: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();

                            _refreshData(); // Refresh the balance data
                          },
                        );
                      } else if (state is AddPointRequestError) {
                        CustomDialog.positiveButton(
                          context: context,
                          title: AppLocalizations.of(context)!.error,
                          message: state.error.errorMessage ?? 'An error occurred',
                          positiveOnClick: () {
                            Navigator.of(context).pop();
                          },
                        );
                      }
                    },
                    child: BlocBuilder<AddPointRequestCubit, AddPointRequestState>(
                      bloc: addPointRequestCubit,
                      builder: (context, state) {
                                                return Row(
                          children: [
                            Expanded(
                              child: CustomizedElevatedButton(
                                bottonWidget: Text(
                                  AppLocalizations.of(context)!.cancel,
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 16.sp),
                                ),
                                onPressed: () => Navigator.pop(context),
                                borderColor: ColorManager.lightGrey,
                                color: ColorManager.white,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: CustomizedElevatedButton(
                                bottonWidget: state is AddPointRequestLoading
                                    ? SizedBox(
                                        height: 20.h,
                                        width: 20.w,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : Text(
                                        AppLocalizations.of(context)!.submit,
                                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                          fontSize: 16.sp,
                                          color: ColorManager.white,
                                        ),
                                      ),
                                onPressed: state is AddPointRequestLoading
                                    ? null
                                    : () {
                                        if (_formKey.currentState!.validate()) {
                                          if (userToken != null) {
                                            final points = num.parse(_pointsController.text);
                                            print('Submitting request with points: $points');
                                            print('Description: ${_descriptionController.text}');
                                            addPointRequestCubit.addPointRequest(
                                              context,
                                              userToken!,
                                              _descriptionController.text,
                                              points,
                                            );
                                          }
                                        }
                                      },
                                borderColor: ColorManager.balanceColor,
                                color: ColorManager.balanceColor,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ]),

            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BalanceCubit, BalanceState>(
      bloc: balanceCubit,
      listener: (context, state) {
        if (state is BalanceError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error.errorMessage ?? 'An error occurred'),
              backgroundColor: ColorManager.error,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.myBalance,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontSize: 18.sp,
              color: Colors.white,
            ),
          ),

          leading: IconButton(
            icon: const Icon(CupertinoIcons.back),
            color: Colors.white,
            onPressed: () {
              Navigator.pushReplacementNamed(context, BottomNavBar.bottomNavBarRouteName);
            },
          ),
          backgroundColor: ColorManager.balanceColor,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _showAddPointRequestBottomSheet,
          backgroundColor: ColorManager.balanceColor,
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 24.sp,
          ),
        ),
        body: BlocBuilder<BalanceCubit, BalanceState>(
          bloc: balanceCubit,
          builder: (context, state) {
            if (state is BalanceLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is BalanceError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(state.error.errorMessage ?? 'An error occurred'),
                      ElevatedButton(
                        onPressed: () {
                          if (userToken != null) {
                            balanceCubit.fetchBalance(context, userToken!);
                          }
                        },
                        child: Text(AppLocalizations.of(context)!.tryAgain),
                      )
                    ],
                  ),
                ),
              );
            } else if (state is BalanceSuccess) {
              final balance = state.balance;
              final filteredTransactions = _getFilteredTransactions(balance.transactions ?? <TransactionsEntity>[]);
              
              return RefreshIndicator(
                color: ColorManager.balanceColor,
                onRefresh: _refreshData,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: REdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Container(
                          padding: REdgeInsets.symmetric(vertical: 25, horizontal: 32),
                          decoration: BoxDecoration(
                            color: ColorManager.balanceColor,
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.availableBalance,
                                style: GoogleFonts.inter(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: ColorManager.white,
                                ),
                              ),
                              SizedBox(height: 6.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                    child: Text(
                                      AppLocalizations.of(context)!.egp,
                                      style: GoogleFonts.inter(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w700,
                                        color: ColorManager.white,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  Flexible(
                                    child: Text(
                                      "${balance.availableBalance?.toStringAsFixed(0) ?? '0.00'}",
                                      style: GoogleFonts.inter(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w700,
                                        color: ColorManager.white,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  Icon(Icons.trending_up_rounded, color: Color(0xFFCAA650), size: 20.sp)
                                ],
                              ),
                              SizedBox(height: 24.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!.totalPoints,
                                          style: GoogleFonts.inter(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
                                            color: ColorManager.white,
                                          ),
                                        ),
                                        SizedBox(height: 6.h),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                AppLocalizations.of(context)!.point,
                                                style: GoogleFonts.inter(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w700,
                                                  color: ColorManager.white,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            SizedBox(width: 4.w),
                                            Flexible(
                                              child: Text(
                                                "${balance.totalPoints?.toString() ?? '0'}",
                                                style: GoogleFonts.inter(
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.w700,
                                                  color: ColorManager.white,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 30.w),
                                  Container(
                                    height: 58,
                                    width: 1,
                                    decoration: BoxDecoration(
                                      color: ColorManager.white,
                                      borderRadius: BorderRadius.circular(16.r),
                                    ),
                                  ),
                                  SizedBox(width: 30.w),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!.perPoint,
                                          style: GoogleFonts.inter(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
                                            color: ColorManager.white,
                                          ),
                                        ),
                                        SizedBox(height: 6.h),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                AppLocalizations.of(context)!.egp,
                                                style: GoogleFonts.inter(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w700,
                                                  color: ColorManager.white,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            SizedBox(width: 4.w),
                                            Flexible(
                                              child: Text(
                                                "${balance.perPointValue?.toStringAsFixed(0) ?? '0.00'}",
                                                style: GoogleFonts.inter(
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.w700,
                                                  color: ColorManager.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 33.h),
                        TabBar(
                          controller: _tabController,
                          labelColor: ColorManager.balanceColor,
                          unselectedLabelColor: Colors.grey,
                          indicatorColor: ColorManager.balanceColor,
                          indicatorWeight: 1,
                          labelStyle: GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 14.sp),
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicator: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: ColorManager.balanceColor,
                                width: 2,
                              ),
                            ),
                          ),
                          tabs: [
                            Tab(text: AppLocalizations.of(context)!.all),
                            Tab(text: AppLocalizations.of(context)!.pending),
                            Tab(text: AppLocalizations.of(context)!.approved),
                            Tab(text: AppLocalizations.of(context)!.rejected),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              TransactionCard(transactions: filteredTransactions),
                              TransactionCard(transactions: filteredTransactions),
                              TransactionCard(transactions: filteredTransactions),
                              TransactionCard(transactions: filteredTransactions),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}