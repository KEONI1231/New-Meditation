import 'package:flutter/material.dart';

import '../constant/color.dart';

Future DialogShow(context, String contentText) async {
  final ts = TextStyle(color: TEXT_COLOR);
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: BRIGHT_COLOR,
          title: Text('알림', style: ts),
          content: Text(contentText, style: ts),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('확인', style: ts),
            ),
          ],
        );
      },
  );
}
