import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../api_service/di/di.dart';
import '../../../core/constants/color_manager.dart';
import '../../../core/customized_widgets/reusable_widgets/custom_text_field.dart';
import '../../../core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import '../../../l10n/app_localizations.dart';
import 'cubit/product_names_cubit.dart';
import 'cubit/product_names_state.dart';

class ProductNamesManagement extends StatefulWidget {
  const ProductNamesManagement({super.key});

  @override
  State<ProductNamesManagement> createState() => _ProductNamesManagementState();
}

class _ProductNamesManagementState extends State<ProductNamesManagement> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  late ProductNamesCubit _productNamesCubit;

  @override
  void initState() {
    super.initState();
    _productNamesCubit = getIt<ProductNamesCubit>();
    _productNamesCubit.getProductNames();
    // Add listener to update UI when search text changes
    _searchController.addListener(_updateSearchUI);
  }

  // Method to update UI based on search text changes
  void _updateSearchUI() {
    setState(() {
      // This will rebuild the widget to update the clear button visibility
    });
  }

  @override
  void dispose() {
    // Make sure to remove the listener before disposing the controller
    _searchController.removeListener(_updateSearchUI);
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  Widget _buildProductNamesList(BuildContext context, ProductNamesState state) {
    if (state is ProductNamesLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is ProductNamesLoaded) {
      return state.productNames.isEmpty
          ? Center(
              child: Text(
                AppLocalizations.of(context)!.noProductNamesFound,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            )
          : ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: state.productNames.length,
              itemBuilder: (context, index) {
                final productName = state.productNames[index];
                return ListTile(
                  title: Text(productName.name),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          _showDeleteConfirmationDialog(context, productName.id);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
    } else if (state is ProductNamesError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              state.message,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.red,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _productNamesCubit.getProductNames(),
              child: Text(AppLocalizations.of(context)!.retry),
            ),
          ],
        ),
      );
    }
    return const SizedBox();
  }

  void _showDeleteConfirmationDialog(BuildContext context, int productNameId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.deleteProductName),
        content: Text(AppLocalizations.of(context)!.confirmDeleteProductName),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _productNamesCubit.deleteProductName(productNameId);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(AppLocalizations.of(context)!.productNameDeletedSuccessfully),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            child: Text(AppLocalizations.of(context)!.delete),
          ),
        ],
      ),
    );
  }

  void _showAddProductNameDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.addNewProductName),
        content: Form(
          key: formKey,
          child: TextFormField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.enterProductName,
              border: const OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppLocalizations.of(context)!.productNameCannotBeEmpty;
              }
              return null;
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                final productName = nameController.text.trim();
                Navigator.pop(context);
                _productNamesCubit.addProductName(productName);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(AppLocalizations.of(context)!.productNameAddedSuccessfully),
                    backgroundColor: Colors.green,
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
            },
            child: Text(AppLocalizations.of(context)!.add),
          ),
        ],
      ),
    );
    // Don't dispose the controller here as it might still be in use
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _productNamesCubit,
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.productNamesManagement,
                  style: Theme.of(
                    context,
                  ).textTheme.headlineLarge!.copyWith(fontSize: 18.sp),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(_searchFocusNode);
                },
                child: CustomTextField(
                  controller: _searchController,
                  hintText: AppLocalizations.of(context)!.search,
                  prefixIcon: Icon(
                    Icons.search,
                    color: ColorManager.lightGreyShade2,
                  ),
                  keyboardType: TextInputType.text,
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(
                            Icons.clear,
                            color: ColorManager.lightGreyShade2,
                          ),
                          onPressed: () {
                            _searchController.clear();
                            // When clearing the search field, show all product names
                            _productNamesCubit.searchProductNames('');
                            setState(() {});
                          },
                        )
                      : null,
                  onChanged: (value) {
                    // Search with the current value, empty string will show all product names
                    _productNamesCubit.searchProductNames(value);
                    setState(() {}); // Rebuild to update the clear button visibility
                  },
                  textInputAction: TextInputAction.search,
                  onFieldSubmitted: (value) {
                    if (value != null) {
                      // When submitting the search field, search with the current value
                      // If value is empty, it will show all product names
                      _productNamesCubit.searchProductNames(value);
                    }
                  },
                  onTap: () {
                    // This ensures the keyboard appears when the field is tapped
                  },
                ),
              ),
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
                      AppLocalizations.of(context)!.addNewProductName,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 16.sp,
                        color: ColorManager.white,
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  _showAddProductNameDialog(context);
                },
                color: ColorManager.lightprimary,
                borderColor: ColorManager.lightprimary,
              ),
            ),
            Expanded(
              child: BlocConsumer<ProductNamesCubit, ProductNamesState>(
                listener: (context, state) {
                  if (state is ProductNamesError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.red,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return RefreshIndicator(
                    onRefresh: () => _productNamesCubit.getProductNames(),
                    child: _buildProductNamesList(context, state),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
