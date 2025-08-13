import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ankh_project/domain/entities/product_post_entity.dart';

abstract class PostProductRemoteDataSource {
  Future<void> postProduct(ProductPostEntity entity);
}

class PostProductRemoteDataSourceImpl implements PostProductRemoteDataSource {
  final Dio dio;

  PostProductRemoteDataSourceImpl(this.dio);

  @override
  Future<void> postProduct(ProductPostEntity entity) async {
    try {
      final formData = FormData();

      // --- الحقول الأساسية (PascalCase كما في السواجر) ---
      formData.fields
        ..add(MapEntry('nameProductId', entity.nameProductId ?? ''))
        ..add(MapEntry('Description', entity.description ?? ''))
        ..add(MapEntry('Commission', (entity.commission ?? 0).toString()))
        ..add(MapEntry('RequiredPoints', (entity.requiredPoints ?? 0).toString()))
        ..add(MapEntry('TopBrandId', (entity.topBrandId ?? 0).toString()))
        ..add(MapEntry('Make', entity.make ?? ''))
        ..add(MapEntry('Model', entity.model ?? ''))
        ..add(MapEntry('Category', entity.category ?? ''))
        ..add(MapEntry('Year', (entity.year ?? 0).toString()))
        ..add(MapEntry('Mileage', (entity.mileage ?? 0).toString()))
        ..add(MapEntry('Color', entity.color ?? ''))
        ..add(MapEntry('IsUsedVehicle', entity.isUsedVehicle.toString()))
        ..add(MapEntry('Status', (entity.status ?? 0).toString()))
        ..add(MapEntry('Price', entity.price ?? '0'))
        ..add(MapEntry('Transmission', (entity.transmission ?? 0).toString()))
        ..add(MapEntry('FuelType', (entity.fuelType ?? 0).toString()))
        ..add(MapEntry('DriveType', (entity.driveType ?? 0).toString()))
        ..add(MapEntry('EngineType', entity.engineType ?? ''))
        ..add(MapEntry('Horsepower', (entity.horsepower ?? 0).toString()))
        ..add(MapEntry('BatteryCapacity', entity.batteryCapacity ?? ''));

      // --- رفع صور السيارة ---
      if (entity.images != null) {
        for (String imagePath in entity.images!) {
          final file = File(imagePath);
          if (file.existsSync()) {
            final multipartFile = await MultipartFile.fromFile(
              file.path,
              filename: file.path.split('/').last,
            );
            formData.files.add(MapEntry('Images', multipartFile));
          }
        }
      }

      // --- رفع فيديوهات السيارة ---

      // --- تفاصيل المستعمل (UsedDetails) ---
      if (entity.usedDetails != null) {
        final details = entity.usedDetails!;

        // الحقول النصية - فقط إذا كانت غير null، ونحولها لـ String
        final List<MapEntry<String, String>> usedTextFields = [
          if (details['ownerName'] != null)
            MapEntry('UsedDetails.OwnerName', details['ownerName'].toString()),
          if (details['address'] != null)
            MapEntry('UsedDetails.Address', details['address'].toString()),
          if (details['licenseExpiryDate'] != null)
            MapEntry('UsedDetails.LicenseExpiryDate', details['licenseExpiryDate'].toString()),
          if (details['safetyReport'] != null)
            MapEntry('UsedDetails.SafetyReport', details['safetyReport'].toString()),
          if (details['taxStatus'] != null)
            MapEntry('UsedDetails.TaxStatus', details['taxStatus'].toString()),
          if (details['interiorCondition'] != null)
            MapEntry('UsedDetails.InteriorCondition', details['interiorCondition'].toString()),
          if (details['exteriorCondition'] != null)
            MapEntry('UsedDetails.ExteriorCondition', details['exteriorCondition'].toString()),
          if (details['additionalSpecs'] != null)
            MapEntry('UsedDetails.AdditionalSpecs', details['additionalSpecs'].toString()),
          if (details['additionalInfo'] != null)
            MapEntry('UsedDetails.AdditionalInfo', details['additionalInfo'].toString()),
          if (details['paymentMethod'] != null)
            MapEntry('UsedDetails.PaymentMethod', details['paymentMethod'].toString()),
          if (details['inspectionResult'] != null)
            MapEntry('UsedDetails.InspectionResult', details['inspectionResult'].toString()),
          if (details['accidentHistory'] != null)
            MapEntry('UsedDetails.AccidentHistory', details['accidentHistory'].toString()),
          if (details['testDriveAvailable'] != null)
            MapEntry('UsedDetails.TestDriveAvailable', details['testDriveAvailable'].toString()),
          if (details['warrantyStatus'] != null)
            MapEntry('UsedDetails.WarrantyStatus', details['warrantyStatus'].toString()),
          if (details['tireStatus'] != null)
            MapEntry('UsedDetails.TireStatus', details['tireStatus'].toString()),
          if (details['lightStatus'] != null)
            MapEntry('UsedDetails.LightStatus', details['lightStatus'].toString()),
          if (details['safetyStatus'] != null)
            MapEntry('UsedDetails.SafetyStatus', details['safetyStatus'].toString()),
          if (details['licenseDuration'] != null)
            MapEntry('UsedDetails.LicenseDuration', details['licenseDuration'].toString()),
          if (details['trafficViolations'] != null)
            MapEntry('UsedDetails.TrafficViolations', details['trafficViolations'].toString()),
          if (details['insuranceStatus'] != null)
            MapEntry('UsedDetails.InsuranceStatus', details['insuranceStatus'].toString()),
          if (details['numberOfKeys'] != null)
            MapEntry('UsedDetails.NumberOfKeys', details['numberOfKeys'].toString()),
          if (details['seatCondition'] != null)
            MapEntry('UsedDetails.SeatCondition', details['seatCondition'].toString()),
          if (details['gearCondition'] != null)
            MapEntry('UsedDetails.GearCondition', details['gearCondition'].toString()),
          if (details['driveSystemCondition'] != null)
            MapEntry('UsedDetails.DriveSystemCondition', details['driveSystemCondition'].toString()),
          if (details['brakesCondition'] != null)
            MapEntry('UsedDetails.BrakesCondition', details['brakesCondition'].toString()),
          if (details['tags'] != null)
            MapEntry('UsedDetails.Tags', details['tags'].toString()),
        ];

        // إضافة الحقول النصية
        formData.fields.addAll(usedTextFields);

        // --- رفع صور UsedDetails ---
        if (details['licenseImage'] != null) {
          final file = File(details['licenseImage']);
          if (file.existsSync()) {
            final multipartFile = await MultipartFile.fromFile(
              file.path,
              filename: file.path.split('/').last,
            );
            formData.files.add(MapEntry('UsedDetails.LicenseImage', multipartFile));
          }
        }

        if (details['insuranceCardFront'] != null) {
          final file = File(details['insuranceCardFront']);
          if (file.existsSync()) {
            final multipartFile = await MultipartFile.fromFile(
              file.path,
              filename: file.path.split('/').last,
            );
            formData.files.add(MapEntry('UsedDetails.InsuranceCardFront', multipartFile));
          }
        }

        if (details['insuranceCardBack'] != null) {
          final file = File(details['insuranceCardBack']);
          if (file.existsSync()) {
            final multipartFile = await MultipartFile.fromFile(
              file.path,
              filename: file.path.split('/').last,
            );
            formData.files.add(MapEntry('UsedDetails.InsuranceCardBack', multipartFile));
          }
        }
      }

      // --- الإرسال للسيرفر ---
      final response = await dio.post(
        'https://ankhapi.runasp.net/api/Product', // ✅ بدون مسافات
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      // التحقق من الاستجابة
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('فشل في إضافة السيارة: ${response.statusMessage}\n${response.data}');
      }

      print('✅ تم إرسال السيارة بنجاح: ${response.data}');
    } on DioException catch (e) {
      print('❌ Dio Exception: ${e.message}');
      if (e.response != null) {
        print('❌ Status Code: ${e.response?.statusCode}');
        print('❌ Response: ${e.response?.data}');
      }
      rethrow;
    } catch (e) {
      print('❌ خطأ غير متوقع: $e');
      rethrow;
    }
  }
}