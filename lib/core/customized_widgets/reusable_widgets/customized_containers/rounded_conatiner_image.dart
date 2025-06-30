import 'package:flutter/material.dart';

class RoundedContainerWidget extends StatelessWidget {
  final double width,height;
  final String imagePath;

  const RoundedContainerWidget({
    super.key, required this.width, required this.height,
    required this.imagePath
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height:height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).indicatorColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          imagePath, // Replace with your image path
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}