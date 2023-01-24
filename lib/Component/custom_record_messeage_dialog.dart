import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../constant/color.dart';
import '../Constant/user.dart';
import '../Screen/diary_screen.dart';

Future Record(context, loginUser user, int hour, int minute, int second) async {
  final ts = TextStyle(color: Colors.black);
  return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: BRIGHT_COLOR,
        content: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('알림',
                style: ts.copyWith(fontWeight: FontWeight.w500, fontSize: 24)),
            const SizedBox(height: 16),
            Text('명상하며 느낀점을 기록해보세요!', style: ts),
            const SizedBox(height: 16),
            const SizedBox(height: 16),
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) {
                      return DiaryScreen(
                        user: user,
                        hour: hour,
                        minute: minute,
                        second: second,
                      ); //받은 변수값을 RepotPost() 에도 넘겨주자.
                    },
                  ));
                },
                child: Text('기록하기', style: ts),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('닫기', style: ts),
              ),
            ],
          )
        ],
      );
    },
  );
}
