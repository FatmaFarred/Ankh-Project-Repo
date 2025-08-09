import 'package:ankh_project/domain/entities/all_inpection_entity.dart';
import 'package:ankh_project/domain/entities/all_inspectors_entity.dart';
import 'package:ankh_project/domain/entities/all_products_entity.dart';
import 'package:ankh_project/domain/entities/product_details_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../api_service/failure/error_handling.dart';
import '../../domain/repositries_and_data_sources/data_sources/remote_data_source/inspector _home_get_all_remote_data_source.dart';
import '../../domain/repositries_and_data_sources/repositries/inspector _home_get_all_repositry.dart';

@Injectable(as: HomeGetAllInspectionRepositry)
 class HomeGetAllInspectionRepositryImpl implements HomeGetAllInspectionRepositry {

  HomeGetAllInspectionRemoteDataSource homeGetAllInspectionRemoteDataSource;

  HomeGetAllInspectionRepositryImpl(this.homeGetAllInspectionRemoteDataSource);

  Future <
      Either<Failure, List<AllInpectionEntity>>> getHomeAllInspection() async {
    var either = await homeGetAllInspectionRemoteDataSource
        .getHomeAllInspection();
    return either.fold((error) => left(error), (response) => right(response));
  }

  @override
  Future<Either<Failure, List<AllInpectionEntity>>> searchAllInspection(
      String keyWord,String token) async {
    var either = await homeGetAllInspectionRemoteDataSource.searchAllInspection(
        keyWord, token);
    return either.fold((error) => left(error), (response) => right(response));
  }

  @override
  Future<Either<Failure, String?>> assignProdcutToInspector(num productId,
      String inspectorId) async {
    var either = await homeGetAllInspectionRemoteDataSource
        .assignProdcutToInspector(productId, inspectorId);
    return either.fold((error) => left(error), (response) => right(response));
  }

  @override
  Future<Either<Failure, List<AllInspectorsEntity>>> getAllInspectors()async {
    var either = await homeGetAllInspectionRemoteDataSource.getAllInspectors();
    return either.fold((error) => left(error), (response) => right(response));

  }

  @override
  Future<Either<Failure, List<AllInspectorsEntity>>> searchInspectors(String keyWord)async {
    var either = await homeGetAllInspectionRemoteDataSource.searchInspectors(keyWord);
    return either.fold((error) => left(error), (response) => right(response));

  }

  @override
  Future<Either<Failure, List<AllInpectionEntity>>> getInspectionsByInspectorId(String inspectorId) async {
    var either = await homeGetAllInspectionRemoteDataSource.getInspectionsByInspectorId(inspectorId);
    return either.fold((error) => left(error), (response) => right(response));
  }

  @override
  Future<Either<Failure, List<AllInpectionEntity>>> getAllInspection() async {
    var either = await homeGetAllInspectionRemoteDataSource.getAllInspection();
    return either.fold((error) => left(error), (response) => right(response));
  }

  @override
  Future<Either<Failure, String?>> rescheduleInspection(String date, String time, String adminNote,num inspectionId)async {
    var either = await homeGetAllInspectionRemoteDataSource.rescheduleInspection(date, time, adminNote,inspectionId);
    return either.fold((error) => left(error), (response) => right(response));
  }

  @override
  Future<Either<Failure, List<AllInpectionEntity>>> searchAllInspectionAdmin(String keyWord)async {
    var either = await homeGetAllInspectionRemoteDataSource.searchAllInspectionAdmin(keyWord);
    return either.fold((error) => left(error), (response) => right(response));
  }
}