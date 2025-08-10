import '../../domain/entities/product_post_entity.dart';

class ProductPostModel {
  static Map<String, dynamic> toFormData(ProductPostEntity entity) {
    final data = <String, dynamic>{
      'nameProductId': entity.nameProductId,
      'description': entity.description,
      'price': entity.price,
      'category': entity.category,
      'transmission': entity.transmission,
      'engineType': entity.engineType,
      'year': entity.year,
      'mileage': entity.mileage,
      'color': entity.color,
      'commission': entity.commission,
      'requiredPoints': entity.requiredPoints,
      'inspectorPoints': entity.inspectorPoints,
      'marketerPoints': entity.marketerPoints,
      'TopBrandId': entity.topBrandId,
      'make': entity.make,
      'model': entity.model,
      'status': entity.status,
      'rating': entity.rating,
      'fuelType': entity.fuelType,
      'driveType': entity.driveType,
      'horsepower': entity.horsepower,
      'batteryCapacity': entity.batteryCapacity,
      'isUsedVehicle': entity.isUsedVehicle?.toString(),
    };

    // Flatten usedDetails if present
    if (entity.usedDetails != null) {
      entity.usedDetails!.forEach((key, value) {
        data['usedDetails.$key'] = value;
      });
    }

    return data;
  }
}
