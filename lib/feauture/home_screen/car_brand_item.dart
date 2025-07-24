import 'package:flutter/material.dart';

class CarBrandItem extends StatelessWidget {
  final String imagePath;

  const CarBrandItem({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: const Color(0xFF131313).withOpacity(0.1),
          width: 0.9,
        ),
      ),
      child: Image.asset(imagePath, scale: 1.2),
    );
  }
}
