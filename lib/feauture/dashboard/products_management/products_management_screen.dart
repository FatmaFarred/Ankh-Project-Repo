import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/custom_text_field.dart';
import 'package:ankh_project/feauture/dashboard/products_management/product_details_screen/cubit/product_details_cubit.dart';
import 'package:ankh_project/feauture/dashboard/products_management/product_details_screen/product_details_screen.dart';
import 'package:ankh_project/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/assets_manager.dart';
import '../../../api_service/di/di.dart';
import '../../../domain/entities/product_management_entity.dart';
import '../../../domain/entities/product_post_entity.dart';
import '../../../domain/use_cases/edit_product_usecase.dart';
import '../custom_widgets/custom_bottom_sheet.dart';
import 'add_new_product/add_new_product_screen.dart';
import 'cubit/product_management_cubit.dart';
import 'cubit/product_management_state.dart';
import 'edit_product_screen/edit_product_cubit.dart';
import 'edit_product_screen/edit_product_screen.dart';

class ProductsManagementScreen extends StatelessWidget {
  const ProductsManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProductsManagementCubit>()..fetchAllProducts(),
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.productsManagement,
                  style: Theme.of(
                    context,
                  ).textTheme.headlineLarge!.copyWith(fontSize: 18.sp),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomTextField(
                hintText: AppLocalizations.of(context)!.search,
                prefixIcon: Icon(
                  Icons.search,
                  color: ColorManager.lightGreyShade2,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomizedElevatedButton(
                bottonWidget: Row(
                  children: [
                    Icon(Icons.add, color: ColorManager.white, size: 20.sp),
                    Text(
                      AppLocalizations.of(context)!.addNewProduct,
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
                      builder: (_) => const AddNewProductScreen(),
                    ),
                  );
                },
                color: ColorManager.lightprimary,
                borderColor: ColorManager.lightprimary,
              ),
            ),
            Expanded(
              child:
                  BlocBuilder<ProductsManagementCubit, ProductManagementState>(
                    builder: (context, state) {
                      if (state is ProductManagementLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is ProductManagementLoaded) {
                        final products = state.products;
                        return ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            return ProductCard(product: products[index]);
                          },
                        );
                      } else if (state is ProductManagementError) {
                        return Center(child: Text('Error: ${state.message}'));
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final ProductManagementEntity product;

  const ProductCard({super.key, required this.product,});

  @override
  Widget build(BuildContext context) {
    final isActive = product.status == 'Active';
    // final isNew = product.isUsedVehicle == 'New';

    return Card(
      elevation: 0,
      color: ColorManager.white,
      margin: EdgeInsets.symmetric(vertical: 8.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
        side: BorderSide(color: ColorManager.lightGrey),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Image.network(
                    product.imageUrls.isNotEmpty
                        ? "https://ankhapi.runasp.net/${product.imageUrls.first}"
                        : '',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.broken_image),
                  ),
                ),
                SizedBox(width: 12.w,),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            ImageAssets.userIcon,
                            height: 18.h,
                            width: 18.w,
                          ),
                          SizedBox(width: 4.w),
                          Expanded(
                            flex: 8,
                            child: Text(
                              product.title,
                              style: Theme.of(context).textTheme.bodyLarge!
                                  .copyWith(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          const Spacer(),
                          Column(
                            children: [
                              _buildStatusChip(product.status, isActive),
                              SizedBox(height: 8.h),
                              // _buildStatusChip(product.isUsedVehicle as String, isNew),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      _buildIconText(
                        context,
                        ImageAssets.callIcon,
                        product.description,
                      ),
                      SizedBox(height: 10.h),
                      _buildIconText(
                        context,
                        ImageAssets.mailIcon,
                        "${product.year}",
                      ),
                      SizedBox(height: 10.h),
                      // _buildIconText(context, ImageAssets.calenderIcon, product.createdAt as String),
                      SizedBox(height: 10.h),
                      _buildIconText(
                        context,
                        ImageAssets.calenderIcon,
                        product.code,
                      ),
                      SizedBox(height: 10.h),
                    ],
                  ),
                ),
              ],
            ),
            _buildActions(context, product),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String text, bool isPositive) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: isPositive ? const Color(0xFFDCFCE7) : const Color(0xFFFFEDD5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isPositive ? const Color(0xFF166534) : const Color(0xFF9A3412),
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildIconText(BuildContext context, String icon, String text) {
    return Row(
      children: [
        SvgPicture.asset(icon, height: 18.h, width: 18.w),
        SizedBox(width: 6.w),
        Text(
          text,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
        ),
      ],
    );
  }

  Widget _buildActions(BuildContext context, ProductManagementEntity product) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: _buildActionButton(
            context: context,
            icon: Icons.visibility,
            label: AppLocalizations.of(context)!.view,
            color: Color(0xffD4AF37),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider(
                    create: (context) =>
                        getIt<ProductDetailsCubit>()
                          ..fetchProductDetails(product.id),
                    child: ProductDetailsScreen(productId: product.id),
                  ),
                ),
              );
              if (result == true) {
                context
                    .read<ProductsManagementCubit>()
                    .fetchAllProducts(); // Refresh list
              }
            },
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: ColorManager.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: ColorManager.darkGrey),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => EditProductCubit(getIt<EditProductUseCase>()),
                    child: EditProductScreen(product: product,),
                  ),
                ),
              );
            },
            icon: Icon(
              Icons.edit_note_rounded,
              color: ColorManager.darkBlue,
              size: 20.sp,
            ),
            label: Text(
              AppLocalizations.of(context)!.edit,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 12.sp,
                color: ColorManager.lightprimary,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: ColorManager.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: ColorManager.darkGrey),
        ),
      ),
      onPressed: onPressed,
      icon: Icon(icon, color: color, size: 20.sp),
      label: Text(
        label,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontSize: 12.sp,
          color: ColorManager.lightprimary,
        ),
      ),
    );
  }


}
class CustomInputField extends StatelessWidget {
  final IconData? icon;
  final String hintText;
  final TextEditingController controller;

  const CustomInputField({
    super.key,
    this.icon,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: icon != null ? Icon(icon, size: 20) : null,
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
      ),
    );
  }
}

