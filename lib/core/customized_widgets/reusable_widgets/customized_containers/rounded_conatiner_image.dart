import 'package:ankh_project/core/constants/assets_manager.dart';
import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RoundedContainerWidget extends StatelessWidget {
  final double width;
  final double height;
  final String imagePath;
  final Color? backgroundColor;
  final double? imageheight;
  final double? imagewidth;

  const RoundedContainerWidget({
    super.key,
    required this.width,
    required this.height,
    required this.imagePath,
    this.backgroundColor,
    this.imageheight,
    this.imagewidth,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: width,
        height: height,
        color: backgroundColor ?? ColorManager.productContainerGrey,
        child: Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: imagewidth ?? width,
            height: imageheight ?? height,
            child: CachedNetworkImage(
              fit: BoxFit.contain,
              imageUrl: imagePath,
              placeholder: (context, url) => Container(
                color: ColorManager.productContainerGrey,
                child: Center(
                  child: CircularProgressIndicator(
                    color: ColorManager.lightprimary,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                color: ColorManager.productContainerGrey,
                child: Image.asset(
                  ImageAssets.brokenImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
