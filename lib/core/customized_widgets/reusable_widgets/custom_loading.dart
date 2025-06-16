import 'package:flutter/material.dart';

import '../../constants/color_manager.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: CircularProgressIndicator(
        color:ColorManager.darkBlue
      ),
    );
  }
}
