import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ankh_project/core/constants/color_manager.dart';

class CarImageSlider extends StatelessWidget {
  final PageController pageController;
  final List<String> images;
  final int currentIndex;
  final Function(int) onPageChanged;

  const CarImageSlider({
    super.key,
    required this.pageController,
    required this.images,
    required this.currentIndex,
    required this.onPageChanged,
  });

  Widget _buildStepper() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List.generate(images.length, (index) {
      bool isActive = index == currentIndex;
      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        width: isActive ? 16 : 8,
        height: 8,
        decoration: BoxDecoration(
          color: isActive ? ColorManager.lightprimary : Colors.grey,
          borderRadius: BorderRadius.circular(4),
        ),
      );
    }),
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: pageController,
            itemCount: images.length,
            onPageChanged: onPageChanged,
            itemBuilder: (_, index) => Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: const Color(0xFFF9FAFB),
              ),
              child: Image.asset(images[index], fit: BoxFit.contain),
            ),
          ),
        ),
        Padding(
          padding: REdgeInsets.only(bottom: 12),
          child: _buildStepper(),
        ),
      ],
    );
  }
}