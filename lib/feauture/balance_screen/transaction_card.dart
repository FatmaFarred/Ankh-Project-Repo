import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/domain/entities/balance_response_entity.dart';
import 'package:ankh_project/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  final List<TransactionsEntity> transactions;

  const TransactionCard({super.key, required this.transactions});


  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'approved':
        return ColorManager.darkGreen;
      case 'pending':
        return ColorManager.darkYellow;
      case 'rejected':
        return ColorManager.error;
      default:
        return ColorManager.hintColor;
    }
  }

  Color _getStatusBackgroundColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'approved':
        return ColorManager.darkGreen.withOpacity(0.1);
      case 'pending':
        return Color(0xFFFEF9C3);
      case 'rejected':
        return ColorManager.error.withOpacity(0.1);
      default:
        return ColorManager.hintColor.withOpacity(0.1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 12.h),
        Text(
          AppLocalizations.of(context)!.transactionHistory,
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: ColorManager.black,
          ),
        ),
        SizedBox(height: 12.h),

        Expanded(
          child: transactions.isEmpty
              ? Center(
                  child: Text(
                    AppLocalizations.of(context)!.noRequestsFound,
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: ColorManager.hintColor,
                    ),
                  ),
                )
              : Container(
                  padding: REdgeInsets.symmetric(vertical: 13),
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      final transaction = transactions[index];
                      return Container(
                        padding: REdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 0.8.w,
                            color: ColorManager.hintColor,
                          ),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    transaction.description ?? 'No description',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    '${DateFormat('MMM DD yyyy hh:mm a').format(DateTime.parse(transaction.createdAt??""))}',
                                    style: GoogleFonts.manrope(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      color: ColorManager.hintColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "${AppLocalizations.of(context)!.egp} ${transaction.amount?.toStringAsFixed(2) ?? '0.00'}",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: ColorManager.black,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 4,
                                    horizontal: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.r),
                                    color: _getStatusBackgroundColor(transaction.status),
                                  ),
                                  child: Text(
                                    transaction.status ?? 'Unknown',
                                    style: GoogleFonts.inter(
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w500,
                                      color: _getStatusColor(transaction.status),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 8.h);
                    },
                    itemCount: transactions.length,
                  ),
                ),
        ),
      ],
    );
  }
}
