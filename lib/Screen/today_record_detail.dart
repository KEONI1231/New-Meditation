import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Component/custom_button.dart';
import '../Constant/color.dart';
import '../Constant/user.dart';
import 'DonggukContainer/timer_screen.dart';

class TodayRecordDetail extends StatefulWidget {
  loginUser user;
  TodayRecordDetail({
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  State<TodayRecordDetail> createState() => _TodayRecordDetailState();
}

class _TodayRecordDetailState extends State<TodayRecordDetail> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final ts =
      TextStyle(fontWeight: FontWeight.w700, fontSize: 24, color: TEXT_COLOR);
  final String date = DateTime.now().year.toString() +
      '년 ' +
      DateTime.now().month.toString().padLeft(2, '0') +
      '월 ' +
      DateTime.now().day.toString().padLeft(2, '0').toString() +
      '일';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(

          children: [
            StreamBuilder<QuerySnapshot>(
              stream: firestore
                  .collection("users")
                  .doc(widget.user.email)
                  .collection("record")
                  .orderBy('createdTime', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                //print(snapshot.data!.docs[0]['content']);
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(color: PRIMARY_COLOR);
                }
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(

                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Container(
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data?.docs[0]['emotion'],
                                    style: ts.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    snapshot.data?.docs[0]['content'],
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
                      SizedBox(height: 64,),
                      CustomButton(
                          text: '수정하기',
                          onPressed: () {
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            TimerWidget(user: widget.user)))
                                .then((value) {
                              setState(() {});
                            });
                          })
                    ],
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
