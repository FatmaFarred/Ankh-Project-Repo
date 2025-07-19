import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import 'package:ankh_project/feauture/home_screen/header_section.dart';
import 'package:ankh_project/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../api_service/di/di.dart';
import '../../../core/customized_widgets/reusable_widgets/custom_dialog.dart';
import '../../../domain/entities/all_inpection_entity.dart';
import '../../authentication/user_controller/user_cubit.dart';
import '../../marketer_Reports/marketer_reports_screen.dart';
import '../../marketer_home/home_app_bar.dart';
import 'assign_inspection_controller/marketer_product_cubit.dart';
import 'assign_inspection_controller/states.dart';
import 'controller/inspector_home_cubit.dart';
import 'controller/states.dart';

class InspectorHomeScreen extends StatefulWidget {
  const InspectorHomeScreen({super.key});


  @override
  State<InspectorHomeScreen> createState() => _InspectorHomeScreenState();
}

class _InspectorHomeScreenState extends State<InspectorHomeScreen> {
  InspectorHomeProductCubit inspectorHomeProductCubit = getIt<InspectorHomeProductCubit>();
  InspectorAssignProductCubit inspectorAssignProductCubit = getIt<InspectorAssignProductCubit>();
  String? currentKeyword;

  final TextEditingController _searchController = TextEditingController();

  void initState() {
    super.initState();

    Future.microtask(() {
      final user = context.read<UserCubit>().state;
      final userId = user?.id;
      inspectorHomeProductCubit.fetchProducts();

      /*if (userId != null && userId.isNotEmpty) {
        inspectorHomeProductCubit.fetchProducts();
      } else {
        debugPrint("User ID is null or empty");
      }*/
    });
  }

  Future<void> _refreshData() async {
    print("🔄 Marketer Products Refresh triggered!"); // Debug print
    final user = context
        .read<UserCubit>()
        .state;
    final userId = user?.id;
    await inspectorHomeProductCubit.fetchProducts();

    /* print("👤 User ID: $userId"); // Debug print
    if (userId != null && userId.isNotEmpty) {
      await inspectorHomeProductCubit.fetchProducts();

    }
    print("✅ Marketer Products Refresh completed!"); // Debug print
  }*/
  }


  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserCubit>().state;


