import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Constant/color.dart';
import '../Constant/user.dart';

class RecentRecordList extends StatefulWidget {
  loginUser user;

  RecentRecordList({
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  State<RecentRecordList> createState() => _RecentRecordListState();
}

class _RecentRecordListState extends State<RecentRecordList> {
  final ts =
      TextStyle(fontWeight: FontWeight.w700, fontSize: 24, color: TEXT_COLOR);
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String date = DateTime.now().year.toString() +
      '년 ' +
      DateTime.now().month.toString().padLeft(2, '0') +
      '월 ' +
      DateTime.now().day.toString().padLeft(2, '0') +
      '일';

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppBar(
              title: Text('최근 명상 기록',
                  style: ts.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      color: BRIGHT_COLOR)),
              backgroundColor: PRIMARY_COLOR,
              centerTitle: true,
            ),
            SizedBox(
              height: 16,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: firestore
                  .collection("users")
                  .doc(widget.user.email)
                  .collection("record")
                  .orderBy('createdTime', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(color: TEXT_COLOR);
                }
                return Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    //shrinkWrap: true,
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              //border: Border.all(width: 2, color: PRIMARY_COLOR),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.grey, width: 1)),
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
                                        '${snapshot.data?.docs[index]['year'].toString().padLeft(2, '0')}년 '
                                        '${snapshot.data?.docs[index]['month'].toString().padLeft(2, '0')}월 '
                                        '${snapshot.data?.docs[index]['day'].toString().padLeft(2, '0')}일'),
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
                                            '${snapshot.data?.docs[index]['hour'].toString().padLeft(2, '0')} : '
                                            '${snapshot.data?.docs[index]['minute'].toString().padLeft(2, '0')} : '
                                            '${snapshot.data?.docs[index]['second'].toString().padLeft(2, '0')}'),
                                      ],
                                    ),

                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 12.0, left: 12),
                                child: snapshot.data?.docs[index]['friend_open'] == true ? Text('[ 공개 ]') : Text('[ 비공개] '),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Text(
                                      snapshot.data?.docs[index]['emotion'],
                                      style: ts.copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      snapshot.data?.docs[index]['content'],
                                      style: ts.copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
