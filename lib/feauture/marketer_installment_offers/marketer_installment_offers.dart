import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../core/constants/font_manager/font_style_manager.dart';
import '../../core/constants/font_manager/font_style_manager.dart' as FontStyleManager;
import '../../l10n/app_localizations.dart';
import '../../core/constants/color_manager.dart';
import '../../core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import '../../core/customized_widgets/shared_preferences .dart';
import 'cubit/installment_offers_by_marketer_id_cubit.dart';

class MarketerInstallmentOffers extends StatefulWidget {
  const MarketerInstallmentOffers({super.key});
  
  static const String routeName = "MarketerInstallmentOffers";

  @override
  State<MarketerInstallmentOffers> createState() => _MarketerInstallmentOffersState();
}

class _MarketerInstallmentOffersState extends State<MarketerInstallmentOffers> {
  @override
  void initState() {
    super.initState();
    _loadInstallmentOffers();
  }

  Future<void> _loadInstallmentOffers() async {
    final userId = await SharedPrefsManager.getData(key: 'user_id');
    print("user id : $userId");
    if (userId != null) {
      print("Fetching installment offers for user ID: $userId");
      try {
        final cubit = context.read<InstallmentOffersByMarketerIdCubit>();
        print("Cubit found: $cubit");
        cubit.fetchOffers(userId);
      } catch (e) {
        print("Error accessing cubit: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error accessing cubit: $e"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      print("No user ID found in SharedPreferences");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(AppLocalizations.of(context)!.installmentOffers),
      ),
      body: BlocConsumer<InstallmentOffersByMarketerIdCubit, InstallmentOffersByMarketerIdState>(
        listener: (context, state) {
          print("Current state: $state");
          if (state is InstallmentOffersByMarketerIdError) {
            print("Error state: ${state.message}");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is InstallmentOffersByMarketerIdLoaded) {
            print("Loaded state with ${state.offers.length} installment offers");
          }
        },
        builder: (context, state) {
          if (state is InstallmentOffersByMarketerIdLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          
          if (state is InstallmentOffersByMarketerIdError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.grey),
                  SizedBox(height: 16.h),
                  Text(
                    state.message,
                    style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24.h),
                  ElevatedButton(
                    onPressed: _loadInstallmentOffers,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.lightprimary,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(AppLocalizations.of(context)!.retry),
                  ),
                ],
              ),
            );
          }
          
          if (state is InstallmentOffersByMarketerIdLoaded) {
            if (state.offers.isEmpty) {
              return RefreshIndicator(
                onRefresh: _loadInstallmentOffers,
                color: ColorManager.lightprimary,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.inbox_outlined, size: 64, color: Colors.grey),
                      SizedBox(height: 16.h),
                      Text(
                        AppLocalizations.of(context)!.noDataFound,
                        style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }
            
            return RefreshIndicator(
              onRefresh: _loadInstallmentOffers,
              color: ColorManager.lightprimary,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                itemCount: state.offers.length,
                itemBuilder: (context, index) {
                  final offer = state.offers[index];
                  return Card(
                    color: ColorManager.white,
                    elevation: 2,
                    margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r), 
                        side: BorderSide(color: ColorManager.lightGrey)
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  offer.productName,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Flexible(
                                child: Chip(
                                  backgroundColor: _getStatusColor(offer.status),
                                  label: Text(
                                    offer.status,
                                    style: FontStyleManager.getBoldStyle(
                                      fontSize: 10.sp,
                                      color: Colors.white,
                                      context: context,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
                                  shape: const StadiumBorder(
                                    side: BorderSide(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Row(children: [
                            Icon(Icons.person_rounded,
                              color: ColorManager.lightprimary,
                              size: 20.sp,
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                offer.clientName,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: ColorManager.darkGrey,
                                  fontSize: 12.sp
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],),
                          SizedBox(height: 8.h),
                          Row(children: [
                            Icon(Icons.phone,
                              color: ColorManager.lightprimary,
                              size: 20.sp,
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                offer.clientPhone,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: ColorManager.darkGrey,
                                  fontSize: 12.sp
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],),
                          SizedBox(height: 8.h),
                          Row(children: [
                            Icon(Icons.attach_money,
                              color: ColorManager.lightprimary,
                              size: 20.sp,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              "${offer.productPrice} ${AppLocalizations.of(context)!.currency}",
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: ColorManager.darkGrey,
                                fontSize: 12.sp
                              ),
                            ),
                          ],),
                          SizedBox(height: 8.h),
                          Row(children: [
                            Icon(Icons.payment,
                              color: ColorManager.lightprimary,
                              size: 20.sp,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              "${offer.downPayment.toStringAsFixed(2)} ${AppLocalizations.of(context)!.currency}",
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: ColorManager.darkGrey,
                                fontSize: 12.sp
                              ),
                            ),
                          ],),
                          SizedBox(height: 8.h),
                          Row(children: [
                            Icon(Icons.schedule,
                              color: ColorManager.lightprimary,
                              size: 20.sp,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              "${offer.requestedMonths} ${AppLocalizations.of(context)!.months}",
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: ColorManager.darkGrey,
                                fontSize: 12.sp
                              ),
                            ),
                          ],),
                          SizedBox(height: 8.h),
                          Row(children: [
                            Icon(Icons.access_time_rounded,
                              color: ColorManager.lightprimary,
                              size: 20.sp,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              DateFormat('MMM dd, yyyy').format(offer.createdAt),
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: ColorManager.darkGrey,
                                fontSize: 12.sp
                              ),
                            ),
                          ],),
                          if (offer.adminNote != null && offer.adminNote!.isNotEmpty) ...[
                            SizedBox(height: 8.h),
                            Row(children: [
                              Icon(Icons.note,
                                color: ColorManager.lightprimary,
                                size: 20.sp,
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Text(
                                  offer.adminNote!,
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: ColorManager.darkGrey,
                                    fontSize: 12.sp
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
          
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'approved':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      case 'processing':
        return Colors.blue;
      default:
        return ColorManager.lightprimary;
    }
  }
}
