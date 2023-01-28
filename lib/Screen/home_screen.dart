import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medi/Screen/recent_record_screen.dart';
import 'package:medi/Screen/today_record_detail.dart';

import '../Component/calendar.dart';
import '../Constant/color.dart';
import '../Constant/user.dart';
import 'DonggukContainer/timer_screen.dart';
import 'diary_screen.dart';

class HomeScreen extends StatefulWidget {
  loginUser user;
  HomeScreen({required this.user, Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    print(DateTime.now().weekday);
    final ts =
        TextStyle(fontWeight: FontWeight.w700, fontSize: 24, color: TEXT_COLOR);
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final String date = DateTime.now().year.toString() +
        '년 ' +
        DateTime.now().month.toString().padLeft(2, '0') +
        '월 ' +
        DateTime.now().day.toString().padLeft(2, '0') +
        '일';
    //print(DateTime.now().weekday);
    return Scaffold(
          body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Calendar(user: widget.user),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 32,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '오늘의 명상 일기',
                          style: ts,
                        ),
                        GestureDetector(
                          onTap: widget.user.today_medi_ok == 0
                              ? () {
                                  Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  TimerWidget(user: widget.user)))
                                      .then((value) {
                                    setState(() {});
                                  });
                                }
                              : () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => TodayRecordDetail(
                                              user: widget.user))).then((value) {
                                    setState(() {});
                                  });
                                },
                          child: Text(
                            '수정하기',
                            style: ts.copyWith(
                              color: Colors.grey[700],
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    widget.user.today_medi_ok == 0
                        ? GestureDetector(
                            onTap: () {
                              Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              TimerWidget(user: widget.user)))
                                  .then((value) {
                                setState(() {});
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 120,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  //border: Border.all(width: 2, color: PRIMARY_COLOR),
                                  borderRadius: BorderRadius.circular(16),
                                  border:
                                      Border.all(color: Colors.grey, width: 1)),
                              child: Center(
                                child: Icon(
                                  Icons.add,
                                  color: Colors.grey,
                                  size: 48,
                                ),
                              ),
                            ),
                          )
                        : StreamBuilder<QuerySnapshot>(
                            stream: firestore
                                .collection("users")
                                .doc(widget.user.email)
                                .collection("record")
                                .orderBy('createdTime', descending: true)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator(
                                    color: PRIMARY_COLOR);
                              }
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => TodayRecordDetail(
                                              user: widget.user))).then((value) {
                                    setState(() {});
                                  });
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 120,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      //border: Border.all(width: 2, color: PRIMARY_COLOR),
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                          color: Colors.grey, width: 1)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(date),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.timer_outlined,
                                                  color: Colors.grey,
                                                  size: 16,
                                                ),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Text(
                                                    '${snapshot.data?.docs[0]['hour'].toString().padLeft(2, '0')} : '
                                                    '${snapshot.data?.docs[0]['minute'].toString().padLeft(2, '0')} : '
                                                    '${snapshot.data?.docs[0]['second'].toString().padLeft(2, '0')}'),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                snapshot.data?.docs[0]['emotion'],
                                                style: ts.copyWith(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black,
                                                    fontSize: 16),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis),
                                            Text(
                                                snapshot.data?.docs[0]['content'],
                                                style: ts.copyWith(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black,
                                                    fontSize: 16),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            })
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '최근 명상 일기',
                      style: ts,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RecentRecordList(
                                      user: widget.user,
                                    ))).then((value) {
                          setState(() {});
                        });
                      },
                      child: Text(
                        '더보기',
                        style: ts.copyWith(
                          color: Colors.grey[700],
                          fontSize: 12,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: widget.user.total_medi_ok == 0
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        height: 120,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            //border: Border.all(width: 2, color: PRIMARY_COLOR),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.grey, width: 1)),
                        child: Center(
                            child: Text(
                          '최근 명상 기록이 없습니다.',
                          style:
                              ts.copyWith(color: Colors.grey[700], fontSize: 16),
                        )),
                      )
                    : StreamBuilder<QuerySnapshot>(
                        stream: firestore
                            .collection("users")
                            .doc(widget.user.email)
                            .collection("record")
                            .orderBy('createdTime', descending: true)
                            .snapshots(),
                        builder: (context, snapshot) {
                          //print(snapshot.data!.docs[0]['content']);
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator(
                                color: PRIMARY_COLOR);
                          }
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RecentRecordList(
                                            user: widget.user,
                                          ))).then((value) {
                                setState(() {});
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 120,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  //border: Border.all(width: 2, color: PRIMARY_COLOR),
                                  borderRadius: BorderRadius.circular(16),
                                  border:
                                      Border.all(color: Colors.grey, width: 1)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            '${snapshot.data?.docs[0]['createdTime'].toString().padLeft(2, '0')}'),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.timer_outlined,
                                              color: Colors.grey,
                                              size: 16,
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                                '${snapshot.data?.docs[0]['hour'].toString().padLeft(2, '0')} : '
                                                '${snapshot.data?.docs[0]['minute'].toString().padLeft(2, '0')} : '
                                                '${snapshot.data?.docs[0]['second'].toString().padLeft(2, '0')}'),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(snapshot.data?.docs[0]['emotion'],
                                            style: ts.copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                                fontSize: 16),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis),
                                        Text(snapshot.data?.docs[0]['content'],
                                            style: ts.copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                                fontSize: 16),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  '나의 명상 시간',
                  style: ts,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 32,
                  ),
                  Text(
                    '${widget.user.today_hour.toString().padLeft(2, '0')} : ${widget.user.today_minute.toString().padLeft(2, '0')} : ${widget.user.today_second.toString().padLeft(2, '0')}',
                    style: ts.copyWith(
                        color: Colors.black,
                        fontSize: 48,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        '${widget.user.this_month.toString().padLeft(2, '0')}월의 명상 시간',
                        style: ts.copyWith(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '${widget.user.month_hour.toString().padLeft(2, '0')} : ${widget.user.month_minute.toString().padLeft(2, '0')} : ${widget.user.month_second.toString().padLeft(2, '0')}',
                        style: ts.copyWith(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        '${widget.user.this_week.toString().padLeft(2, '0')}주간 명상 시간',
                        style: ts.copyWith(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '${widget.user.week_hour.toString().padLeft(2, '0')} : ${widget.user.week_minute.toString().padLeft(2, '0')} : ${widget.user.week_second.toString().padLeft(2, '0')}',
                        style: ts.copyWith(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 200,
                  )
                ],
              )
            ],
          ),
        ),
      ));
  }
}
