import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RoundedContainerWidget extends StatelessWidget {
  final double width,height;
  final String imagePath;

  const RoundedContainerWidget({
    super.key, required this.width, required this.height,
    required this.imagePath
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: CachedNetworkImage(
        width: width,
        height: height,
        fit: BoxFit.cover,
        imageUrl: imagePath,
        placeholder: (context, url) => Container(
          color: Theme.of(context).indicatorColor,
          child:  Center(child: CircularProgressIndicator(color: ColorManager.lightprimary,)),
        ),
        errorWidget: (context, url, error) => Container(
          color: Colors.grey[200],
          child: Icon(Icons.error,color:ColorManager.white ,)
        ),
      ),
    );
  }
}