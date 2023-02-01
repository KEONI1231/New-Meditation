import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medi/Component/alert_dialog.dart';
import 'package:medi/Component/custom_appbar_yellow.dart';
import 'package:medi/Constant/user.dart';
import 'package:medi/Screen/Friends/friend_recent_record.dart';

import '../../Constant/color.dart';

class FriendListScreen extends StatefulWidget {
  final loginUser user;

  const FriendListScreen({required this.user, Key? key}) : super(key: key);

  @override
  State<FriendListScreen> createState() => _FriendListScreenState();
}

class _FriendListScreenState extends State<FriendListScreen> {
  final ts = TextStyle(
      fontWeight: FontWeight.w700, fontSize: 16, color: Colors.grey[800]);
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String date = DateTime.now().year.toString() +
      '년 ' +
      DateTime.now().month.toString().padLeft(2, '0') +
      '월 ' +
      DateTime.now().day.toString().padLeft(2, '0') +
      '일';
  dynamic friendsData = '';

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBarYellow(titleText: '공개 대상 목록'),
            SizedBox(
              height: 16,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: firestore
                  .collection("users")
                  .where('email', isEqualTo: widget.user.email)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(color: TEXT_COLOR);
                }
                friendsData = snapshot.data?.docs[0]['friend_list'];
                return Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    //shrinkWrap: true,
                    itemCount: friendsData.length,
                    itemBuilder: (context, index) {
                      return index != 0
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
                                      padding: const EdgeInsets.fromLTRB(
                                          16.0, 24, 16, 24),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            FriendRecentRecord(
                                                                targetEmail:
                                                                    friendsData[
                                                                        index],
                                                                user: widget
                                                                    .user))).then(
                                                    (value) {
                                                  setState(() {});
                                                });
                                              },
                                              child: RichText(
                                                text: TextSpan(
                                                    text:
                                                        '${friendsData[index].toString()}',
                                                    style: ts),
                                                maxLines: null,
                                                softWrap: true,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              tryLogout(context, ts, index);
                                            },
                                            child: Icon(
                                              Icons.highlight_off,
                                              color: Colors.grey,
                                              size: 24,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Text('');
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



  Future tryLogout(context, ts, index) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: BRIGHT_COLOR,
          title: Text('알림', style: ts),
          content: Text('해당 공개대상을 삭제하시겠습니까?', style: ts),
          actions: [
            TextButton(
              onPressed: () async {
                print(index);
                DocumentSnapshot Doc;
                Doc = await firestore
                    .collection('users')
                    .doc(widget.user.email)
                    .get();
                final List<String> recordDate =
                    List<String>.from(Doc['friend_list'] ?? []);
                dynamic recordDateToSet;
                recordDate.removeAt(index);
                recordDateToSet = recordDate.toSet().toList();
                firestore
                    .collection('users')
                    .doc(widget.user.email)
                    .update({'friend_list': recordDateToSet});
                Navigator.pop(context);
                DialogShow(context, '삭제 완료.');
              },
              child: Text('예', style: ts),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('아니요', style: ts),
            ),
          ],
        );
      },
    );
  }
}
