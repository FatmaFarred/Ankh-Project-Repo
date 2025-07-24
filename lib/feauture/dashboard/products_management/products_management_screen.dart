import 'package:ankh_project/feauture/dashboard/products_management/add_new_product_screen.dart';
import 'package:ankh_project/feauture/dashboard/products_management/edit_product_screen.dart';
import 'package:ankh_project/feauture/dashboard/products_management/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/assets_manager.dart';
import '../../../core/constants/color_manager.dart';
import '../../../core/customized_widgets/reusable_widgets/custom_text_field.dart';
import '../../../core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import '../../../l10n/app_localizations.dart';
import '../custom_widgets/custom_bottom_sheet.dart';

class ProductsManagementScreen extends StatelessWidget {
  ProductsManagementScreen({super.key});

  final List<Map<String, dynamic>> products = [
    {
      'productName': 'Toyota EX30',
      'name': 'Ali Ahmed',
      'address': '15 El-Tahrir St., Cairo',
      'date': 'Dec 21, 2023',
      'orderStatus': 'Active',
      'ProductStatus': 'New',
      'price': 'EGP 1.9M – 2.3M',
    },
    {
      'productName': 'Toyota EX30',
      'name': 'Mohamed Ahmed',
      'address': 'Cairo',
      'date': 'Dec 21, 2023',
      'orderStatus': 'Active',
      'ProductStatus': 'Used',
      'price': 'EGP 1.9M – 2.3M',
    },
    {
      'productName': 'Toyota EX30',
      'name': 'Ali shawki',
      'address': 'Alexandria',
      'date': 'Dec 21, 2023',
      'orderStatus': 'Sold',
      'ProductStatus': 'New',
      'price': 'EGP 1.9M – 2.3M',
    },
    {
      'productName': 'Toyota EX30',
      'name': 'Ali Ahmed',
      'address': 'Monofiya',
      'date': 'Dec 21, 2023',
      'orderStatus': 'Active',
      'ProductStatus': 'Used',
      'price': 'EGP 1.9M – 2.3M',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              // Profile image or icon can go here
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
                Navigator.push(context, MaterialPageRoute(builder: (context){return AddNewProductScreen();}));
              },
              color: ColorManager.lightprimary,
              borderColor: ColorManager.lightprimary,
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final user = products[index];
                return ProductCard(product: user);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isActive = product['orderStatus'] == 'Active';
    final isNew = product['ProductStatus'] == 'New';
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
                Expanded(child: Image.asset(ImageAssets.carPic1)),
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
                          SizedBox(width: 6.w),
                          Text(
                            product['productName'],
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          const Spacer(),
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 4.h,
                                ),
                                decoration: BoxDecoration(
                                  color: isActive
                                      ? const Color(0xFFDCFCE7)
                                      : const Color(0xFFFFEDD5),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  product['orderStatus'],
                                  style: TextStyle(
                                    color: isActive
                                        ? const Color(0xFF166534)
                                        : const Color(0xFF9A3412),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 4.h,
                                ),
                                decoration: BoxDecoration(
                                  color: isNew
                                      ? const Color(0xFFDCFCE7)
                                      : const Color(0xFFFFEDD5),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  product['ProductStatus'],
                                  style: TextStyle(
                                    color: isNew
                                        ? const Color(0xFF166534)
                                        : const Color(0xFF9A3412),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          SvgPicture.asset(
                            ImageAssets.callIcon,
                            height: 18.h,
                            width: 18.w,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            product['name'],
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          SvgPicture.asset(
                            ImageAssets.mailIcon,
                            height: 18.h,
                            width: 18.w,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            product['address'],
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          SvgPicture.asset(
                            ImageAssets.calenderIcon,
                            height: 18.h,
                            width: 18.w,
                          ),

                          SizedBox(width: 6.w),
                          Text(
                            product['date'],
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          SvgPicture.asset(
                            ImageAssets.calenderIcon,
                            height: 18.h,
                            width: 18.w,
                          ),

                          SizedBox(width: 6.w),
                          Text(
                            product['price'],
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),


                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: ColorManager.white,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: ColorManager.darkGrey),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context){return ProductDetailsScreen();}));
                  },
                  icon: Icon(
                    Icons.visibility,
                    color: Color(0xffD4AF37),
                    size: 20.sp,
                  ),

                  label: Text(
                    AppLocalizations.of(context)!.view,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 12.sp,
                      color: ColorManager.lightprimary,
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.white,

                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: ColorManager.darkGrey),
                    ),
                  ),
                  onPressed: () {
                    _showBottomSheet(
                      context: context,
                      title: AppLocalizations.of(context)!.unassign,
                      description: AppLocalizations.of(context)!
                          .unassignConfirmation(
                        product["productName"],
                        product["name"],
                      ),
                      cancelText: AppLocalizations.of(context)!.cancel,
                      confirmText: AppLocalizations.of(context)!.unassign,
                      onCancel: () => Navigator.pop(context),
                      onConfirm: () {},
                      icon: Icon(
                        Icons.person_remove_rounded,
                        color: ColorManager.error,
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.person_remove_rounded,
                    color: ColorManager.error,
                    size: 20.sp,
                  ),

                  label: Text(
                    AppLocalizations.of(context)!.unassign,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 12.sp,
                      color: ColorManager.lightprimary,
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: ColorManager.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: ColorManager.darkGrey),
                    ),
                  ),
                  onPressed: () {
                    // _showBottomSheet(
                    //   context: context,
                    //   title: AppLocalizations.of(context)!.edit,
                    //   description: AppLocalizations.of(
                    //     context,
                    //   )!.suspendUserAccountSubtitle,
                    //   cancelText: AppLocalizations.of(context)!.cancel,
                    //   confirmText: AppLocalizations.of(context)!.confirm,
                    //   onCancel: () => Navigator.pop(context),
                    //   onConfirm: () {},
                    //   icon: Icon(
                    //     Icons.edit_note_rounded,
                    //     color: ColorManager.darkBlue,
                    //   ),
                    // );
                    Navigator.push(context, MaterialPageRoute(builder: (context){return EditProductScreen();}));

                  },
                  icon: Icon(
                    Icons.edit_note_rounded,
                    color: ColorManager.darkBlue,
                    size: 20.sp,
                  ),

                  label: Text(
                    isActive
                        ? AppLocalizations.of(context)!.edit
                        : AppLocalizations.of(context)!.edit,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 12.sp,
                      color: ColorManager.lightprimary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ... inside your widget class

  void _showBottomSheet({
    required BuildContext context,
    required String title,
    required String description,
    required String cancelText,
    required String confirmText,
    required VoidCallback onCancel,
    required VoidCallback onConfirm,
    Color? cancelColor,
    Color? confirmColor,
    Widget? icon,
  }) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => CustomBottomSheet(
        title: title,
        description: description,
        cancelText: cancelText,
        confirmText: confirmText,
        onCancel: () => onCancel,
        onConfirm: () => onConfirm,
        confirmColor: Colors.red,
        icon: icon,
      ),
    );
  }
}
