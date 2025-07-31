// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'used_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsedDetailsModel _$UsedDetailsModelFromJson(Map<String, dynamic> json) =>
    UsedDetailsModel(
      ownerName: json['ownerName'] as String?,
      address: json['address'] as String?,
      licenseImage: json['licenseImage'] as String?,
      insuranceCardFront: json['insuranceCardFront'] as String?,
      insuranceCardBack: json['insuranceCardBack'] as String?,
      licenseExpiryDate: json['licenseExpiryDate'] == null
          ? null
          : DateTime.parse(json['licenseExpiryDate'] as String),
      safetyReport: json['safetyReport'] as String?,
      taxStatus: json['taxStatus'] as String?,
      interiorCondition: json['interiorCondition'] as String?,
      exteriorCondition: json['exteriorCondition'] as String?,
      additionalSpecs: json['additionalSpecs'] as String?,
      additionalInfo: json['additionalInfo'] as String?,
      paymentMethod: json['paymentMethod'] as String?,
      inspectionResult: json['inspectionResult'] as String?,
      accidentHistory: json['accidentHistory'] as String?,
      testDriveAvailable: json['testDriveAvailable'] as bool?,
      warrantyStatus: json['warrantyStatus'] as String?,
      tireStatus: json['tireStatus'] as String?,
      lightStatus: json['lightStatus'] as String?,
      safetyStatus: json['safetyStatus'] as String?,
      licenseDuration: json['licenseDuration'] as String?,
      trafficViolations: json['trafficViolations'] as String?,
      insuranceStatus: json['insuranceStatus'] as String?,
      numberOfKeys: json['numberOfKeys'] as String?,
      seatCondition: json['seatCondition'] as String?,
      gearCondition: json['gearCondition'] as String?,
      driveSystemCondition: json['driveSystemCondition'] as String?,
      brakesCondition: json['brakesCondition'] as String?,
      tags: json['tags'] as String?,
    );

Map<String, dynamic> _$UsedDetailsModelToJson(UsedDetailsModel instance) =>
    <String, dynamic>{
      'ownerName': instance.ownerName,
      'address': instance.address,
      'licenseImage': instance.licenseImage,
      'insuranceCardFront': instance.insuranceCardFront,
      'insuranceCardBack': instance.insuranceCardBack,
      'licenseExpiryDate': instance.licenseExpiryDate?.toIso8601String(),
      'safetyReport': instance.safetyReport,
      'taxStatus': instance.taxStatus,
      'interiorCondition': instance.interiorCondition,
      'exteriorCondition': instance.exteriorCondition,
      'additionalSpecs': instance.additionalSpecs,
      'additionalInfo': instance.additionalInfo,
      'paymentMethod': instance.paymentMethod,
      'inspectionResult': instance.inspectionResult,
      'accidentHistory': instance.accidentHistory,
      'testDriveAvailable': instance.testDriveAvailable,
      'warrantyStatus': instance.warrantyStatus,
      'tireStatus': instance.tireStatus,
      'lightStatus': instance.lightStatus,
      'safetyStatus': instance.safetyStatus,
      'licenseDuration': instance.licenseDuration,
      'trafficViolations': instance.trafficViolations,
      'insuranceStatus': instance.insuranceStatus,
      'numberOfKeys': instance.numberOfKeys,
      'seatCondition': instance.seatCondition,
      'gearCondition': instance.gearCondition,
      'driveSystemCondition': instance.driveSystemCondition,
      'brakesCondition': instance.brakesCondition,
      'tags': instance.tags,
    };
