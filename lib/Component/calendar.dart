import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:table_calendar/table_calendar.dart';

import '../Constant/color.dart';
import '../Constant/user.dart';

class Calendar extends StatefulWidget {
  loginUser user;

  Calendar({required this.user, Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime? selectedDay;
  DateTime? focusedDay;
  DateTime focusedDayVal = DateTime.now();
  TextStyle ts = TextStyle(fontWeight: FontWeight.w700);
  BoxDecoration boxDecoration =
      BoxDecoration(borderRadius: BorderRadius.circular(300));
  dynamic Year = List<String>.filled(0, '', growable: true);
  dynamic Month = List<String>.filled(0, '', growable: true);
  dynamic Day = List<String>.filled(0, '', growable: true);
  List recordDate = List<String>.filled(0, '', growable: true);
  List castRecordDate = List<String>.filled(0, '', growable: true);
  late String data;
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    return StreamBuilder<QuerySnapshot>(
        stream: firestore.collection("users").where('email',isEqualTo :widget.user.email).snapshots(),
        builder: (context, snapshot) {
          //print(castRecordDate.runtimeType);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: TEXT_COLOR));
          }
          List recordDate =
              List<String>.from(snapshot.data?.docs[0]['record_list'] ?? []);
          //print('길이');
          //print(recordDate.length);
          if (recordDate.length != 1) {
            for (int i = 0; i < recordDate.length; i++) {
              if (!recordDate[i].contains('default')) {
                //print("asd" + recordDate[i].toString());

                data = (recordDate[i].replaceAll(RegExp('[^0-9]'), ""));
                //castRecordDate[i].add(recordDate[i].replaceAll(RegExp('[^0-9]'), ""));

//                Year.add(data.substring(0, 4));/

                //Month.add(data.substring(4, 6));
                //Day.add(data.substring(6, 8));


                Year.add( data.substring(0,4) + data.substring(4,6) + data.substring(6,8));
                //print(Year[i]);
              }
              //print();
              // print('길이' + recordDate.length.toString());

            }
          }

          return Padding(
            padding: const EdgeInsets.all(32.0),
            child: TableCalendar(
              calendarBuilders:
                  CalendarBuilders(markerBuilder: (context, _day, event) {
                //DateTime _date = DateTime.utc(date.year, date.month, date.day);

                //print("asd" + _events[DateTime.utc(date.year, date.month, date.day)].toString());
               /* if (Year.contains(_day.year.toString()) == true &&
                    Month.contains(_day.month.toString().padLeft(2, '0')) == true &&
                    Day.contains(_day.day.toString().padLeft(2, '0')) == true) {*/
            if(Year.contains(_day.year.toString() + _day.month.toString().padLeft(2,'0') + _day.day.toString().padLeft(2, '0'))) {
                  return Container(
                    width: 35,
                    decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.2),
                        shape: BoxShape.circle),

                  );

                }
              }),
              locale: 'ko_KR',
              focusedDay: focusedDayVal,
              firstDay: DateTime(1800),
              lastDay: DateTime(3000),
              headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle:
                      TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
              calendarStyle: CalendarStyle(
                  markerSize: 10.0,
                  markerDecoration: BoxDecoration(
                      color: PRIMARY_COLOR, shape: BoxShape.circle),
                  isTodayHighlighted: true,
                  defaultDecoration: boxDecoration,
                  weekendDecoration: boxDecoration,
                  todayDecoration:
                      boxDecoration.copyWith(color: SOFT_PRIMARY_COLOR),
                  defaultTextStyle: ts,
                  weekendTextStyle: ts,
                  todayTextStyle: ts.copyWith(color: Colors.black),
                  outsideDecoration: BoxDecoration(shape: BoxShape.rectangle)),
            ),
          );
        });
  }
}

class Event {
  final DateTime date;

  Event({required this.date});
}
