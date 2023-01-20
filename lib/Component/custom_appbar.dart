import 'package:flutter/material.dart';

import '../Constant/color.dart';

class CustomAppBar extends StatelessWidget {
  final String titleText;
  const CustomAppBar({required this.titleText, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        titleText,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
      ),
      backgroundColor: BRIGHT_COLOR,
      centerTitle: true,
    );
  }
}
