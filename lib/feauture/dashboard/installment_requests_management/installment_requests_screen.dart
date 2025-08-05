import 'package:ankh_project/domain/entities/installment_pending_entity.dart';
import 'package:ankh_project/feauture/dashboard/installment_requests_management/InstallmentOfferBottomSheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../api_service/di/injection.dart';
import '../../../core/constants/assets_manager.dart';
import '../../../core/constants/color_manager.dart';
import '../../../core/customized_widgets/reusable_widgets/custom_text_field.dart';
import '../../../l10n/app_localizations.dart';
import 'cubit/installment_pending_cubit.dart';
import 'cubit/installment_pending_state.dart';

class InstallmentRequestsScreen extends StatefulWidget {
  const InstallmentRequestsScreen({super.key});

  @override
  State<InstallmentRequestsScreen> createState() =>
      _InstallmentRequestsScreenState();
}

class _InstallmentRequestsScreenState extends State<InstallmentRequestsScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InstallmentPendingCubit, InstallmentPendingState>(
      builder: (context, state) {
        if (state is InstallmentPendingLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is InstallmentPendingLoaded) {
          return _buildOfferList(context, state.requests);
        } else if (state is InstallmentPendingError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        return const SizedBox.shrink();
      },
    );
  }
}

Widget _buildOfferList(
  BuildContext context,
  List<InstallmentPendingEntity> offers,
) {
  final TextEditingController searchController = TextEditingController();

  if (offers.isEmpty) {
    return const Center(
      child: Text(
        'There are no offers',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
  return Column(
    children: [
      SizedBox(height: 20.h),
      Text(
        "Installment Offers Management",
        style: Theme.of(
          context,
        ).textTheme.headlineLarge!.copyWith(fontSize: 18.sp),
      ),
      Expanded(
        child: RefreshIndicator(
          color: ColorManager.lightprimary,
          onRefresh: () async {
            context.read<InstallmentPendingCubit>().fetchPendingInstallments();
          },
          child: ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16.0),
            itemCount: offers.length,
            itemBuilder: (context, index) {
              final offer = offers[index];
              return Card(
                elevation: 0,
                color: ColorManager.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  side: BorderSide(color: ColorManager.lightGrey),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Image.network(
                              "https://ankhapi.runasp.net/${offer.productImage}",
                              fit: BoxFit.cover,
                              errorBuilder: (_, _, _) =>
                                  const Icon(Icons.broken_image),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        offer.productName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                    const Spacer(),
                                    _buildStatusChip("pending", true),
                                  ],
                                ),
                                SizedBox(height: 8.h),
                                _buildIconText(
                                  context,
                                  ImageAssets.callIcon,
                                  offer.marketerName,
                                ),
                                _buildIconText(
                                  context,
                                  ImageAssets.callIcon,
                                  offer.clientName,
                                ),
                                _buildIconText(
                                  context,
                                  ImageAssets.callIcon,
                                  offer.clientPhone,
                                ),
                                _buildIconText(
                                  context,
                                  ImageAssets.callIcon,
                                  offer.productPrice,
                                ),
                                SizedBox(height: 8.h),
                              ],
                            ),
                          ),
                        ],
                      ),
                      _buildActions(context, offer),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (_, _) => SizedBox(height: 12.h),
          ),
        ),
      ),
    ],
  );
}

Widget _buildIconText(BuildContext context, String icon, String text) {
  return Row(
    children: [
      SvgPicture.asset(icon, height: 18.h, width: 18.w),
      SizedBox(width: 6.w),
      Text(
        text,
        style: Theme.of(
          context,
        ).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
      ),
    ],
  );
}

Widget _buildStatusChip(String text, bool isPositive) {
  return Container(
    padding: REdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: isPositive ? const Color(0xFFDCFCE7) : const Color(0xFFFFEDD5),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: isPositive ? const Color(0xFF166534) : const Color(0xFF9A3412),
        fontWeight: FontWeight.w500,
        fontSize: 12.sp,
      ),
    ),
  );
}

Widget _buildActions(BuildContext context, InstallmentPendingEntity offer) {
  final TextEditingController noteController = TextEditingController();

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: _buildActionButton(
          context: context,
          icon: Icons.done,
          label: AppLocalizations.of(context)!.accept,
          color: ColorManager.lightprimary,
          onPressed: () async {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (_) =>
                  BlocProvider(
                create: (_) => sl<InstallmentPendingCubit>(),
                child:  InstallmentOfferBottomSheet(offers: offer,statusNum: 1,),
              ),
            );
          },
        ),
      ),
      SizedBox(width: 12.w),
      Expanded(
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: ColorManager.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: ColorManager.darkGrey),
            ),
          ),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (_) =>
                  BlocProvider(
                create: (_) => sl<InstallmentPendingCubit>(),
                child:  InstallmentOfferBottomSheet(offers: offer,statusNum: 2,),
              ),
            );
          },
          icon: Icon(
            Icons.not_interested_rounded,
            color: ColorManager.darkRed,
            size: 20.sp,
          ),
          label: Text(
            AppLocalizations.of(context)!.reject,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 12.sp,
              color: ColorManager.lightprimary,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _buildActionButton({
  required BuildContext context,
  required IconData icon,
  required String label,
  required Color color,
  required VoidCallback onPressed,
}) {
  return ElevatedButton.icon(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: ColorManager.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: ColorManager.darkGrey),
      ),
    ),
    onPressed: onPressed,
    icon: Icon(icon, color: color, size: 20.sp),
    label: Text(
      label,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
        fontSize: 12.sp,
        color: ColorManager.lightprimary,
      ),
    ),
  );
}
