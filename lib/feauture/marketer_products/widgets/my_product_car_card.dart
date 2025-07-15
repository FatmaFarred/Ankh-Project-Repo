import 'package:ankh_project/core/customized_widgets/reusable_widgets/customized_containers/rounded_conatiner_image.dart';
import 'package:ankh_project/domain/entities/all_products_entity.dart';
import 'package:ankh_project/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/feauture/details_screen/details_screen.dart';

import '../../../l10n/app_localizations.dart';

class MyProductCarCard extends StatelessWidget {
  final AllProductsEntity product;

  const MyProductCarCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorManager.white,
      margin:EdgeInsets.zero ,
      elevation: 2,
    child: Container(

      width: 198.w,
      height: 248.h,
      padding: EdgeInsets.symmetric(horizontal: 17.5.w, vertical: 13.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.5.r),
        border: Border.all(
          color: ColorManager.productContainerGrey,
          width: 0.9.w,
        ),
      ),
      child: ListView(
       // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              RoundedContainerWidget(width: 165.w, height: 114.h, imagePath:  "https://ankhapi.runasp.net/${product.images?[0]}",
              imageheight: 68.h,
                imagewidth: 152.w,
              ),
              Positioned(
                top: 4.h,
                right: 8.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(9.r),
                      color: ColorManager.rateContainer
                  ),
                  child: Row(
                    children: [
                      RatingBarIndicator(

                        rating: (product?.rating ?? 0).toDouble(),
                        itemBuilder: (context, _) =>  Icon(
                          Icons.star,
                          color: ColorManager.rateColor,

                        ),
                        itemCount: 1,
                        itemSize: 16.sp,
                        direction: Axis.horizontal,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        product?.rating?.toStringAsFixed(1) ?? "0.0",
                        style: Theme.of(context).textTheme.labelSmall
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
          SizedBox(height: 8.h),

              Text(
                product?.title??"",
                style:  Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 14.sp),
                overflow: TextOverflow.ellipsis,
              ),
          SizedBox(height: 5.h),



          Text(
            "${product.transmission} - ${product.status}",
            style:  Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12.sp,color: ColorManager.darkGrey),


          ),
          SizedBox(height: 5.h),

          Text(
            AppLocalizations.of(context)!.price,
            style:  Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12.sp,color: Colors.grey.shade400),


          ),
          SizedBox(height: 8.h),


          Text(
            "EGP ${product.price}",
            style:Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 11.sp,color: ColorManager.lightprimary),
          ),
        ],
      ),
    ),
          );
  }
}
