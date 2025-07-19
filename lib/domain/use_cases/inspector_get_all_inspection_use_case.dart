import 'package:ankh_project/domain/entities/all_inpection_entity.dart';
import 'package:ankh_project/domain/entities/all_products_entity.dart';
import 'package:dartz/dartz.dart';

import '../../api_service/failure/error_handling.dart';
import '../entities/product_details_entity.dart';
import 'package:injectable/injectable.dart';

import '../repositries_and_data_sources/repositries/home_get_all_products_repositry.dart';
import '../repositries_and_data_sources/repositries/inspector _home_get_all_repositry.dart';
@injectable
class InspectorHomeGetAllInspectionUseCase {
  HomeGetAllInspectionRepositry repository;

  InspectorHomeGetAllInspectionUseCase(this.repository);

  Future<Either<Failure, List<AllInpectionEntity>>> execute() {
    return repository.getHomeAllInspection();
  }

}






