import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../api_service/di/di.dart';
import '../../core/constants/color_manager.dart';
import '../../core/constants/font_manager/font_manager.dart';
import '../../core/customized_widgets/reusable_widgets/custom_text_field.dart';
import '../../core/customized_widgets/reusable_widgets/custom_dialog.dart';
import '../../core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import '../../core/customized_widgets/shared_preferences .dart';
import '../../core/local_storage/my_shared_prefrence.dart';
import '../../l10n/app_localizations.dart';
import 'cubit/edit_profile_cubit.dart';
import 'cubit/edit_profile_states.dart';
import 'cubit/profile_cubit.dart';
import 'cubit/states.dart';

class EditProfileScreen extends StatefulWidget {
  static const String routeName = '/edit-profile';

  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  EditProfileCubit  editProfileCubit = getIt<EditProfileCubit>();
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // Delay loading profile data until after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadCurrentProfileData();
    });
  }

  void _loadCurrentProfileData() async {
    // First, try to get data from ProfileCubit state
    final profileCubit = context.read<ProfileCubit>();
    final profileState = profileCubit.state;
    
    if (profileState is ProfileLoaded) {
      final profile = profileState.profile;
      setState(() {
        _fullNameController.text = profile.fullName ?? '';
        _emailController.text = profile.email ?? '';
        _phoneController.text = profile.phone ?? '';
        _addressController.text = profile.address ?? '';
      });
    } else {
      // If profile is not loaded, fetch it first
      final token = await SharedPrefsManager.getData(key: 'user_token');
      final userId = await SharedPrefsManager.getData(key: 'user_id');
      
      if (token != null && userId != null) {
        profileCubit.fetchProfile(token, userId);
      }
    }
  }

  Future<void> _refreshProfileData() async {
    // Force refresh profile data from API
    final token = await SharedPrefsManager.getData(key: 'user_token');
    final userId = await SharedPrefsManager.getData(key: 'user_id');
    
    if (token != null && userId != null) {
      context.read<ProfileCubit>().fetchProfile(token, userId);
    }
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  void _updateProfile() {
    if (_formKey.currentState!.validate()) {
      if (_selectedImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select an image')),
        );
        return;
      }

      // Get token and userId from SharedPreferences
      SharedPrefsManager.getData(key: 'user_token').then((token) {
        SharedPrefsManager.getData(key: 'user_id').then((userId) {
          if (token != null && userId != null) {
            editProfileCubit.editProfile(
              token: token,
              userId: userId,
              fullName: _fullNameController.text,
              email: _emailController.text,
              phone: _phoneController.text,
              image: _selectedImage!,
            );
          }
        });
      });
    }
  }

  void _showSuccessDialog(String message) async {
    // Get token and id from SharedPreferences
    final token = await SharedPrefsManager.getData(key: 'user_token');
    final id = await SharedPrefsManager.getData(key: 'user_id');
    
    CustomDialog.positiveButton(
      context: context,
      title: AppLocalizations.of(context)!.success,
      message: message,
      positiveOnClick: () async {
        // Refresh profile data immediately after successful update
        if (token != null && id != null) {
          await context.read<ProfileCubit>().fetchProfile(token, id);
        }
        Navigator.of(context).pop(); // Close dialog
        // Return to profile screen with result to trigger refresh
        Navigator.of(context).pop(true);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop(); // Go back to previous screen
          },
        ),
        title:  Text(AppLocalizations.of(context)!.editProfile),
        backgroundColor: ColorManager.lightprimary,
        foregroundColor: Colors.white,
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<EditProfileCubit, EditProfileState>(
            bloc: editProfileCubit,
            listener: (context, state) async {
              if (state is EditProfileLoading) {
                CustomDialog.loading(
                  context: context,
                  message: AppLocalizations.of(context)!.loading,
                  cancelable: false,
                );
              } else if (state is EditProfileSuccess) {
                Navigator.of(context).pop(); // Close loading dialog
                // Immediately refresh profile data after successful update
                await _refreshProfileData();
                // Show success dialog after data is refreshed
                _showSuccessDialog(state.message);
              } else if (state is EditProfileError) {
                Navigator.of(context).pop(); // Close loading dialog
                CustomDialog.positiveButton(
                  context: context,
                  title: AppLocalizations.of(context)!.error,
                  message: state.error.errorMessage,
                );
              }
            },
          ),
          BlocListener<ProfileCubit, ProfileState>(
            listener: (context, state) {
              if (state is ProfileLoaded) {
                final profile = state.profile;
                setState(() {
                  _fullNameController.text = profile.fullName ?? '';
                  _emailController.text = profile.email ?? '';
                  _phoneController.text = profile.phone ?? '';
                  _addressController.text = profile.address ?? '';
                });
              } else if (state is ProfileError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Failed to refresh profile data'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),
        ],
        child: RefreshIndicator(
          onRefresh: _refreshProfileData,
          color: ColorManager.lightprimary,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            physics: const AlwaysScrollableScrollPhysics(), // Ensures pull-to-refresh works
            child: Form(
              key: _formKey,
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Profile Image Section
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        backgroundColor: ColorManager.lightGrey,
                        radius: 60,
                        backgroundImage: _selectedImage != null
                            ? FileImage(_selectedImage!)
                            : null,
                        child: _selectedImage == null
                            ?  Icon(Icons.person, size: 60,color: ColorManager.lightprimary,)
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          backgroundColor: ColorManager.lightprimary,
                          child: IconButton(
                            icon: const Icon(Icons.camera_alt, color: Colors.white),
                            onPressed: _pickImage,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                 SizedBox(height: 24.h),

                // Full Name Field
                Text(
                  AppLocalizations.of(context)!.fullName,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontSize: 16.sp),
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  controller: _fullNameController,


                  hintText: AppLocalizations.of(context)!.enterYourName,
                  prefixIcon: Icon(Icons.person,color: ColorManager.lightprimary,),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.fieldRequired;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),


                Text(
                  AppLocalizations.of(context)!.email,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontSize: 16.sp),
                ),
                SizedBox(height: 8.h),
                CustomTextField(
                  controller: _emailController,
                  hintText: AppLocalizations.of(context)!.email,
                  prefixIcon: Icon(Icons.email,color: ColorManager.lightprimary,),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.fieldRequired;
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return AppLocalizations.of(context)!.fieldRequired;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  AppLocalizations.of(context)!.phoneNumber,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontSize: 16.sp),
                ),
                SizedBox(height: 8.h),
                // Phone Field
                CustomTextField(
                  controller: _phoneController,
                  hintText: AppLocalizations.of(context)!.phoneNumber,
                  prefixIcon: Icon(Icons.phone,color: ColorManager.lightprimary,),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.fieldRequired;
                    }
                    return null;
                  },
                ),
                 SizedBox(height: 16.h),

                // Address Field
                 SizedBox(height: 64.h),


                // Update Button
                CustomizedElevatedButton(
                  color: ColorManager.lightprimary,
                  bottonWidget: Text(
                    AppLocalizations.of(context)!.update,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: _updateProfile,
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
} 