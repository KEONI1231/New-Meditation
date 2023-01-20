import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../Component/custom_record_messeage_dialog.dart';
import '../../Component/timer_start_pause_button.dart';
import '../../Constant/user.dart';

class TimerWidget extends StatefulWidget {
  loginUser user;
  TimerWidget({required this.user, Key? key}) : super(key: key);

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  int hour = 0;
  int minute = 0;
  int second = 0;

  final boxDecoration = BoxDecoration(
    //border: Border.all(width: 2, color: PRIMARY_COLOR),
    borderRadius: BorderRadius.circular(16),
  );
  final ts = TextStyle(fontSize: 24, fontWeight: FontWeight.w700);
  var StartState = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 16,
              ),
              StreamBuilder<int>(
                  stream: start_pause(),
                  builder: (context, snapshot) {
                    //print(snapshot.data!.docs[0]['content']);

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width / 7,
                            height: 80,
                            child: Center(
                              child: Text(
                                  '${widget.user.today_hour.toString().padLeft(2, '0')}',
                                  style: ts),
                            ),
                            decoration: boxDecoration),
                        SizedBox(
                          width: 8,
                        ),
                        Text(' : '),
                        SizedBox(
                          width: 8,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width / 7,
                            height: 80,
                            child: Center(
                              child: Text(
                                  '${widget.user.today_minute.toString().padLeft(2, '0')}',
                                  style: ts),
                            ),
                            decoration: boxDecoration),
                        SizedBox(
                          width: 8,
                        ),
                        Text(' : '),
                        SizedBox(
                          width: 8,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width / 7,
                            height: 80,
                            child: Center(
                              child: Text(
                                  '${widget.user.today_second.toString().padLeft(2, '0')}',
                                  style: ts),
                            ),
                            decoration: boxDecoration),
                      ],
                    );
                  }),
              const SizedBox(
                height: 96,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTimerButton(isStart: StartState, onPressed: button)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void button() {
    setState(() {
      if (StartState == false) {
        StartState = true;
      } else {
        StartState = false;
        Record(context, widget.user, hour, minute, second);
      }
    });
  }

  Stream<int> start_pause() async* {
    Timer? timer;
    if (StartState == true) {
      while (true) {
        await Future.delayed(Duration(seconds: 1));
        widget.user.today_second +=1;
        widget.user.week_second += 1;
        widget.user.month_second += 1;

        if(widget.user.today_second >= 60) {
          widget.user.today_second -= 60;
          widget.user.today_minute+=1;
        }
        if(widget.user.today_minute >= 60) {
          widget.user.today_minute -= 60;
          widget.user.today_minute+=1;
        }
        // 94 ~ 105 주간 명상 시간 업데이트

        if(widget.user.week_second >= 60) {
          widget.user.week_second -= 60;
          widget.user.week_minute+=1;
        }
        if(widget.user.week_minute >= 60) {
          widget.user.week_minute -= 60;
          widget.user.week_hour+=1;
        }

        if(widget.user.month_second >= 60) {
          widget.user.month_second -= 60;
          widget.user.month_minute+=1;
        }
        if(widget.user.month_minute >= 60) {
          widget.user.month_minute -= 60;
          widget.user.month_hour+=1;
        }
        if (StartState == false) {
          break;
        }
        yield widget.user.today_second;
        yield widget.user.today_minute;
        yield widget.user.today_hour;
      }
    }
  }
}
