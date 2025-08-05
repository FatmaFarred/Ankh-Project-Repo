import 'used_details_entity.dart';

class ProductManagementEntity {
  final int id;
  final String title;
  final String description;
  final int commission;
  final int marketerPoints;
  final int inspectorPoints;
  final int requiredPoints;
  final String? topBrandName;
  final String make;
  final String model;
  final String category;
  final int year;
  final int mileage;
  final String color;
  final String code;
  final bool isUsedVehicle;
  final String status;
  final String price;
  final int rating;
  final int views;
  final String transmission;
  final String fuelType;
  final String driveType;
  final String engineType;
  final int horsepower;
  final String batteryCapacity;
  final List<String> videoUrl;
  final List<String> imageUrls;
  final DateTime createdAt;
  final DateTime lastEditedAt;
  final UsedDetailsEntity? usedDetails;

  ProductManagementEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.commission,
    required this.inspectorPoints,
    required this.marketerPoints,
    required this.requiredPoints,
    this.topBrandName,
    required this.make,
    required this.model,
    required this.category,
    required this.year,
    required this.mileage,
    required this.color,
    required this.code,
    required this.isUsedVehicle,
    required this.status,
    required this.price,
    required this.rating,
    required this.views,
    required this.transmission,
    required this.fuelType,
    required this.driveType,
    required this.engineType,
    required this.horsepower,
    required this.batteryCapacity,
    required this.videoUrl,
    required this.imageUrls,
    required this.createdAt,
    required this.lastEditedAt,
    this.usedDetails,
  });
}
