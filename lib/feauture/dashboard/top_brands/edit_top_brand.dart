import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../api_service/api_constants.dart';
import '../../../api_service/di/di.dart';
import '../../../core/constants/color_manager.dart';
import '../../../core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import '../../../l10n/app_localizations.dart';
import '../../../domain/entities/top_brand_entity.dart';
import '../../inspector_screen/widgets/custom_text_form_field.dart';
import 'cubit/top_brands_management_cubit.dart';

class EditTopBrand extends StatefulWidget {
  final TopBrandEntity brand;
  
  const EditTopBrand({super.key, required this.brand});

  @override
  State<EditTopBrand> createState() => _EditTopBrandState();
}

class _EditTopBrandState extends State<EditTopBrand> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  File? _selectedImage;
  final _picker = ImagePicker();
  late final TopBrandsManagementCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<TopBrandsManagementCubit>();
    _nameController = TextEditingController(text: widget.brand.name);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _cubit.editTopBrand(
        id: widget.brand.id,
        name: _nameController.text.trim(),
        imageFile: _selectedImage,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocConsumer<TopBrandsManagementCubit, TopBrandsManagementState>(
        listener: (context, state) {
          if (state is TopBrandEditSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(AppLocalizations.of(context)!.edited)),
            );
            Navigator.pop(context, true); // Return true to indicate success
          } else if (state is TopBrandsManagementError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(CupertinoIcons.back),
                color: Colors.white,
                onPressed: () => Navigator.pop(context),
              ),
              title: Text(AppLocalizations.of(context)!.edit),
              backgroundColor: ColorManager.lightprimary,
            ),
            body: Padding(
              padding: EdgeInsets.all(16.w),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Brand Name Field
                      Text(
                        AppLocalizations.of(context)!.brandName,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(height: 8.h),
                      CustomTextFormField(
                        controller: _nameController,
                        hintText: AppLocalizations.of(context)!.brandName,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return AppLocalizations.of(context)!.brandNameRequired;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 24.h),
                      
                      // Brand Image Field
                      Text(
                        AppLocalizations.of(context)!.brandImage,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      SizedBox(height: 8.h),
                      GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          height: 200.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: ColorManager.lightGrey.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(color: ColorManager.lightGrey),
                          ),
                          child: _selectedImage != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8.r),
                                  child: Image.file(
                                    _selectedImage!,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Show current image if available
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.r),
                                      child: Image.network(
                                        '${ApiConstant.imageBaseUrl}${widget.brand.imageUrl}',
                                        height: 120.h,
                                        width: 120.w,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Icon(
                                            Icons.add_photo_alternate_outlined,
                                            size: 48.sp,
                                            color: ColorManager.lightprimary,
                                          );
                                        },
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    Text(
                                      AppLocalizations.of(context)!.tapToSelectImage,
                                      style: Theme.of(context).textTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                        ),
                      ),
                      SizedBox(height: 32.h),
                      
                      // Submit Button
                      CustomizedElevatedButton(
                        bottonWidget: state is TopBrandsManagementLoading
                            ? CircularProgressIndicator(color: ColorManager.white)
                            : Text(
                                AppLocalizations.of(context)!.saveEdits,
                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontSize: 16.sp,
                                      color: ColorManager.white,
                                    ),
                              ),
                        onPressed: state is TopBrandsManagementLoading ? null : _submitForm,
                        color: ColorManager.lightprimary,
                        borderColor: ColorManager.lightprimary,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}