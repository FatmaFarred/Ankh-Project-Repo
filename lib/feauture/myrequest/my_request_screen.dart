import 'dart:ui';

import 'package:flutter/material.dart';

import '../../core/customized_widgets/reusable_widgets/customized_containers/rounded_conatiner_image.dart';

enum RequestStatus { pending, done, delayed, notResponded }

class RequestModel {
  final String carName;
  final String clientName;
  final DateTime createdAt;
  final String priceRange;
  final RequestStatus status;
  final String? imagePath;

  RequestModel( {
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
      return Colors.amber;
    case RequestStatus.done:
      return Colors.green;
    case RequestStatus.delayed:
      return Colors.redAccent;
    case RequestStatus.notResponded:
      return Colors.grey;
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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  List<RequestModel> getFilteredRequests(int index) {
    if (index == 0) return mockRequests;
    final status = RequestStatus.values[index - 1];
    return mockRequests.where((r) => r.status == status).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Requests'),
          bottom: TabBar(
            controller: _tabController,
            isScrollable: true,
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
        body: ListView.builder(
          itemCount: getFilteredRequests(_tabController.index).length,
          itemBuilder: (context, index) {
            final request = getFilteredRequests(_tabController.index)[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: ListTile(
                  leading: RoundedContainerWidget(
                    width: 50,
                    height: 50,
                    imagePath:request?.imagePath??"" ,

                  ),
                title: Text(request.carName),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Client: ${request.clientName}'),
                    Text('Created: ${request.createdAt}'),
                    Text('Price: ${request.priceRange}'),
                  ],
                ),
                trailing: Chip(
                  backgroundColor: getStatusColor(request.status),
                  label: Text(getStatusLabel(request.status)),
                ),
                onTap: (){} /*=> Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RequestDetailScreen(request: request),
                  ),
                ),*/
              ),
            );
          },
        ),
      ),
    );
  }
}

