import 'package:ankh_project/domain/use_cases/marketer_requsts_for_inspection_usecase.dart';
import 'package:ankh_project/feauture/myrequest/controller/request_states.dart';
import 'package:ankh_project/feauture/request_inspection_screen/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/add_inspection _request.dart';
import '../../../domain/use_cases/marketer_add_request_inspection_usecase.dart';
@injectable

class MarketerAddRequestCubit extends Cubit<MarketerAddRequestState> {
  MarketerAddRequestInspectionUseCase  addRequestUseCase;
  final TextEditingController dateController = TextEditingController();
  DateTime? selectedDate;
  final TextEditingController timeController = TextEditingController();
  TimeOfDay? selectedTime;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();





  MarketerAddRequestCubit(this.addRequestUseCase) : super(MarketerAddRequestInitial());

  Future<void> sendRequest(InspectionRequest request) async {
    emit(MarketerAddRequestLoading());
    var either = await addRequestUseCase.addRequest(request);
    either.fold((error) {
      emit(MarketerAddRequestError(error: error));
    }, (response) {

          emit(MarketerAddRequestSuccess(response: response));

    });
  }
}
