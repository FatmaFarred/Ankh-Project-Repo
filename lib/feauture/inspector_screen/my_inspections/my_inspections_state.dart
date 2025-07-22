import '../../../domain/entities/all_inpection_entity.dart';
import '../../../api_service/failure/error_handling.dart';

abstract class MyInspectionsState {}

class MyInspectionsInitial extends MyInspectionsState {}
class MyInspectionsLoading extends MyInspectionsState {}
class MyInspectionsLoaded extends MyInspectionsState {
  final List<AllInpectionEntity> inspections;
  MyInspectionsLoaded({ required this.inspections});
}
class MyInspectionsEmpty extends MyInspectionsState {}
class MyInspectionsError extends MyInspectionsState {
  final Failure error;
  MyInspectionsError({ required this.error});
} 