
import 'package:flutter/material.dart';

class MyTextButton extends StatelessWidget {
  Function onBottonClick;
  Widget buttonWidegt;

   MyTextButton({
    required this.onBottonClick,required this.buttonWidegt
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: () => onBottonClick(), child: buttonWidegt ,);
  }
}