import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../Component/alert_dialog.dart';
import '../Component/circular_progress_indicator_dialog.dart';
import '../Constant/color.dart';
import '../Constant/data.dart';
import '../Constant/user.dart';
import 'login_screen.dart';
import 'main_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ts = TextStyle(
      fontWeight: FontWeight.w900, color: TEXT_COLOR, fontSize: 34);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: BRIGHT_COLOR,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('자아와 명상',style : ts),
              intro_bottom(), //각종 기본적인 텍스트.
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: PRIMARY_COLOR,
                  shape :  RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))
                ),
                onPressed: () async{
                  String stateid;
                  String statepw;
                  bool login;
                  SharedPreferences sp = await SharedPreferences.getInstance();

                  try{
                    stateid = sp.getString(userId)!;
                    statepw = sp.getString(userPassword)!;
                    login = sp.getBool(loginState)!;

                    print("=========================");
                    print(stateid);
                    print(statepw);
                    print(login);
                    print("=========================");
                    if(login == true) {
                      FirebaseFirestore firestore = FirebaseFirestore.instance;
                      final String date = DateTime.now().year.toString() +
                          '년 ' +
                          DateTime.now().month.toString().padLeft(2, '0') +
                          '월 ' +
                          DateTime.now().day.toString().padLeft(2, '0') +
                          '일';
                      int weekOfMonth = weekOfMonthForStandard(DateTime.now());
                      //print(" 몇번째 주 : " + weekOfMonrh.toString());
                      String email;
                      String pw;
                      String name;
                      int week_hour;
                      int week_minute;
                      int week_second;
                      int month_hour;
                      int month_minute;
                      int month_second;
                      int today_hour;
                      int today_minute;
                      int today_second;
                      int this_today;
                      int this_week;
                      int this_month;
                      int boolAdmin;
                      int today_medi_ok;
                      int total_medi_ok;
                      String createdTime;
                      String student_number;
                      String lastPostTime;
                      DocumentSnapshot userData;
                      try {
                        // try catch.
                        CustomCircular(context, '로그인 중...');
                        userData = await firestore
                            .collection('users')
                            .doc(stateid)
                            .get();
                        email = userData['email'];
                        pw = userData['pw'];
                        if (email == stateid && pw == statepw) {

                          name = userData['name'];
                          student_number = userData['student_number'];
                          boolAdmin = userData['is_admin'];
                          createdTime = userData['created_time'];
                          week_hour = userData['week_hour'];
                          week_minute = userData['week_minute'];
                          week_second = userData['week_second'];
                          month_hour = userData['month_hour'];
                          month_minute = userData['month_minute'];
                          month_second = userData['month_second'];
                          today_hour = userData['today_hour'];
                          today_minute = userData['today_minute'];
                          today_second = userData['today_second'];
                          this_week = userData['this_week'];
                          this_today = userData['this_today'];
                          this_month = userData['this_month'];
                          today_medi_ok = userData['today_medi_ok'];
                          total_medi_ok = userData['total_medi_ok'];
                          lastPostTime = userData['last_post_time'];
                          if (this_today != DateTime.now().day) {
                            if (this_week != weekOfMonth) {
                              await firestore
                                  .collection("users")
                                  .doc(stateid)
                                  .update({
                                "today_hour": 0,
                                "today_minute": 0,
                                "today_second": 0,
                                "week_hour": 0,
                                "week_minute": 0,
                                "week_second": 0,
                                "this_today": DateTime.now().day,
                                "this_week": weekOfMonth,
                                "today_medi_ok": 0,
                              });
                              today_hour = 0;
                              today_minute = 0;
                              today_second = 0;
                              week_hour = 0;
                              week_minute = 0;
                              week_second = 0;
                              this_today = DateTime.now().day;
                              this_week = weekOfMonth;
                              today_medi_ok = 0;
                            } else if (this_month != DateTime.now().month) {
                              await firestore
                                  .collection("users")
                                  .doc(stateid)
                                  .update({
                                "today_hour": 0,
                                "today_minute": 0,
                                "today_second": 0,
                                "week_hour": 0,
                                "week_minute": 0,
                                "week_second": 0,
                                "month_hour": 0,
                                "month_minute": 0,
                                "month_second": 0,
                                "this_today": DateTime.now().day,
                                "this_week": weekOfMonth,
                                "this_month": DateTime.now().month,
                                "today_medi_ok": 0,
                              });
                              today_hour = 0;
                              today_minute = 0;
                              today_second = 0;
                              week_hour = 0;
                              week_minute = 0;
                              week_second = 0;
                              month_hour = 0;
                              month_minute = 0;
                              month_second = 0;
                              this_today = DateTime.now().day;
                              this_week = weekOfMonth;
                              this_month = DateTime.now().month;

                              today_medi_ok = 0;
                            } else {
                              await firestore
                                  .collection("users")
                                  .doc(stateid)
                                  .update({
                                "this_today": DateTime.now().day,
                                "today_hour": 0,
                                "today_minute": 0,
                                "today_second": 0,
                                "today_medi_ok": 0,
                              });
                              this_today = DateTime.now().day;
                              today_hour = 0;
                              today_minute = 0;
                              today_second = 0;

                              today_medi_ok = 0;
                            }
                          }
                          loginUser user = new loginUser(
                              lastPostTime,
                              email,
                              name,
                              pw,
                              boolAdmin,
                              createdTime,
                              student_number,
                              week_hour,
                              week_minute,
                              week_second,
                              month_hour,
                              month_minute,
                              month_second,
                              today_hour,
                              today_minute,
                              today_second,
                              today_medi_ok,
                              total_medi_ok,
                              this_month,
                              this_week,
                              this_today);
                          print(user.email +
                              " " +
                              user.name +
                              " " +
                              user.pw +
                              " " +
                              user.boolAdmin.toString() +
                              " " +
                              user.createdTime +
                              " " +
                              user.studentNumber +
                              " " +
                              user.week_hour.toString() +
                              " " +
                              user.week_minute.toString() +
                              " " +
                              user.week_second.toString() +
                              " " +
                              user.month_hour.toString() +
                              " " +
                              user.month_minute.toString() +
                              " " +
                              user.month_second.toString() +
                              "" +
                              user.today_medi_ok.toString());

                          Navigator.pop(context);
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (BuildContext context) {
                            return MainScreen(user: user);
                          }));
                        } else {
                          Navigator.pop(context);
                          DialogShow(context, '시스템 에러.');
                        }
                      } catch (e) {
                        print(e);
                        Navigator.pop(context);
                        DialogShow(context, '회원정보가 잘못되었습니다.');
                      }
                    } else {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return LoginScreen(); //로그인 화면으로 이동.
                          },
                        ),
                      );
                    }
                  }catch(e){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return LoginScreen(); //로그인 화면으로 이동.
                        },
                      ),
                    );
                  }
                },
                child: Text('시작하기',style: ts.copyWith(fontWeight: FontWeight.w800, fontSize: 16,color: BRIGHT_COLOR)),
              ),
            ],
          ),
        ),
      ),
    );

  }
  int weekOfMonthForStandard(DateTime date) {
    // 월 주차.
    late int _weekOfMonth;

    // 선택한 월의 첫번째 날짜.
    final _firstDay = DateTime(date.year, date.month, 1);

    // 선택한 월의 마지막 날짜.
    final _lastDay = DateTime(date.year, date.month + 1, 0);

    // 첫번째 날짜가 목요일보다 작은지 판단.
    final _isFirstDayBeforeThursday = _firstDay.weekday <= DateTime.thursday;

    // 선택한 날짜와 첫번째 날짜가 같은 주에 위치하는지 판단.
    if (isSameWeek(date, _firstDay)) {
      // 첫번째 날짜가 목요일보다 작은지 판단.
      if (_isFirstDayBeforeThursday) {
        // 1주차.
        _weekOfMonth = 1;
      }

      // 저번달의 마지막 날짜의 주차와 동일.
      else {
        final _lastDayOfPreviousMonth = DateTime(date.year, date.month, 0);

        // n주차.
        _weekOfMonth = weekOfMonthForStandard(_lastDayOfPreviousMonth);
      }
    } else {
      // 선택한 날짜와 마지막 날짜가 같은 주에 위치하는지 판단.
      if (isSameWeek(date, _lastDay)) {
        // 마지막 날짜가 목요일보다 큰지 판단.
        final _isLastDayBeforeThursday = _lastDay.weekday >= DateTime.thursday;
        if (_isLastDayBeforeThursday) {
          // 주차를 단순 계산 후 첫번째 날짜의 위치에 따라서 0/-1 결합.
          // n주차.
          _weekOfMonth =
              weekOfMonthForSimple(date) + (_isFirstDayBeforeThursday ? 0 : -1);
        }

        // 다음달 첫번째 날짜의 주차와 동일.
        else {
          // 1주차.
          _weekOfMonth = 1;
        }
      }

      // 첫번째주와 마지막주가 아닌 날짜들.
      else {
        // 주차를 단순 계산 후 첫번째 날짜의 위치에 따라서 0/-1 결합.
        // n주차.
        _weekOfMonth =
            weekOfMonthForSimple(date) + (_isFirstDayBeforeThursday ? 0 : -1);
      }
    }

    return _weekOfMonth;
  }

  bool isSameWeek(DateTime dateTime1, DateTime dateTime2) {
    final int _dateTime1WeekOfMonth = weekOfMonthForSimple(dateTime1);
    final int _dateTime2WeekOfMonth = weekOfMonthForSimple(dateTime2);
    return _dateTime1WeekOfMonth == _dateTime2WeekOfMonth;
  }

  int weekOfMonthForSimple(DateTime date) {
    // 월의 첫번째 날짜.
    DateTime _firstDay = DateTime(date.year, date.month, 1);

    // 월중에 첫번째 월요일인 날짜.
    DateTime _firstMonday = _firstDay
        .add(Duration(days: (DateTime.monday + 7 - _firstDay.weekday) % 7));

    // 첫번째 날짜와 첫번째 월요일인 날짜가 동일한지 판단.
    // 동일할 경우: 1, 동일하지 않은 경우: 2 를 마지막에 더한다.
    final bool isFirstDayMonday = _firstDay == _firstMonday;

    final _different = calculateDaysBetween(from: _firstMonday, to: date);

    // 주차 계산.
    int _weekOfMonth = (_different / 7 + (isFirstDayMonday ? 1 : 2)).toInt();
    return _weekOfMonth;
  }

  int calculateDaysBetween({required DateTime from, required DateTime to}) {
    return (to.difference(from).inHours / 24).round();
  }
}

class intro_bottom extends StatefulWidget {
  const intro_bottom({Key? key}) : super(key: key);

  @override
  State<intro_bottom> createState() => _intro_bottomState();
}

class _intro_bottomState extends State<intro_bottom> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'ⓒ명상사업팀',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10.0,
              color: TEXT_COLOR,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            '명상가들을 위한 앱',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11.0,
              color: TEXT_COLOR,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            'Test.ver',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10.0,
              color: TEXT_COLOR,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

}
