import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../api_service/failure/error_handling.dart';
import '../../entities/authentication_response_entity.dart';
import '../../repositries_and_data_sources/repositries/inspector_authentication_repositry.dart';

@injectable
class InspectorRegisterUseCase {
  final InspectorAuthenticationRepositry inspectorAuthRepository;

  InspectorRegisterUseCase(this.inspectorAuthRepository);

  Future<Either<Failure, AuthenticationResponseEntity>> execute(
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
  ) {
    return inspectorAuthRepository.registerInspector(
      name, email, password, phone, licenseNumber, vehicleLicenseNumber, licenseImage, vehicleImage, workArea, vehicleType
    );
  }
} 