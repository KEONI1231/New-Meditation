import 'package:flutter/material.dart';

import '../constant/color.dart';

class CustomButtonSignUp extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const CustomButtonSignUp({required this.text,required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ts = TextStyle(color: Colors.black, fontWeight: FontWeight.w800);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: PRIMARY_COLOR,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
      onPressed: onPressed,
      child : Text(text,style: ts,),
    );
  }
}
