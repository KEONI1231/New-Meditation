import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Component/alert_dialog.dart';
import '../Component/circular_progress_indicator_dialog.dart';
import '../Component/custom_appbar.dart';
import '../Component/custom_button.dart';
import '../Constant/data.dart';
import '../Constant/user.dart';

class DiaryScreen extends StatefulWidget {
  loginUser user;
  final int hour;
  final int minute;
  final int second;

  DiaryScreen({
    required this.user,
    required this.hour,
    required this.minute,
    required this.second,
    Key? key,
  }) : super(key: key);

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  final TextEditingController _emotionTextController = TextEditingController();
  final TextEditingController _contentTextController = TextEditingController();
  final String date = DateTime.now().year.toString() +
      '년 ' +
      DateTime.now().month.toString().padLeft(2, '0') +
      '월 ' +
      DateTime.now().day.toString().padLeft(2, '0').toString() +
      '일';

  @override
  Widget build(BuildContext context) {
    print(widget.hour);
    print(widget.minute);
    print(widget.second);
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              CustomAppBar(titleText: '명상 일기쓰기'),
              SizedBox(
                height: 11,
              ),
              DiaryCard(
                emotionTextController: _emotionTextController,
                contentTextController: _contentTextController,
              ),
              SizedBox(
                height: 30,
              ),
              CustomButton(text: '기록하기', onPressed: try_record)
            ],
          ),
        ),
      ),
    );
  }

  void try_record() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentSnapshot DOC =
        await firestore.collection("users").doc(widget.user.email).get();
    final List<String> recordDate = List<String>.from(DOC['record_list'] ?? []);
    dynamic recordDateToSet;
    recordDate.add(date);
    print("===== 변경전 데이타 =====");
    print(recordDate);
    recordDateToSet = recordDate.toSet();
    print("===== 변경후 데이타 =====");
    print(recordDateToSet);
    CustomCircular(context, '기록 중...');
    await firestore
        .collection("users")
        .doc(widget.user.email)
        .collection("record")
        .doc(widget.user.email + date)
        .set(
      {
        "year": DateTime.now().year,
        "month": DateTime.now().month,
        "day": DateTime.now().day,
        "content": _contentTextController.text,
        "emotion": _emotionTextController.text,
        "createdTime": DateTime.now(),
        "hour": widget.user.today_hour,
        "minute": widget.user.today_minute,
        "second": widget.user.today_second
      },
    );
    // 82 ~ 93 오늘 명상 시간 업데이트
    if (widget.user.today_second >= 60) {
      widget.user.today_second -= 60;
      widget.user.today_minute += 1;
    }
    if (widget.user.today_minute >= 60) {
      widget.user.today_minute -= 60;
      widget.user.today_minute += 1;
    }
    // 94 ~ 105 주간 명상 시간 업데이트

    if (widget.user.week_second >= 60) {
      widget.user.week_second -= 60;
      widget.user.week_minute += 1;
    }
    if (widget.user.week_minute >= 60) {
      widget.user.week_minute -= 60;
      widget.user.week_hour += 1;
    }

    if (widget.user.month_second >= 60) {
      widget.user.month_second -= 60;
      widget.user.month_minute += 1;
    }
    if (widget.user.month_minute >= 60) {
      widget.user.month_minute -= 60;
      widget.user.month_hour += 1;
    }
    await firestore.collection("users").doc(widget.user.email).update({
      'total_medi_ok': FieldValue.increment(1),
      'today_medi_ok': FieldValue.increment(1),
      'today_second': widget.user.today_second,
      'today_minute': widget.user.today_minute,
      'today_hour': widget.user.today_hour,
      'week_second': widget.user.week_second,
      'week_minute': widget.user.week_minute,
      'week_hour': widget.user.week_hour,
      'month_second': widget.user.month_second,
      'month_minute': widget.user.month_minute,
      'month_hour': widget.user.month_hour,
      'last_post_time': date,
      'record_list': recordDateToSet
    });
    widget.user.total_medi_ok += 1;
    widget.user.today_medi_ok += 1;
    Navigator.pop(context);
    Navigator.pop(context);
    DialogShow(context, '기록 완료.');
  }
}

class DiaryCard extends StatefulWidget {
  final TextEditingController emotionTextController;

  final TextEditingController contentTextController;

  DiaryCard(
      {required this.contentTextController,
      required this.emotionTextController,
      Key? key})
      : super(key: key);

  @override
  State<DiaryCard> createState() => _DiaryCardState();
}

class _DiaryCardState extends State<DiaryCard> {
  final String date = DateTime.now().year.toString() +
      '년 ' +
      DateTime.now().month.toString().padLeft(2, '0') +
      '월 ' +
      DateTime.now().day.toString().padLeft(2, '0') +
      '일';

  @override
  Widget build(BuildContext context) {
    today_emotion = widget.emotionTextController.text;
    today_content = widget.contentTextController.text;

    return Column(
      children: [
        Container(
          height: 640,
          width: 347,
          child: Card(
            color: Color(0xffF2F2F0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 30,
                  ),
                  child: Text(
                    date,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Icon(
                  Icons.spa,
                  size: 128,
                  color: Colors.grey[800],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: SizedBox(
                    width: 250,
                    height: 60,
                    child: TextFormField(
                      controller: widget.emotionTextController,
                      maxLines: null,
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: '오늘의 기분을 입력해주세요',
                        hintStyle: TextStyle(
                          color: Color(0xffBFBFBD),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 320,
                    child: TextFormField(
                      expands: true,
                      controller: widget.contentTextController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      validator: (String? val) {
                        if (val == null || val.isEmpty) {
                          return '해당 필드는 필수항복입니다.';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: '오늘의 명상을 기록하세요',
                        hintStyle: TextStyle(
                          color: Color(0xffBFBFBD),
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                        //contentPadding: EdgeInsets.symmetric(vertical: 150),
                      ),
                      // textAlign: TextAlign.center,
                      //  decoration: _decoration,
                    ),
                  ),
                ),
                /* Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: SizedBox(
                    width: 317,
                    child: TextFormField(
                      maxLines: null,
                     // expands: true,
                      controller: widget.contentTextController,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: '오늘의 명상을 기록하세요',
                          hintStyle: TextStyle(
                            color: Color(0xffBFBFBD),
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 150)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),*/
              ],
            ),
          ),
        ),
      ],
    );
  }
}
