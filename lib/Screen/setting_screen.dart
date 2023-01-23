import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medi/Screen/change_password.dart';
import 'package:medi/Screen/send_mail_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constant/color.dart';
import '../Constant/data.dart';
import '../Constant/user.dart';
import 'delete_user_before_login_screen.dart';
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
        TextStyle(fontWeight: FontWeight.w800, color: TEXT_COLOR, fontSize: 18);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              AppBar(
                  title: Text('설정',
                      style: ts.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                          color: BRIGHT_COLOR)),
                  centerTitle: true,
                  backgroundColor: PRIMARY_COLOR),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 32),
                    Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text('설정',
                            style: ts.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                color: Colors.grey[700]))),
                    SizedBox(height: 16),
                    FirstContainer(
                        user: widget.user,
                        ts: ts,
                        ContainerDecoration: ContainerDecoration),
                    SizedBox(height: 56),
                    Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text('기타',
                            style: ts.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                color: Colors.grey[700]))),
                    SizedBox(height: 16),
                    SecondContainer(
                        user: widget.user,
                        ts: ts,
                        ContainerDecoration: ContainerDecoration)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FirstContainer extends StatefulWidget {
  final TextStyle ts;
  final BoxDecoration ContainerDecoration;
  final loginUser user;

  const FirstContainer(
      {required this.user,
      required this.ts,
      required this.ContainerDecoration,
      Key? key})
      : super(key: key);

  @override
  _FirstContainerState createState() => _FirstContainerState();
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
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return ChangePassword(user: widget.user);
                }));
              },
              child: Text(
                '비밀번호 변경',
                style: widget.ts,
              ),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return SendMail(ContainerDecoration: widget.ContainerDecoration,user: widget.user);
                }));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '문의하기',
                    style: widget.ts,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text('kimkeonhwi991231@gmail.com',
                        style: widget.ts
                            .copyWith(fontSize: 13, color: Colors.grey)),
                  ),
                ],
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

class SecondContainer extends StatefulWidget {
  final TextStyle ts;
  final BoxDecoration ContainerDecoration;
  final loginUser user;

  const SecondContainer(
      {required this.user,
      required this.ts,
      required this.ContainerDecoration,
      Key? key})
      : super(key: key);

  @override
  State<SecondContainer> createState() => _SecondContainerrState();
}

class _SecondContainerrState extends State<SecondContainer> {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '앱 버전',
                  style: widget.ts,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(version,
                      style:
                          widget.ts.copyWith(fontSize: 13, color: Colors.grey)),
                ),
              ],
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return DeleteAccount(user: widget.user);
                }));
              },
              child: Text(
                '회원 탈퇴',
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
