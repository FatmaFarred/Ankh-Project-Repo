import 'package:ankh_project/domain/entities/top_brand_entity.dart';
import 'package:ankh_project/feauture/dashboard/top_brands/add_new_top_brand.dart';
import 'package:ankh_project/feauture/dashboard/top_brands/edit_top_brand.dart';
import 'package:ankh_project/feauture/dashboard/top_brands/cubit/top_brands_management_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../api_service/api_constants.dart';
import '../../../api_service/di/di.dart';
import '../../../core/constants/color_manager.dart';
import '../../../core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import '../../../l10n/app_localizations.dart';

class TopBrandsManagementScreen extends StatefulWidget {
  const TopBrandsManagementScreen({super.key});

  @override
  State<TopBrandsManagementScreen> createState() => _TopBrandsManagementScreenState();
}

class _TopBrandsManagementScreenState extends State<TopBrandsManagementScreen> {
  late TopBrandsManagementCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<TopBrandsManagementCubit>();
    _cubit.getTopBrands();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocBuilder<TopBrandsManagementCubit, TopBrandsManagementState>(
        builder: (context, state) {
          return Column(
            children: [
              SizedBox(height: 20.h),
              Text(
                AppLocalizations.of(context)!.topBrands,
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: 18.sp),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomizedElevatedButton(
                  bottonWidget: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, color: ColorManager.white, size: 20.sp),
                      SizedBox(width: 8.w),
                      Text(
                        AppLocalizations.of(context)!.addBrand,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 16.sp,
                          color: ColorManager.white,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AddNewTopBrand(),
                      ),
                    ).then((result) {
                      // Refresh the list when returning from add screen with success result
                      if (result == true) {
                        _cubit.getTopBrands();
                      }
                    });
                  },
                  color: ColorManager.lightprimary,
                  borderColor: ColorManager.lightprimary,
                ),
              ),
              Expanded(
                child: _buildContent(state),
              ),
            ],
          );
        },
      ),
    );
  }
  

  
  // Navigate to edit brand screen
  void _navigateToEditBrandScreen(BuildContext context, TopBrandEntity brand) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditTopBrand(brand: brand),
      ),
    ).then((result) {
      // Refresh the list when returning from edit screen with success result
      if (result == true) {
        _cubit.getTopBrands();
      }
    });
  }
  
  // Show delete confirmation dialog
  void _showDeleteConfirmationDialog(BuildContext context, TopBrandEntity brand) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (dialogContext) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.delete),
        content: Text('${AppLocalizations.of(context)!.delete} ${brand.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          BlocProvider.value(
            value: _cubit,
            child: BlocConsumer<TopBrandsManagementCubit, TopBrandsManagementState>(
              listener: (context, state) {
                if (state is TopBrandDeleteSuccess) {
                  Navigator.pop(dialogContext);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${brand.name} deleted successfully')),
                  );
                  // Refresh the list after deletion
                  _cubit.getTopBrands();
                } else if (state is TopBrandsManagementError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                final isLoading = state is TopBrandsManagementLoading;
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: isLoading
                      ? null
                      : () {
                          // Call delete method directly
                          _cubit.deleteTopBrand(id: brand.id);
                        },
                  child: isLoading
                      ? SizedBox(
                          height: 20.h,
                          width: 20.w,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : Text(AppLocalizations.of(context)!.delete),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildContent(TopBrandsManagementState state) {
    if (state is TopBrandsManagementLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is TopBrandsManagementError) {
      return Center(child: Text(state.message));
    } else if (state is TopBrandsManagementLoaded) {
      final brands = state.brands;
      if (brands.isEmpty) {
        return Center(child: Text(AppLocalizations.of(context)!.noTopBrandsFound));
      }
      return RefreshIndicator(
        onRefresh: () async {
          await _cubit.getTopBrands();
        },
        child: GridView.builder(
          padding: EdgeInsets.all(16.w),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.w,
            mainAxisSpacing: 16.h,
            childAspectRatio: 1.0,
          ),
          itemCount: brands.length,
          itemBuilder: (context, index) {
            final brand = brands[index];
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.network(
                      '${ApiConstant.imageBaseUrl}${brand.imageUrl}',
                      height: 80.h,
                      width: 80.w,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.error, size: 80.sp, color: Colors.red);
                      },
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    brand.name,
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Edit Button
                      IconButton(
                        icon: Icon(Icons.edit, color: Theme.of(context).primaryColor),
                        onPressed: () => _navigateToEditBrandScreen(context, brand),
                        tooltip: AppLocalizations.of(context)!.edit,
                      ),
                      // Delete Button
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _showDeleteConfirmationDialog(context, brand),
                        tooltip: AppLocalizations.of(context)!.delete,
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
