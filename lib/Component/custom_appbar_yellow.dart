import 'package:flutter/material.dart';

import '../Constant/color.dart';

class CustomAppBarYellow extends StatelessWidget {
  final String titleText;
  const CustomAppBarYellow({required this.titleText, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ts =
    TextStyle(color: TEXT_COLOR, fontSize: 16, fontWeight: FontWeight.w700);
    return AppBar(
      title: Text(titleText,
          style: ts.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 24,
              color: BRIGHT_COLOR)),
      centerTitle: true,
      backgroundColor: PRIMARY_COLOR,
      automaticallyImplyLeading: titleText == '설정' ? false : true
    );
  }
}
