import 'dart:ui';

import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../core/constants/font_manager/font_style_manager.dart';
import '../../core/customized_widgets/reusable_widgets/customized_containers/rounded_conatiner_image.dart';
import '../../l10n/app_localizations.dart';

enum RequestStatus { pending, done, delayed, notResponded }

class RequestModel {
  final String carName;
  final String clientName;
  final DateTime createdAt;
  final String priceRange;
  final RequestStatus status;
  final String? imagePath;

  RequestModel({
    required this.carName,
    required this.clientName,
    required this.createdAt,
    required this.priceRange,
    required this.status,
    required this.imagePath,
  });
}

Color getStatusColor(RequestStatus status) {
  switch (status) {
    case RequestStatus.pending:
      return Colors.amber.withOpacity(0.2);
    case RequestStatus.done:
      return Colors.green.withOpacity(0.2);
    case RequestStatus.delayed:
      return Colors.redAccent.withOpacity(0.2);
    case RequestStatus.notResponded:
      return Colors.grey.withOpacity(0.2);
  }
}

String getStatusLabel(RequestStatus status) {
  switch (status) {
    case RequestStatus.pending:
      return 'Pending';
    case RequestStatus.done:
      return 'Done';
    case RequestStatus.delayed:
      return 'Delayed';
    case RequestStatus.notResponded:
      return 'Not Responded';
  }
}

final List<RequestModel> mockRequests = [
  RequestModel(
    carName: 'Toyota EX30',
    clientName: 'John Smith',
    createdAt: DateTime(2025, 12, 10, 14),
    priceRange: 'EGP 1.9M - 2.3M',
    status: RequestStatus.pending,
    imagePath: 'assets/images/car.png',
  ),
  RequestModel(
    carName: 'Toyota EX40',
    clientName: 'Alex Doe',
    createdAt: DateTime(2025, 1, 12, 15, 3),
    priceRange: 'EGP 1.8M - 2.1M',
    status: RequestStatus.done,
    imagePath: 'assets/images/car.png',
  ),
  RequestModel(
    carName: 'Toyota EX50',
    clientName: 'Sara Fade',
    createdAt: DateTime(2025, 2, 8, 7, 21),
    priceRange: 'EGP 1.2M - 1.8M',
    status: RequestStatus.delayed,
    imagePath: 'assets/images/car.png',
  ),
  RequestModel(
    carName: 'Toyota EX30',
    clientName: 'John Smith',
    createdAt: DateTime(2025, 12, 10, 14),
    priceRange: 'EGP 1.9M - 2.3M',
    status: RequestStatus.notResponded,
    imagePath: 'assets/images/car.png',
  ),
];

// UI
class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  List<RequestModel> getFilteredRequests(int index) {
    List<RequestModel> filtered = index == 0
        ? mockRequests
        : mockRequests
              .where((r) => r.status == RequestStatus.values[index - 1])
              .toList();
    if (_searchController.text.isNotEmpty) {
      filtered = filtered
          .where(
            (r) =>
                r.carName.toLowerCase().contains(
                  _searchController.text.toLowerCase(),
                ) ||
                r.clientName.toLowerCase().contains(
                  _searchController.text.toLowerCase(),
                ),
          )
          .toList();
    }
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(title: Text(AppLocalizations.of(context)!.myRequests)),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 26.h, horizontal: 20.w),
              child: TextFormField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: '${AppLocalizations.of(context)!.searchRequest}...',
                  hintStyle: getRegularStyle(
                    color: ColorManager.darkGrey,
                    fontSize: 14,
                    context: context,
                  ),
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.r),
                    borderSide: BorderSide(color: ColorManager.lightGrey),
                  ),
                ),
                onChanged: (_) => setState(() {}),
              ),
            ),
            Container(
              color: ColorManager.transparent, // Optional background
              child: TabBar(
                tabAlignment: TabAlignment.center,
                dividerColor: ColorManager.transparent,
                controller: _tabController,
                isScrollable: true,
                labelStyle: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: ColorManager.white),
                unselectedLabelStyle: Theme.of(context).textTheme.bodyMedium,

                indicator: BoxDecoration(
                  color: Theme.of(context).primaryColor,

                  borderRadius: BorderRadius.circular(16.r), // Rounded corners
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: const [
                  Tab(text: 'All'),
                  Tab(text: 'Pending'),
                  Tab(text: 'Done'),
                  Tab(text: 'Delayed'),
                  Tab(text: 'Not Responded'),
                ],
                onTap: (_) => setState(() {}),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: List.generate(5, (tabIndex) {
                  final filteredRequests = getFilteredRequests(tabIndex);
                  return ListView.builder(
                    itemCount: filteredRequests.length,

                    itemBuilder: (context, index) {
                      final request = filteredRequests[index];
                      return CarRequestCard(request: request);
                      ;
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CarRequestCard extends StatelessWidget {
  const CarRequestCard({
    super.key,
    required this.request,
    this.showLabel = true,
  });

  final RequestModel request;
  final bool showLabel;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorManager.white,
      elevation: 2,
      margin: EdgeInsets.symmetric(horizontal: 17.w, vertical: 13.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
        side: BorderSide(color: ColorManager.lightGrey),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image (Leading)
            RoundedContainerWidget(
              width: 138.w,
              height: 114.h,
              imagePath: request.imagePath ?? "",
            ),

            SizedBox(width: 12.w),

            // Details and Status
            Expanded(
              child: Stack(
                children: [
                  // Info
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 4.h), // spacing below chip
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            request.carName,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          showLabel
                              ? Chip(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 5.w,
                                    vertical: 4.h,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.r),
                                  ),
                                  backgroundColor: getStatusColor(
                                    request.status,
                                  ),
                                  label: Text(
                                    getStatusLabel(request.status),
                                    style: getBoldStyle(
                                      fontSize: 12.sp,
                                      color: getStatusColor(
                                        request.status,
                                      ).withOpacity(1),
                                      context: context,
                                    ),
                                  ),
                                )
                              : SizedBox(),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "${AppLocalizations.of(context)!.client}: ${request.clientName}",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: ColorManager.darkGrey,
                          fontSize: 12.sp,
                        ),
                      ),
                      Text(
                        "${AppLocalizations.of(context)!.created}: ${DateFormat('dd MMM yyyy, hh:mm a').format(request.createdAt)}",

                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: ColorManager.darkGrey,
                          fontSize: 12.sp,
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context)!.price,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: ColorManager.darkGrey,
                          fontSize: 12.sp,
                        ),
                      ),
                      Text(
                        request.priceRange,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
