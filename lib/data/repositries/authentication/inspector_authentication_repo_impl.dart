import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../api_service/failure/error_handling.dart';
import '../../../domain/entities/authentication_response_entity.dart';
import '../../../domain/repositries_and_data_sources/data_sources/remote_data_source/inspector_authentication_remote_data_course.dart';
import '../../../domain/repositries_and_data_sources/repositries/inspector_authentication_repositry.dart';

@Injectable(as: InspectorAuthenticationRepositry)
class InspectorAuthenticationRepositryImpl implements InspectorAuthenticationRepositry {
  InspectorAuthenticationRemoteDataSource inspectorAuthRemoteDataSource;
  
  InspectorAuthenticationRepositryImpl(this.inspectorAuthRemoteDataSource);

  @override
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
  ) async {
    var either = await inspectorAuthRemoteDataSource.registerInspector(
      name, email, password, phone, licenseNumber, vehicleLicenseNumber, licenseImage, vehicleImage, workArea, vehicleType
    );
    return either.fold((error) => left(error), (response) => right(response));
  }
} 