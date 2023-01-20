import 'package:flutter/material.dart';

import '../Constant/user.dart';

class MeditaionScreen extends StatelessWidget {
  loginUser user;
  MeditaionScreen({required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle ts = TextStyle(
        fontSize: 24, color: Colors.grey, fontWeight: FontWeight.w600);
    return Scaffold(
        body: Center(
      child: Text(
        '서비스 준비중',
        style: ts,
      ),
    ));
  }
}
