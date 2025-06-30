import 'package:ankh_project/core/constants/assets_manager.dart';
import 'package:flutter/material.dart';

class CarBrandItem extends StatelessWidget {
  const CarBrandItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
              color: Color(0xFF1313131A).withOpacity(0.1),
              width: 0.9
          )
      ),
      child: Image.asset(ImageAssets.carBrandLogo,scale: 1.2,),
    );
  }
}
