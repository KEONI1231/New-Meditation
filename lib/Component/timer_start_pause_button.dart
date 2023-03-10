import 'package:flutter/material.dart';

import '../Constant/color.dart';

class CustomTimerButton extends StatelessWidget {
  final ts = TextStyle(color: Colors.black, fontWeight: FontWeight.w800);
  final bool isStart;
  final VoidCallback onPressed;

  CustomTimerButton({
    required this.isStart,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      //로그인 성공시 홈화면으로 가게 해주는 네비게이터 버튼. 버튼클릭시
      //클릭시 로그인 성공여부를 확인해줄 로직 추가예정.
      minWidth: 80.0,
      height: 30.0,

      child: ElevatedButton(
        //로그인 시도 버튼.
        style: ElevatedButton.styleFrom(
          primary: isStart == false ? PRIMARY_COLOR : BRIGHT_COLOR,
          side: BorderSide(color: PRIMARY_COLOR),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0), //버튼모양 둥글게.
          ),
          shadowColor: BRIGHT_COLOR,
          minimumSize: const Size(250, 40),
        ),
        child:
            isStart == true ? Text('종료', style: ts) : Text('시작하기', style: ts),
        onPressed: onPressed,
      ),
    );
  }
}
