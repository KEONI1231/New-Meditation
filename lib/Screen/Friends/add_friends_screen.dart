import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medi/Component/account_textfield.dart';
import 'package:medi/Component/custom_appbar.dart';
import 'package:medi/Component/custom_appbar_yellow.dart';
import 'package:medi/Component/custom_button.dart';
import 'package:medi/Constant/user.dart';

import '../../Component/alert_dialog.dart';
import '../../Component/circular_progress_indicator_dialog.dart';

class FriendScreen extends StatefulWidget {
  final loginUser user;
  const FriendScreen({
    required this.user,
    Key? key}) : super(key: key);

  @override
  State<FriendScreen> createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendScreen> {
  TextEditingController emailTextConroller = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          CustomAppBarYellow(titleText: '친구 추가'),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: [
                SizedBox(height: 24,),
                TextFormField(
                  controller: emailTextConroller,
                  decoration:  InputDecoration(
                    hintText: '친구의 이메일 id를 입력하세요.',
                    fillColor: Colors.grey[200],
                    filled: true,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40,),
                CustomButton(text: '추가', onPressed: add_friend)
              ],
            ),
          )
        ],
      )),
    );
  }

  void add_friend() async {
    DocumentSnapshot Doc;
    String emailChecker = '';
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    Doc = await firestore.collection('users').doc(widget.user.email).get();

    try {
      CustomCircular(context, '중복 확인 중...');
      await firestore
          .collection('users')
          .where('email', isEqualTo: emailTextConroller.text)
          .get()
          .then((QuerySnapshot data) {
        data.docs.forEach((element) {
          emailChecker = element['email'];
        });
      });

      Navigator.pop(context);
      if (emailChecker == emailTextConroller.text && emailTextConroller.text.length != 0) {
        print('test1');

        //여기에 추가
        final List<String> recordDate = List<String>.from(Doc['friend_list'] ?? []);
        dynamic recordDateToSet;
        recordDate.add(emailTextConroller.text);
        recordDateToSet = recordDate.toSet().toList();
        firestore.collection('users').doc(widget.user.email).update({
          'friend_list' : recordDateToSet
        });
        firestore.collection('users').doc(emailTextConroller.text).update({

        });
        DialogShow(context, '친구 추가가 완료되었습니다.');
      } else {
        DialogShow(context, '해당 유저가 존재하지 않습니다.');
      }
    } catch (e) {
      Navigator.pop(context);
      DialogShow(context, '에러발생');
      print(e);
    }
  }
}
