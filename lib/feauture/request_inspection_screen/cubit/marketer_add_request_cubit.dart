import 'package:ankh_project/domain/use_cases/marketer_requsts_for_inspection_usecase.dart';
import 'package:ankh_project/domain/use_cases/send_installment_request_usecase.dart';
import 'package:ankh_project/feauture/myrequest/controller/request_states.dart';
import 'package:ankh_project/feauture/request_inspection_screen/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../api_service/failure/error_handling.dart';
import '../../../data/models/add_inspection _request.dart';
import '../../../domain/use_cases/marketer_add_request_inspection_usecase.dart';
import '../../../domain/entities/price_offer_request_entity.dart';
import '../../../domain/use_cases/send_price_offer_usecase.dart';
import '../../../domain/entities/installment_request_entity.dart';

@injectable
class MarketerAddRequestCubit extends Cubit<MarketerAddRequestState> {
  final MarketerAddRequestInspectionUseCase addRequestUseCase;
  final SendPriceOfferUseCase sendPriceOfferUseCase;
  final SendInstallmentRequestUseCase sendInstallmentRequestUseCase;

  final TextEditingController dateController = TextEditingController();
  DateTime? selectedDate;
  final TextEditingController timeController = TextEditingController();
  TimeOfDay? selectedTime;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  MarketerAddRequestCubit(
      this.addRequestUseCase,
      this.sendPriceOfferUseCase,
      this.sendInstallmentRequestUseCase,
      ) : super(MarketerAddRequestInitial());

  Future<void> sendRequest(InspectionRequest request) async {
    emit(MarketerAddRequestLoading());
    final either = await addRequestUseCase.addRequest(request);
    either.fold(
          (error) => emit(MarketerAddRequestError(error: error)),
          (response) => emit(MarketerAddRequestSuccess(response: response)),
    );
  }

  Future<Either<Failure, Unit>> sendPriceOfferRequest(PriceOfferRequestEntity request) async {
    emit(PriceOfferRequestLoading());
    final result = await sendPriceOfferUseCase(request);
    result.fold(
          (failure) => emit(PriceOfferRequestError(error: failure.errorMessage.toString())),
          (_) => emit(PriceOfferRequestSuccess()),
    );
    return result;
  }

  Future<Either<Failure, Unit>> sendInstallmentRequest(InstallmentRequestEntity request) async {
    emit(InstallmentRequestLoading());

    final result = await sendInstallmentRequestUseCase(request);

    // Just execute fold — don't assign it
    result.fold(
          (failure) => print('Failed: ${failure.errorMessage}'),
          (_) => print('Installment request sent successfully'),
    );

    return result; // ✅ return the Either as-is
  }


}
