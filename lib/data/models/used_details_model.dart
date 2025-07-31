import 'package:json_annotation/json_annotation.dart';
import '../../../domain/entities/used_details_entity.dart';

part 'used_details_model.g.dart';

@JsonSerializable()
class UsedDetailsModel extends UsedDetailsEntity {
   UsedDetailsModel({
    required super.ownerName,
    required super.address,
    required super.licenseImage,
    required super.insuranceCardFront,
    required super.insuranceCardBack,
    required super.licenseExpiryDate,
    required super.safetyReport,
    required super.taxStatus,
    required super.interiorCondition,
    required super.exteriorCondition,
    required super.additionalSpecs,
    required super.additionalInfo,
    required super.paymentMethod,
    required super.inspectionResult,
    super.accidentHistory,
    required super.testDriveAvailable,
    required super.warrantyStatus,
    required super.tireStatus,
    required super.lightStatus,
    super.safetyStatus,
    required super.licenseDuration,
    required super.trafficViolations,
    required super.insuranceStatus,
    required super.numberOfKeys,
    required super.seatCondition,
    required super.gearCondition,
    required super.driveSystemCondition,
    required super.brakesCondition,
    super.tags,
  });

   factory UsedDetailsModel.fromEntity(UsedDetailsEntity entity) {
    return UsedDetailsModel(
     ownerName: entity.ownerName,
     address: entity.address,
     licenseImage: entity.licenseImage,
     insuranceCardFront: entity.insuranceCardFront,
     insuranceCardBack: entity.insuranceCardBack,
     licenseExpiryDate: entity.licenseExpiryDate,
     safetyReport: entity.safetyReport,
     taxStatus: entity.taxStatus,
     interiorCondition: entity.interiorCondition,
     exteriorCondition: entity.exteriorCondition,
     additionalSpecs: entity.additionalSpecs,
     additionalInfo: entity.additionalInfo,
     paymentMethod: entity.paymentMethod,
     inspectionResult: entity.inspectionResult,
     accidentHistory: entity.accidentHistory,
     testDriveAvailable: entity.testDriveAvailable,
     warrantyStatus: entity.warrantyStatus,
     tireStatus: entity.tireStatus,
     lightStatus: entity.lightStatus,
     safetyStatus: entity.safetyStatus,
     licenseDuration: entity.licenseDuration,
     trafficViolations: entity.trafficViolations,
     insuranceStatus: entity.insuranceStatus,
     numberOfKeys: entity.numberOfKeys,
     seatCondition: entity.seatCondition,
     gearCondition: entity.gearCondition,
     driveSystemCondition: entity.driveSystemCondition,
     brakesCondition: entity.brakesCondition,
     tags: entity.tags,
    );
   }

  factory UsedDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$UsedDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$UsedDetailsModelToJson(this);
}
