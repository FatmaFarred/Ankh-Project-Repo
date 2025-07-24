import 'dart:io';
import 'package:ankh_project/feauture/inspector_screen/authentication/inspector_register_controller/inspector_register_states.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import '../../../../api_service/failure/error_handling.dart';

import '../../../../domain/use_cases/authentication/inspector_register_usecase.dart';

@injectable
class InspectorRegisterCubit extends Cubit<InspectorRegisterState> {
  final InspectorRegisterUseCase inspectorRegisterUseCase;

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController licenseNumberController = TextEditingController();
  final TextEditingController vehicleLicenseNumberController = TextEditingController();
  final TextEditingController workAreaController = TextEditingController();
  final TextEditingController vehicleTypeController = TextEditingController();

  File? licenseImage;
  File? vehicleImage;

  bool isPasswordVisible = false;
  bool showLicenseImageError = false;
  bool showVehicleImageError = false;

  InspectorRegisterCubit(this.inspectorRegisterUseCase) : super(InspectorRegisterInitial());

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(InspectorRegisterInitial());
  }

  void setLicenseImage(File image) {
    licenseImage = image;
    showLicenseImageError = false; // Clear error when image is selected
    emit(InspectorRegisterInitial());
  }

  void setVehicleImage(File image) {
    vehicleImage = image;
    showVehicleImageError = false; // Clear error when image is selected
    emit(InspectorRegisterInitial());
  }

  void validateImages() {
    showLicenseImageError = licenseImage == null;
    showVehicleImageError = vehicleImage == null;
    emit(InspectorRegisterInitial());
  }

  Future<void> registerInspector() async {
    // Reset error flags
    showLicenseImageError = false;
    showVehicleImageError = false;
    
    // Validate images
    if (licenseImage == null) {
      showLicenseImageError = true;
    }
    if (vehicleImage == null) {
      showVehicleImageError = true;
    }
    
    // If any image is missing, show validation and return
    if (licenseImage == null || vehicleImage == null) {
      emit(InspectorRegisterInitial());
      return;
    }

    // Validate other required fields
    if (licenseNumberController.text.isEmpty || 
        vehicleLicenseNumberController.text.isEmpty ||
        workAreaController.text.isEmpty ||
        vehicleTypeController.text.isEmpty) {
      emit(InspectorRegisterFailure(error: ServerError(errorMessage: "Please fill all required fields")));
      return;
    }

    emit(InspectorRegisterLoading());

    var either = await inspectorRegisterUseCase.execute(
      fullNameController.text,
      emailController.text,
      passwordController.text,
      phoneController.text,
      licenseNumberController.text,
      vehicleLicenseNumberController.text,
      licenseImage!,
      vehicleImage!,
      workAreaController.text,
      vehicleTypeController.text
    );
    
    either.fold((error) {
      emit(InspectorRegisterFailure(error: error));
    }, (response) {
      emit(InspectorRegisterSuccess(response: response));
    });
  }
} 