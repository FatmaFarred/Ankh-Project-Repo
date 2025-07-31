import 'package:json_annotation/json_annotation.dart';
import '../../../domain/entities/product_management_details_entity.dart';
import '../../domain/entities/used_details_entity.dart';
import 'used_details_model.dart';

part 'product_management_details_model.g.dart';

@JsonSerializable()
class ProductManagementDetailsModel extends ProductManagementDetailsEntity {
  @JsonKey(fromJson: _usedDetailsFromJson, toJson: _usedDetailsToJson)
  final UsedDetailsModel? _usedDetails;

  const ProductManagementDetailsModel({
    // all your required super fields, including code!
    required super.id,
    required super.title,
    required super.description,
    required super.commission,
    required super.requiredPoints,
    required super.topBrandName,
    required super.make,
    required super.model,
    required super.category,
    required super.year,
    required super.mileage,
    required super.color,
    required super.code,
    required super.isUsedVehicle,
    required super.status,
    required super.price,
    required super.rating,
    required super.views,
    required super.transmission,
    required super.fuelType,
    required super.driveType,
    required super.engineType,
    required super.horsepower,
    required super.batteryCapacity,
    required super.imageUrls,
    required super.videoUrl,
    required super.createdAt,
    required super.lastEditedAt,
    UsedDetailsModel? usedDetails,
  })  : _usedDetails = usedDetails,
        super(usedDetails: usedDetails);

  @override
  @JsonKey(ignore: true)  // <- Add this here to ignore getter in json serialization
  UsedDetailsEntity? get usedDetails => _usedDetails;

  factory ProductManagementDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$ProductManagementDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductManagementDetailsModelToJson(this);

  static UsedDetailsModel? _usedDetailsFromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    return UsedDetailsModel.fromJson(json);
  }

  static Map<String, dynamic>? _usedDetailsToJson(UsedDetailsModel? details) {
    return details?.toJson();
  }
}

