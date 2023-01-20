import 'dart:core';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class loginUser {
  String lastPostTime;
  String email;
  String pw;
  String name;
  String createdTime;
  String studentNumber;
  int boolAdmin;
  int week_hour;
  int week_minute;
  int week_second;
  int month_hour;
  int month_minute;
  int month_second;
  int today_hour;
  int today_minute;
  int today_second;
  int today_medi_ok;
  int total_medi_ok;
  int this_month;
  int this_week;
  int this_today;
  loginUser(
    this.lastPostTime,
    this.email,
    this.name,
    this.pw,
    this.boolAdmin,
    this.createdTime,
    this.studentNumber,
    this.week_hour,
    this.week_minute,
    this.week_second,
    this.month_hour,
    this.month_minute,
    this.month_second,
    this.today_hour,
    this.today_minute,
    this.today_second,
    this.today_medi_ok,
    this.total_medi_ok,
      this.this_month,
      this.this_week,
      this.this_today,
  );

  loginUser.fromSnapshot(DataSnapshot snapshot)
      : lastPostTime = (snapshot.value! as Map<String, dynamic>)['lastPostTime'],
        email = (snapshot.value! as Map<String, dynamic>)['email'],
        pw = (snapshot.value! as Map<String, dynamic>)['pw'],
        name = (snapshot.value! as Map<String, dynamic>)['name'],
        studentNumber =
            (snapshot.value! as Map<String, dynamic>)['student_number'],
        boolAdmin = (snapshot.value! as Map<List<int>, dynamic>)['boolAdmin'],
        createdTime =
            (snapshot.value! as Map<List<String>, dynamic>)['createTime'],
        week_hour = (snapshot.value! as Map<List<int>, dynamic>)['week_hour'],
        week_minute =
            (snapshot.value! as Map<List<int>, dynamic>)['week_minute'],
        week_second =
            (snapshot.value! as Map<List<int>, dynamic>)['week_second'],
        month_hour = (snapshot.value! as Map<List<int>, dynamic>)['month_hour'],
        month_minute =
            (snapshot.value! as Map<List<int>, dynamic>)['month_minute'],
        month_second =
            (snapshot.value! as Map<List<int>, dynamic>)['month_second'],
        today_hour = (snapshot.value! as Map<List<int>, dynamic>)['month_hour'],
        today_minute =
            (snapshot.value! as Map<List<int>, dynamic>)['month_minute'],
        today_second =
            (snapshot.value! as Map<List<int>, dynamic>)['month_second'],
        today_medi_ok =
            (snapshot.value! as Map<List<int>, dynamic>)['month_second'],
        total_medi_ok =
            (snapshot.value! as Map<List<int>, dynamic>)['month_second'],
        this_month =
        (snapshot.value! as Map<List<int>, dynamic>)['month_second'],
        this_week =
        (snapshot.value! as Map<List<int>, dynamic>)['month_second'],
        this_today =
        (snapshot.value! as Map<List<int>, dynamic>)['month_second'];
  toJson() {
    return {
      'lastPostTime' : lastPostTime,
      'name': name,
      'PW': pw,
      'email': email,
      'studentNumber': studentNumber,
      'boolAdmin': boolAdmin,
      'createdTime': createdTime,
      'week_hour': week_hour,
      'week_minute': week_minute,
      'week_second': week_second,
      'month_hour': month_hour,
      'month_minute': month_minute,
      'month_second': month_second,
      'today_hour': today_hour,
      'today_minute': today_minute,
      'today_second': today_second,
      'today_medi_ok': today_medi_ok,
      'total_medi_ok': total_medi_ok,
      'this_month': this_month,
      'this_week': this_week,
      'this_day': this_today,
    };
  }
}