    return Scaffold(

      body: Column(
        children: [
          HomeAppBar(
            onSearch: (keyword) {
              currentKeyword = keyword; // Store the current keyword
              if (keyword.isNotEmpty) {
                inspectorHomeProductCubit.searchProducts(keyword);
              } else {
                inspectorHomeProductCubit.fetchProducts();
              }
            },
          ),          SizedBox(height: 12.h),
          Expanded(
            child: BlocConsumer<InspectorAssignProductCubit, InspectorAssignProductState>(
    bloc: inspectorAssignProductCubit,
    listener: (context, state) {
    if (state is InspectorAssignProductLoading) {

    CustomDialog.loading(
    context: context,
    message: AppLocalizations.of(context)!.loading,
    cancelable: false);
    }else if (state is InspectorAssignProductSuccess) {
    Navigator.of(context).pop();
    CustomDialog.positiveButton(
    context: context,
    title: AppLocalizations.of(context)!.success,
    message: state.message,
    );


    } else if (state is InspectorAssignProductError) {
    Navigator.of(context).pop();
    CustomDialog.positiveAndNegativeButton(
    context: context,

    positiveText:  AppLocalizations.of(context)!.tryAgain,
    negativeText: AppLocalizations.of(context)!.ok,
    positiveOnClick: () {
    Navigator.of(context).pop();
    final storedProductId = inspectorAssignProductCubit.currentProductId;

    // Use the stored product ID from the cubit
    if (storedProductId != null) {
    print("🔄 !$storedProductId"); // Debug print
    print("👤 User ID: ${user?.id}");// Debug print
    //todo: use the user id from the cubit
    inspectorAssignProductCubit.assignProduct(
    productId: storedProductId,
    inspectorId: "bf3ad5ae-2b75-45a7-99cc-2b5a39e341a3"?? "");

    }
    },
    title: AppLocalizations.of(context)!.error,
    message: state.error.errorMessage);
    }
    },

    builder: (context, assignState) {
    return BlocBuilder<InspectorHomeProductCubit, InspectorHomeProductState>(
    bloc: inspectorHomeProductCubit,
    builder: (context, state) {
    if (state is InspectorHomeProductLoading) {
    return const Center(child: CircularProgressIndicator());
    } else if (state is InspectorHomeProductError) {
    return Center(
    child: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
    Text(state.error?.errorMessage ?? ""),
    CustomizedElevatedButton(
    bottonWidget: Text(AppLocalizations.of(context)!.tryAgain,
    style: Theme
        .of(context)
        .textTheme
        .bodyLarge
        ?.copyWith(color: ColorManager.white),

    ),
    color: ColorManager.lightprimary,
    borderColor: ColorManager.lightprimary,
    onPressed: () => inspectorHomeProductCubit.fetchProducts(),
    )
    ],
    ),
    ),
    );
    } else if (state is InspectorHomeProductEmpty) {
    return RefreshIndicator(
    color: ColorManager.lightprimary,
    onRefresh: _refreshData,
    child: ListView(
    children: [
    Container(
    height: MediaQuery
        .of(context)
        .size
        .height * 0.5,
    child: Center(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Icon(
    Icons.hourglass_empty,
    size: 64,
    color: ColorManager.darkGrey,
    ),
    SizedBox(height: 16),
    Text(
    AppLocalizations.of(context)!.noProductsFound,
    style: Theme
        .of(context)
        .textTheme
        .bodyLarge
        ?.copyWith(
    color: ColorManager.darkGrey,
    ),
    ),
    ],
    ),
    ),
    ),
    ],
    ),
    );
    } else if (state is InspectorHomeProductSuccess) {
    final allRequests = state.productList;

    return Padding(
    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 18.h),
    child: RefreshIndicator(
    color: ColorManager.lightprimary,
    onRefresh: _refreshData,
    child:
            Padding(
              padding: REdgeInsets.symmetric(horizontal: 16),
              child: ListView.separated(
            itemCount: allRequests.length,

                   separatorBuilder: (context, index) {
                  return SizedBox(height: 12.h);
                },
                itemBuilder: (context, index) {
                  final request = allRequests[index];


                  return InspectionRequestCard(inspectionRequest: request, currentKeyword: currentKeyword,
                      onAcceptInspection: () {
                    inspectorAssignProductCubit.assignProduct(productId: request?.id??0, inspectorId: "bf3ad5ae-2b75-45a7-99cc-2b5a39e341a3");}

    );
                  }

    )
    )
    )
    );


    }

    return const SizedBox.shrink();
    },
    );
                },
              ),
            ),

        ],
      ),
    );
  }
}

class InspectionRequestCard extends StatelessWidget {
   InspectionRequestCard({
    required this.inspectionRequest,
    required this.onAcceptInspection,
     required this.currentKeyword,
  });
   AllInpectionEntity inspectionRequest;
  final VoidCallback? onAcceptInspection;
  final String? currentKeyword;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xFF777777).withOpacity(0.5),
        ),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                inspectionRequest?.marketerName??"",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: Color(0xFFC5FEC3),
                ),
                child: Text(
                  AppLocalizations.of(context)!.active,
                  style: GoogleFonts.inter(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF279C07),
                  ),
                ),
              ),
            ],
          ),
          Text(
           inspectionRequest?.productName??"",
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w300,
              color: Color(0xFF4f4f4f),
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.access_time_rounded,
                size: 14,
                color: ColorManager.lightprimary,
              ),
              SizedBox(width: 6.w),
                              Text(
                (currentKeyword != null && currentKeyword!.isNotEmpty) ? "${inspectionRequest.date != null
                       ? DateFormat('MMMM d yyyy').format(DateTime.parse(inspectionRequest.date!))
                       : AppLocalizations.of(context)!.noDataFound} ${inspectionRequest.time != null
                       ? formatTime(inspectionRequest.time!)
                       : AppLocalizations.of(context)!.noDataFound}" : "${inspectionRequest.preferredDate != null
     ? DateFormat('MMMM d yyyy').format(DateTime.parse(inspectionRequest.preferredDate!))
         : AppLocalizations.of(context)!.noDataFound} ${inspectionRequest.preferredTime != null
     ? formatTime(inspectionRequest.preferredTime!)
         : AppLocalizations.of(context)!.noDataFound}",
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
            inspectionRequest?.address??"",



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
              "Accept Inspection",
              style: Theme.of(context).textTheme.bodyLarge
                  ?.copyWith(
                    color: ColorManager.white,
                    fontSize: 16.sp,
                  ),
            ),
            color: Theme.of(context).primaryColor,
            borderColor: Theme.of(context).primaryColor,
            onPressed: onAcceptInspection

          ),
        ],
      ),
    );
  }
}
