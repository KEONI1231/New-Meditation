import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constant/color.dart';
import '../Constant/data.dart';
import '../Constant/user.dart';
import 'login_screen.dart';

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
    final ContainerDecoration = BoxDecoration(
      color: Colors.white,
      //border: Border.all(width: 2, color: PRIMARY_COLOR),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: Offset(0, 10))
      ],
    );
    final ts =
        TextStyle(fontWeight: FontWeight.w900, color: TEXT_COLOR, fontSize: 18);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 32),
                Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text('설정',
                        style: ts.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 32,
                            color: Colors.grey[700]))),
                SizedBox(height: 16),
                FirstContainer(
                    ts: ts, ContainerDecoration: ContainerDecoration),
                SizedBox(height: 40),
                FirstContainer(ts: ts, ContainerDecoration: ContainerDecoration)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FirstContainer extends StatefulWidget {
  final TextStyle ts;
  final BoxDecoration ContainerDecoration;
  const FirstContainer(
      {required this.ts, required this.ContainerDecoration, Key? key})
      : super(key: key);

  @override
  State<FirstContainer> createState() => _FirstContainerState();
}

class _FirstContainerState extends State<FirstContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.1,
      decoration: widget.ContainerDecoration,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 16, 0, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () {},
              child: Text(
                '학교인증',
                style: widget.ts,
              ),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () {},
              child: Text(
                '비밀번호 변경',
                style: widget.ts,
              ),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () {},
              child: Text(
                '이메일 변경',
                style: widget.ts,
              ),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () {
                tryLogout(context, widget.ts);
              },
              child: Text(
                '로그아웃',
                style: widget.ts,
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Future tryLogout(context, ts) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: BRIGHT_COLOR,
          title: Text('알림', style: ts),
          content: Text('로그아웃 하시겠습니까?', style: ts),
          actions: [
            TextButton(
              onPressed: () {
                try {
                  sp.setString(userId, '!')!;
                  sp.setString(userPassword, '!')!;
                  sp.setBool(loginState, false)!;
                } catch (e) {}
                Navigator.pop(context);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        //페이지 스택 제거
                        builder: (BuildContext context) => LoginScreen()),
                    (route) => false);
              },
              child: Text('예', style: ts),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('아니요', style: ts),
            ),
          ],
        );
      },
    );
  }
}
