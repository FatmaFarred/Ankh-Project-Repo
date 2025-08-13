class ProductPostEntity {
  final String nameProductId;
  final String description;
  final String price;
  final String category;
  final String transmission;
  final String engineType;
  final String year;
  final String mileage;
  final String color;
  final String commission;
  final String inspectorPoints;
  final String marketerPoints;
  final String requiredPoints;
  final String topBrandId;
  final String make;
  final String model;
  final String status;
  final String rating;
  final String fuelType;
  final String driveType;
  final String horsepower;
  final String batteryCapacity;
  final bool? isUsedVehicle;
  final List<String>? images;
  final List<String>? videoPath;
  final Map<String, dynamic>? usedDetails;

  ProductPostEntity({
    required this.nameProductId,
    required this.description,
    required this.price,
    required this.category,
    required this.transmission,
    required this.engineType,
    required this.year,
    required this.mileage,
    required this.color,
    required this.commission,
    required this.inspectorPoints,
    required this.marketerPoints,
    required this.requiredPoints,
    required this.topBrandId,
    required this.make,
    required this.model,
    required this.status,
    required this.rating,
    required this.fuelType,
    required this.driveType,
    required this.horsepower,
    required this.batteryCapacity,
    this.isUsedVehicle,
    this.images,
    this.videoPath,
    this.usedDetails,

  });
}
