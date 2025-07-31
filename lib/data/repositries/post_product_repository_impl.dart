import 'dart:io';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/product_post_entity.dart';
import '../../domain/repositries_and_data_sources/repositries/post_product_repository.dart';

@LazySingleton(as: PostProductRepository)
class PostProductRepositoryImpl implements PostProductRepository {
  final Dio dio;

  PostProductRepositoryImpl(this.dio);

  @override
  Future<void> postProduct(ProductPostEntity entity) async {
    try {
      final formData = FormData();

      // --- Add core fields ---
      _addIfNotNull(formData, 'Title', entity.title);
      _addIfNotNull(formData, 'Description', entity.description);
      _addIfNotNull(formData, 'Price', entity.price);
      _addIfNotNull(formData, 'Category', entity.category);
      _addIfNotNull(formData, 'Make', entity.make);
      _addIfNotNull(formData, 'Model', entity.model);
      _addIfNotNull(formData, 'Year', entity.year);
      _addIfNotNull(formData, 'Mileage', entity.mileage);
      _addIfNotNull(formData, 'Color', entity.color);
      _addIfNotNull(formData, 'Status', entity.status);
      _addIfNotNull(formData, 'EngineType', entity.engineType);
      _addIfNotNull(formData, 'Horsepower', entity.horsepower);
      _addIfNotNull(formData, 'BatteryCapacity', entity.batteryCapacity);
      _addIfNotNull(formData, 'Commission', entity.commission);
      _addIfNotNull(formData, 'RequiredPoints', entity.requiredPoints);
      _addIfNotNull(formData, 'TopBrandId', entity.topBrandId);
      _addIfNotNull(formData, 'Transmission', entity.transmission);
      _addIfNotNull(formData, 'FuelType', entity.fuelType);
      _addIfNotNull(formData, 'DriveType', entity.driveType);
      _addIfNotNull(formData, 'IsUsedVehicle', entity.isUsedVehicle?.toString());

      // --- Upload images ---
      if (entity.images != null) {
        for (String imagePath in entity.images!) {
          final file = File(imagePath);
          if (file.existsSync()) {
            final multipartFile = await MultipartFile.fromFile(
              file.path,
              filename: file.path.split('/').last,
            );
            formData.files.add(MapEntry('Images', multipartFile));
          } else {
            print('❌ Image file not found: $imagePath');
          }
        }
      }

      // --- Upload videos ---
      if (entity.videoPath != null) {
        for (String videoPath in entity.videoPath!) {
          final file = File(videoPath);
          if (file.existsSync()) {
            final multipartFile = await MultipartFile.fromFile(
              file.path,
              filename: file.path.split('/').last,
            );
            formData.files.add(MapEntry('Videos', multipartFile));
          } else {
            print('❌ Video file not found: $videoPath');
          }
        }
      }

      // --- Used car details ---
      if (entity.isUsedVehicle == true && entity.usedDetails != null) {
        final details = entity.usedDetails!;

        _addIfNotNull(formData, 'UsedDetails.OwnerName', details['ownerName']);
        _addIfNotNull(formData, 'UsedDetails.Address', details['address']);
        _addIfNotNull(formData, 'UsedDetails.SafetyReport', details['safetyReport']);
        _addIfNotNull(formData, 'UsedDetails.TaxStatus', details['taxStatus']);
        _addIfNotNull(formData, 'UsedDetails.InteriorCondition', details['interiorCondition']);
        _addIfNotNull(formData, 'UsedDetails.ExteriorCondition', details['exteriorCondition']);
        _addIfNotNull(formData, 'UsedDetails.AdditionalSpecs', details['additionalSpecs']);
        _addIfNotNull(formData, 'UsedDetails.AdditionalInfo', details['additionalInfo']);
        _addIfNotNull(formData, 'UsedDetails.PaymentMethod', details['paymentMethod']);
        _addIfNotNull(formData, 'UsedDetails.InspectionResult', details['inspectionResult']);
        _addIfNotNull(formData, 'UsedDetails.AccidentHistory', details['accidentHistory']);
        _addIfNotNull(formData, 'UsedDetails.TestDriveAvailable', details['testDriveAvailable']?.toString());
        _addIfNotNull(formData, 'UsedDetails.WarrantyStatus', details['warrantyStatus']);
        _addIfNotNull(formData, 'UsedDetails.TireStatus', details['tireStatus']);
        _addIfNotNull(formData, 'UsedDetails.LightStatus', details['lightStatus']);
        _addIfNotNull(formData, 'UsedDetails.SafetyStatus', details['safetyStatus']);
        _addIfNotNull(formData, 'UsedDetails.LicenseDuration', details['licenseDuration']);
        _addIfNotNull(formData, 'UsedDetails.TrafficViolations', details['trafficViolations']);
        _addIfNotNull(formData, 'UsedDetails.InsuranceStatus', details['insuranceStatus']);
        _addIfNotNull(formData, 'UsedDetails.NumberOfKeys', details['numberOfKeys']);
        _addIfNotNull(formData, 'UsedDetails.SeatCondition', details['seatCondition']);
        _addIfNotNull(formData, 'UsedDetails.GearCondition', details['gearCondition']);
        _addIfNotNull(formData, 'UsedDetails.DriveSystemCondition', details['driveSystemCondition']);
        _addIfNotNull(formData, 'UsedDetails.BrakesCondition', details['brakesCondition']);

        if (details['tags'] != null) {
          final tagValue = details['tags'] is List
              ? (details['tags'] as List).map((e) => e.toString()).join(', ')
              : details['tags'].toString();
          formData.fields.add(MapEntry('UsedDetails.Tags', tagValue));
        }

        if (details['licenseExpiryDate'] != null) {
          final dateStr = details['licenseExpiryDate'].toString();
          final dateOnly = dateStr.split(' ').first;
          formData.fields.add(MapEntry('UsedDetails.LicenseExpiryDate', dateOnly));
        }

        await _addFileIfExist(formData, 'UsedDetails.LicenseImage', details['licenseImage']);
        await _addFileIfExist(formData, 'UsedDetails.InsuranceCardFront', details['insuranceCardFront']);
        await _addFileIfExist(formData, 'UsedDetails.InsuranceCardBack', details['insuranceCardBack']);
      }

      // --- Debug print FormData before sending ---
      print('📤 Sending product post request...');
      formData.fields.forEach((e) => print('📝 ${e.key}: ${e.value}'));
      formData.files.forEach((e) => print('📎 ${e.key}: ${e.value.filename}'));

      // --- Send request ---
      final response = await dio.post(
        'https://ankhapi.runasp.net/api/Product',
        data: formData,
        options: Options(
          headers: {'Content-Type': 'multipart/form-data'},
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('✅ Product posted successfully');
      } else {
        throw Exception('❌ Server rejected: ${response.statusCode} - ${response.statusMessage}');
      }
    } on DioException catch (e) {
      print('❌ Dio Error: ${e.message}');
      if (e.response != null) {
        print('❗ Response Data: ${e.response?.data}');
      }
      rethrow;
    } catch (e) {
      print('❌ Unexpected Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> editProduct(int id, ProductPostEntity entity) async {
    try {
      final formData = FormData();

      // Reuse the same logic
      _addIfNotNull(formData, 'Title', entity.title);
      _addIfNotNull(formData, 'Description', entity.description);
      _addIfNotNull(formData, 'Price', entity.price);
      _addIfNotNull(formData, 'Category', entity.category);
      _addIfNotNull(formData, 'Make', entity.make);
      _addIfNotNull(formData, 'Model', entity.model);
      _addIfNotNull(formData, 'Year', entity.year);
      _addIfNotNull(formData, 'Mileage', entity.mileage);
      _addIfNotNull(formData, 'Color', entity.color);
      _addIfNotNull(formData, 'Status', entity.status);
      _addIfNotNull(formData, 'EngineType', entity.engineType);
      _addIfNotNull(formData, 'Horsepower', entity.horsepower);
      _addIfNotNull(formData, 'BatteryCapacity', entity.batteryCapacity);
      _addIfNotNull(formData, 'Commission', entity.commission);
      _addIfNotNull(formData, 'RequiredPoints', entity.requiredPoints);
      _addIfNotNull(formData, 'TopBrandId', entity.topBrandId);
      _addIfNotNull(formData, 'Transmission', entity.transmission);
      _addIfNotNull(formData, 'FuelType', entity.fuelType);
      _addIfNotNull(formData, 'DriveType', entity.driveType);
      _addIfNotNull(formData, 'IsUsedVehicle', entity.isUsedVehicle?.toString());

      // Images
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

      // Videos
      if (entity.videoPath != null) {
        for (String videoPath in entity.videoPath!) {
          final file = File(videoPath);
          if (file.existsSync()) {
            final multipartFile = await MultipartFile.fromFile(
              file.path,
              filename: file.path.split('/').last,
            );
            formData.files.add(MapEntry('Videos', multipartFile));
          }
        }
      }

      // Used car details
      if (entity.isUsedVehicle == true && entity.usedDetails != null) {
        final details = entity.usedDetails!;
        _addIfNotNull(formData, 'UsedDetails.OwnerName', details['ownerName']);
        _addIfNotNull(formData, 'UsedDetails.Address', details['address']);
        _addIfNotNull(formData, 'UsedDetails.SafetyReport', details['safetyReport']);
        _addIfNotNull(formData, 'UsedDetails.TaxStatus', details['taxStatus']);
        _addIfNotNull(formData, 'UsedDetails.InteriorCondition', details['interiorCondition']);
        _addIfNotNull(formData, 'UsedDetails.ExteriorCondition', details['exteriorCondition']);
        _addIfNotNull(formData, 'UsedDetails.AdditionalSpecs', details['additionalSpecs']);
        _addIfNotNull(formData, 'UsedDetails.AdditionalInfo', details['additionalInfo']);
        _addIfNotNull(formData, 'UsedDetails.PaymentMethod', details['paymentMethod']);
        _addIfNotNull(formData, 'UsedDetails.InspectionResult', details['inspectionResult']);
        _addIfNotNull(formData, 'UsedDetails.AccidentHistory', details['accidentHistory']);
        _addIfNotNull(formData, 'UsedDetails.TestDriveAvailable', details['testDriveAvailable']?.toString());
        _addIfNotNull(formData, 'UsedDetails.WarrantyStatus', details['warrantyStatus']);
        _addIfNotNull(formData, 'UsedDetails.TireStatus', details['tireStatus']);
        _addIfNotNull(formData, 'UsedDetails.LightStatus', details['lightStatus']);
        _addIfNotNull(formData, 'UsedDetails.SafetyStatus', details['safetyStatus']);
        _addIfNotNull(formData, 'UsedDetails.LicenseDuration', details['licenseDuration']);
        _addIfNotNull(formData, 'UsedDetails.TrafficViolations', details['trafficViolations']);
        _addIfNotNull(formData, 'UsedDetails.InsuranceStatus', details['insuranceStatus']);
        _addIfNotNull(formData, 'UsedDetails.NumberOfKeys', details['numberOfKeys']);
        _addIfNotNull(formData, 'UsedDetails.SeatCondition', details['seatCondition']);
        _addIfNotNull(formData, 'UsedDetails.GearCondition', details['gearCondition']);
        _addIfNotNull(formData, 'UsedDetails.DriveSystemCondition', details['driveSystemCondition']);
        _addIfNotNull(formData, 'UsedDetails.BrakesCondition', details['brakesCondition']);

        if (details['tags'] != null) {
          final tagValue = details['tags'] is List
              ? (details['tags'] as List).map((e) => e.toString()).join(', ')
              : details['tags'].toString();
          formData.fields.add(MapEntry('UsedDetails.Tags', tagValue));
        }

        if (details['licenseExpiryDate'] != null) {
          final dateOnly = details['licenseExpiryDate'].toString().split(' ').first;
          formData.fields.add(MapEntry('UsedDetails.LicenseExpiryDate', dateOnly));
        }

        await _addFileIfExist(formData, 'UsedDetails.LicenseImage', details['licenseImage']);
        await _addFileIfExist(formData, 'UsedDetails.InsuranceCardFront', details['insuranceCardFront']);
        await _addFileIfExist(formData, 'UsedDetails.InsuranceCardBack', details['insuranceCardBack']);
      }

      // Debug log
      print('📤 Sending product edit request...');
      formData.fields.forEach((e) => print('📝 ${e.key}: ${e.value}'));
      formData.files.forEach((e) => print('📎 ${e.key}: ${e.value.filename}'));

      // 🔄 PUT request
      final response = await dio.put(
        'https://ankhapi.runasp.net/api/Product/$id',
        data: formData,
        options: Options(
          headers: {'Content-Type': 'multipart/form-data'},
        ),
      );

      if (response.statusCode == 200) {
        print('✅ Product edited successfully');
      } else {
        throw Exception('❌ Server rejected: ${response.statusCode} - ${response.statusMessage}');
      }
    } on DioException catch (e) {
      print('❌ Dio Error: ${e.message}');
      if (e.response != null) {
        print('❗ Response Data: ${e.response?.data}');
      }
      rethrow;
    } catch (e) {
      print('❌ Unexpected Error: $e');
      rethrow;
    }
  }


  void _addIfNotNull(FormData formData, String key, dynamic value) {
    if (value != null) {
      formData.fields.add(MapEntry(key, value.toString()));
    }
  }

  Future<void> _addFileIfExist(FormData formData, String key, String? path) async {
    if (path == null) return;
    final file = File(path);
    if (file.existsSync()) {
      final mpFile = await MultipartFile.fromFile(file.path, filename: file.path.split('/').last);
      formData.files.add(MapEntry(key, mpFile));
    } else {
      print('❌ File not found for $key: $path');
    }
  }
}
