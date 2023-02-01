import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medi/Component/custom_appbar_yellow.dart';
import 'package:medi/Constant/user.dart';

import '../../Constant/color.dart';

class FriendRecentRecord extends StatefulWidget {
  final String targetEmail;
  final loginUser user;

  const FriendRecentRecord({
    required this.targetEmail,
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  State<FriendRecentRecord> createState() => _FriendRecentRecordState();
}

class _FriendRecentRecordState extends State<FriendRecentRecord> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final ts =
      TextStyle(fontWeight: FontWeight.w700, fontSize: 24, color: TEXT_COLOR);
  final ts1 =
      TextStyle(fontWeight: FontWeight.w800, color: TEXT_COLOR, fontSize: 18);
  final ContainerDecoration = BoxDecoration(
    color: Colors.white,
    //border: Border.all(width: 2, color: PRIMARY_COLOR),
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 1,
          blurRadius: 7,
          offset: Offset(0, 10))
    ],
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            CustomAppBarYellow(titleText: '공개 게시글'),
            SizedBox(height: 40,),
            Container(
              width: MediaQuery.of(context).size.width / 1.1,
              decoration: ContainerDecoration,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 16, 0, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      widget.targetEmail,
                      style: ts1,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24,),
            StreamBuilder<QuerySnapshot>(
              stream: firestore
                  .collection("users")
                  .doc(widget.targetEmail)
                  .collection("record")
                  .orderBy('createdTime', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(color: TEXT_COLOR);
                }
                print('test');
                print(snapshot.data?.docs.length);
                return Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    //shrinkWrap: true,
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      return snapshot.data?.docs[index]['friend_open'] == true
                          ? Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
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
                                            snapshot.data?.docs[index]
                                                ['emotion'],
                                            style: ts.copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                                fontSize: 16),
                                          ),
                                          Text(
                                            snapshot.data?.docs[index]
                                                ['content'],
                                            style: ts.copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                                fontSize: 16),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : SizedBox();
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
