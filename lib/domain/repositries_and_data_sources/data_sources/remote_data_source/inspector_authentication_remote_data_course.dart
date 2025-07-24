import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../api_service/failure/error_handling.dart';
import '../../../../data/models/user_model.dart';
import '../../../entities/authentication_response_entity.dart';

abstract class InspectorAuthenticationRemoteDataSource {
  Future<Either<Failure, AuthenticationResponseEntity>> registerInspector(
      String name,
      String email,
      String password,
      String phone,
      String licenseNumber,
      String vehicleLicenseNumber,
      File licenseImage,
      File vehicleImage,
      String workArea,
      String vehicleType,

      );
} 