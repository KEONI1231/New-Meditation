import 'package:flutter/material.dart';
import 'package:medi/Component/custom_button.dart';
import 'package:medi/Constant/user.dart';
import 'package:medi/Screen/user_delete_screen.dart';

import '../Component/account_textfield.dart';
import '../Component/alert_dialog.dart';
import '../Constant/color.dart';

class DeleteAccount extends StatefulWidget {
  loginUser user;

  DeleteAccount({required this.user, Key? key}) : super(key: key);

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  final TextEditingController _idTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BRIGHT_COLOR,
      body: SafeArea(

        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBar(title: Text('계정 확인'),
              backgroundColor: PRIMARY_COLOR,
              centerTitle: true,),
              Padding(
                padding: const EdgeInsets.only(left: 24.0,right: 24),
                child: Center(
                  child: Column(

                    children: [
                      const SizedBox(height: 200),
                      CustomTextField(
                        textInputType: TextInputType.text,
                        Controller: _idTextController,
                        label: '이메일을 입력해 주세요.',
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        textInputType: TextInputType.visiblePassword,
                        Controller: _passwordTextController,
                        label: '비밀번호를 입력해 주세요.',
                      ),
                      const SizedBox(height: 24),
                      CustomButton(
                        text: '계정 확인',
                        onPressed: DeleteAccountBtn,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void DeleteAccountBtn() {
    try {
      if (widget.user.email == _idTextController.text &&
          widget.user.pw == _passwordTextController.text) {
        Navigator.pop(context);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return UserDelete(user: widget.user);
        }));
      } else {
        Navigator.pop(context);
        DialogShow(context, '회원정보가 잘못되었습니다.');
      }
    } catch (e) {
      Navigator.pop(context);
      DialogShow(context, '시스템 에러');
    }
  }
}
