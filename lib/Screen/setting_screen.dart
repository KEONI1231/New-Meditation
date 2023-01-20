import 'package:flutter/material.dart';

import '../Constant/user.dart';

class SettingScreen extends StatefulWidget {
  loginUser user;
  SettingScreen({
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('웅앵'),
      ),
    );
  }
}
