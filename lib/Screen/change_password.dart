import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Component/account_textfield.dart';
import '../Component/alert_dialog.dart';
import '../Component/circular_progress_indicator_dialog.dart';
import '../Constant/color.dart';
import '../Constant/data.dart';
import '../Constant/user.dart';


class ChangePassword extends StatefulWidget {
  final loginUser user;
  const ChangePassword({
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController _currentPwController = TextEditingController();
  final TextEditingController _newPwController = TextEditingController();
  final TextEditingController _renewPwController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final ts = TextStyle(color: PRIMARY_COLOR);
    return Scaffold(
      backgroundColor: BRIGHT_COLOR,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        textInputType: TextInputType.visiblePassword,
                        Controller: _currentPwController,
                        label: '기존 비밀번호',
                      ),
                      const SizedBox(height: 40),

                      const SizedBox(height: 8),
                      CustomTextField(
                        label: '새 비밀번호',
                        Controller: _newPwController,
                        textInputType: TextInputType.visiblePassword,
                        //passwordChecker: _pwTextController.text,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: '새 비밀번호 확인',
                        Controller: _renewPwController,
                        textInputType: TextInputType.visiblePassword,
                        passwordChecker: _newPwController,
                      ),
                      const SizedBox(height: 24),
                      PwChangeBtn(onChangeBtn: onChangeBtn),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  void onChangeBtn() async{
    if(_currentPwController.text != widget.user.pw) {
      Navigator.pop(context);
      DialogShow(context, '현재 비밀번호가 일치하지 않습니다.');
    } else {
      if (formKey.currentState == null) {
        return;
      }
      if (formKey.currentState!.validate()) {
        //계정 생성버튼을 눌렀을때 이상이 없으면 파이어베이스 클라우드스토어에 유저 정보를 추가한다.
        try {
          CustomCircular(context, '비밀번호 변경중...');
          await FirebaseFirestore.instance
              .collection('users')
              .doc(widget.user.email)
              .update({'pw': _newPwController.text});

          widget.user.pw = _newPwController.text;
          for(int i = 0; i < 2; i++) {
            Navigator.pop(context);
          }
          SharedPreferences sp = await SharedPreferences.getInstance();
          try {
            bool login = sp.getBool(loginState)!;
            if(login == true) {
              sp.setString(userPassword, _newPwController.text)!;
            }

          }catch(e) {

          }
          DialogShow(context, '비밀번호 변경이 완료되었습니다.');
        }
        catch(e) {
          Navigator.pop(context);
          DialogShow(context, '비밀번호 변경이 완료되었습니다.');
        }
      }
    }
  }
}

class PwChangeBtn extends StatelessWidget {
  final VoidCallback onChangeBtn;
  const PwChangeBtn({
    required this.onChangeBtn,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: onChangeBtn,
        child: Text('비밀번호 변경'),
        style: ElevatedButton.styleFrom(
            primary: PRIMARY_COLOR,
            minimumSize: Size(150, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            )),
      ),
    );
  }
}

