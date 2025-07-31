// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_management_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductManagementDetailsModel _$ProductManagementDetailsModelFromJson(
        Map<String, dynamic> json) =>
    ProductManagementDetailsModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      commission: (json['commission'] as num).toInt(),
      requiredPoints: (json['requiredPoints'] as num).toInt(),
      topBrandName: json['topBrandName'] as String?,
      make: json['make'] as String,
      model: json['model'] as String,
      category: json['category'] as String,
      year: (json['year'] as num).toInt(),
      mileage: (json['mileage'] as num).toInt(),
      color: json['color'] as String,
      code: json['code'] as String,
      isUsedVehicle: json['isUsedVehicle'] as bool,
      status: json['status'] as String,
      price: json['price'] as String,
      rating: (json['rating'] as num).toInt(),
      views: (json['views'] as num).toInt(),
      transmission: json['transmission'] as String,
      fuelType: json['fuelType'] as String,
      driveType: json['driveType'] as String,
      engineType: json['engineType'] as String,
      horsepower: (json['horsepower'] as num).toInt(),
      batteryCapacity: json['batteryCapacity'] as String,
      imageUrls:
          (json['imageUrls'] as List<dynamic>).map((e) => e as String).toList(),
      videoUrl:
          (json['videoUrl'] as List<dynamic>).map((e) => e as String).toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastEditedAt: DateTime.parse(json['lastEditedAt'] as String),
    );

Map<String, dynamic> _$ProductManagementDetailsModelToJson(
        ProductManagementDetailsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'commission': instance.commission,
      'requiredPoints': instance.requiredPoints,
      'topBrandName': instance.topBrandName,
      'make': instance.make,
      'model': instance.model,
      'category': instance.category,
      'year': instance.year,
      'mileage': instance.mileage,
      'color': instance.color,
      'code': instance.code,
      'isUsedVehicle': instance.isUsedVehicle,
      'status': instance.status,
      'price': instance.price,
      'rating': instance.rating,
      'views': instance.views,
      'transmission': instance.transmission,
      'fuelType': instance.fuelType,
      'driveType': instance.driveType,
      'engineType': instance.engineType,
      'horsepower': instance.horsepower,
      'batteryCapacity': instance.batteryCapacity,
      'videoUrl': instance.videoUrl,
      'imageUrls': instance.imageUrls,
      'createdAt': instance.createdAt.toIso8601String(),
      'lastEditedAt': instance.lastEditedAt.toIso8601String(),
    };
