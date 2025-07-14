import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/feauture/details_screen/full_image_view_screen.dart';
import 'package:ankh_project/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllImagesScreen extends StatelessWidget {
  static String allImagesScreenRouteName = "allImagesScreen";

  final String imageUrl;

  const AllImagesScreen({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final List<String> images = imageUrl.isNotEmpty ? [imageUrl] : [];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(AppLocalizations.of(context)!.images),
        centerTitle: true,
        backgroundColor: ColorManager.lightprimary,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: images.isEmpty
            ? Center(
          child: Text(
            "there is no images ",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.grey,
            ),
          ),
        )
            : GridView.builder(
          itemCount: images.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 12.h,
            childAspectRatio: 1,
          ),
            itemBuilder: (context, index) {
              final img = images[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FullImageViewScreen(images: images,initialIndex: index,),
                    ),
                  );
                },
                child: Hero(
                  tag: img,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.network(
                      img,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.broken_image),
                      ),
                    ),
                  ),
                ),
              );
            }
        ),
      ),
    );
  }
}
