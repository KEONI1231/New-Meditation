import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Component/account_textfield_signup.dart';
import '../Component/alert_dialog.dart';
import '../Component/circular_progress_indicator_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Component/custom_button.dart';
import '../Component/custom_button_signup.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _pwTextController = TextEditingController();
  final TextEditingController _repwTextController = TextEditingController();
  final TextEditingController _studentNumberController =
  TextEditingController();
  final TextEditingController _nameTextController = TextEditingController();
  bool donggukCheck = false;
  final String date = DateTime.now().year.toString() +
      '년 ' +
      DateTime.now().month.toString().padLeft(2, '0') +
      '월 ' +
      DateTime.now().day.toString().padLeft(2, '0') +
      '일';
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  CustomTextFieldSignUp(
                      textInputType: TextInputType.emailAddress,
                      Controller: _emailTextController,
                      label: "이메일을 입력해 주세요."),
                  CustomButtonSignUp(text: '이메일 중복 확인', onPressed: check_email),
                  SizedBox(
                    height: 32,
                  ),
                  CustomTextFieldSignUp(
                      textInputType: TextInputType.visiblePassword,
                      Controller: _pwTextController,
                      label: "비밀번호를 입력해주세요."),
                  SizedBox(
                    height: 8,
                  ),
                  CustomTextFieldSignUp(
                      textInputType: TextInputType.visiblePassword,
                      Controller: _repwTextController,
                      label: "비밀번호 확인"),
                  SizedBox(
                    height: 32,
                  ),
                /*  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CustomTextFieldSignUp(
                          textInputType: TextInputType.number,
                          Controller: _studentNumberController,
                          label: "학번을 입력해주세요.(동국대학교 학생 한정)"),
                      Switch(
                        value: donggukCheck,
                        onChanged: (value)  {
                          setState(() {
                            donggukCheck = value;
                          });
                        },
                      ),
                    ],
                  ),*/

                  SizedBox(
                    height: 8,
                  ),
                  CustomTextFieldSignUp(
                      textInputType: TextInputType.text,
                      Controller: _nameTextController,
                      label: "이름 (실명)"),
                  SizedBox(
                    height: 64,
                  ),
                  CustomButton(text: '회원가입', onPressed: try_singup)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  int _duplicationIdCheck = 0;
  int _duplbtnidchecker = 0;
//  int _duplicationNickCheck = 1;
//  int _duplbtnnickchecker = 0;

  void check_email() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentSnapshot userData;
    try {
      CustomCircular(context, '중복 확인 중...');
      userData =
      await firestore.collection('users').doc(_emailTextController.text).get();
      if (_emailTextController.text == userData['email']) {
        Navigator.pop(context);
        DialogShow(context, '중복된 이메일이 존재합니다.');
      }
    } catch (e) {
      Navigator.pop(context);
      DialogShow(context, '사용 가능한 ID입니다.');
      _duplicationIdCheck = 1;
      _duplbtnidchecker = 1;
    }
  }
/*

  void check_stnumber() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    String student_number = '';
    try {
      CustomCircular(context, '중복 확인 중...');
      await firestore
          .collection('users')
          .where('student_number', isEqualTo: _studentNumberController.text)
          .get()
          .then((QuerySnapshot data) {
        data.docs.forEach((element) {
          student_number = element['student_number'];
        });
      });
      Navigator.pop(context);
      if (student_number == _studentNumberController.text) {
        DialogShow(context, '중복된 학번이 존재합니다.');
        _duplicationNickCheck = 0;
        _duplbtnnickchecker = 0;
      } else {
        DialogShow(context, '사용가능한 학번입니다.');
        _duplicationNickCheck = 1;
        _duplbtnnickchecker = 1;
      }
    } catch (e) {
      Navigator.pop(context);
      DialogShow(context, '에러발생');
    }
  }
*/

  /* DocumentSnapshot userData;
    try {
      CustomCircular(context, '중복 확인 중...');
      userData =
          await firestore.collection('users').doc(_idTextController.text).get();
      if (_idTextController.text == userData['id']) {
        Navigator.pop(context);
        DialogShow(context, '중복된 아이디가 존재합니다.');
      }
    } catch (e) {
      Navigator.pop(context);
      DialogShow(context, '사용 가능한 ID입니다.');
      _duplicationIdCheck = 1;
      _duplbtnidchecker = 1;
    }*/
  void try_singup() {
    if (_duplicationIdCheck == 1 &&
        _duplbtnidchecker == 1 
   //     _duplicationNickCheck == 1 &&
    //    _duplbtnnickchecker == 1
        //
        ) {
      createAccount();
    } else {
      DialogShow(context, '중복체크를 진행해주세요.');
    }
  }

  void createAccount() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    if (formKey.currentState == null) {
      return;
    }
    if (formKey.currentState!.validate()) {
      int weekOfMonth = weekOfMonthForStandard(DateTime.now());
      //계정 생성버튼을 눌렀을때 이상이 없으면 파이어베이스 클라우드스토어에 유저 정보를 추가한다.
      CustomCircular(context, '회원가입 진행중...');
      await firestore.collection('users').doc(_emailTextController.text).set({
        'name': _nameTextController.text.replaceAll(RegExp('\\s'), ""),
        'email': _emailTextController.text.replaceAll(RegExp('\\s'), ""),
     //   'student_number': _studentNumberController.text.replaceAll(RegExp('\\s'), ""),
        'is_admin': 0,
        'pw': _pwTextController.text.replaceAll(RegExp('\\s'), ""),
        'created_time': DateTime.now().toString(),
        'week_hour': 0,
        'week_minute': 0,
        'week_second': 0,
        'month_hour': 0,
        'month_minute': 0,
        'month_second': 0,
        'today_hour' : 0,
        'today_minute' : 0,
        'today_second' : 0,
        'this_week' : weekOfMonth,
        'this_today' : DateTime.now().day,
        'this_month' : DateTime.now().month,
        'today_medi_ok' : 0,
        'total_medi_ok' : 0,
        'last_post_time' : '',
        'record_list' : ['default'],
        'friend_list' : ['']
      });


      Navigator.pop(context);
      Navigator.pop(context);
      DialogShow(context, '회원가입이 완료되었습니다.');
    }
  }
  int weekOfMonthForStandard(DateTime date) {
    // 월 주차.
    late int _weekOfMonth;

    // 선택한 월의 첫번째 날짜.
    final _firstDay = DateTime(date.year, date.month, 1);

    // 선택한 월의 마지막 날짜.
    final _lastDay = DateTime(date.year, date.month + 1, 0);

    // 첫번째 날짜가 목요일보다 작은지 판단.
    final _isFirstDayBeforeThursday = _firstDay.weekday <= DateTime.thursday;

    // 선택한 날짜와 첫번째 날짜가 같은 주에 위치하는지 판단.
    if (isSameWeek(date, _firstDay)) {
      // 첫번째 날짜가 목요일보다 작은지 판단.
      if (_isFirstDayBeforeThursday) {
        // 1주차.
        _weekOfMonth = 1;
      }

      // 저번달의 마지막 날짜의 주차와 동일.
      else {
        final _lastDayOfPreviousMonth = DateTime(date.year, date.month, 0);

        // n주차.
        _weekOfMonth = weekOfMonthForStandard(_lastDayOfPreviousMonth);
      }
    } else {
      // 선택한 날짜와 마지막 날짜가 같은 주에 위치하는지 판단.
      if (isSameWeek(date, _lastDay)) {
        // 마지막 날짜가 목요일보다 큰지 판단.
        final _isLastDayBeforeThursday = _lastDay.weekday >= DateTime.thursday;
        if (_isLastDayBeforeThursday) {
          // 주차를 단순 계산 후 첫번째 날짜의 위치에 따라서 0/-1 결합.
          // n주차.
          _weekOfMonth =
              weekOfMonthForSimple(date) + (_isFirstDayBeforeThursday ? 0 : -1);
        }
        // 다음달 첫번째 날짜의 주차와 동일.
        else {
          // 1주차.
          _weekOfMonth = 1;
        }
      }

      // 첫번째주와 마지막주가 아닌 날짜들.
      else {
        // 주차를 단순 계산 후 첫번째 날짜의 위치에 따라서 0/-1 결합.
        // n주차.
        _weekOfMonth =
            weekOfMonthForSimple(date) + (_isFirstDayBeforeThursday ? 0 : -1);
      }
    }

    return _weekOfMonth;
  }

  bool isSameWeek(DateTime dateTime1, DateTime dateTime2) {
    final int _dateTime1WeekOfMonth = weekOfMonthForSimple(dateTime1);
    final int _dateTime2WeekOfMonth = weekOfMonthForSimple(dateTime2);
    return _dateTime1WeekOfMonth == _dateTime2WeekOfMonth;
  }

  int weekOfMonthForSimple(DateTime date) {
    // 월의 첫번째 날짜.
    DateTime _firstDay = DateTime(date.year, date.month, 1);

    // 월중에 첫번째 월요일인 날짜.
    DateTime _firstMonday = _firstDay
        .add(Duration(days: (DateTime.monday + 7 - _firstDay.weekday) % 7));

    // 첫번째 날짜와 첫번째 월요일인 날짜가 동일한지 판단.
    // 동일할 경우: 1, 동일하지 않은 경우: 2 를 마지막에 더한다.
    final bool isFirstDayMonday = _firstDay == _firstMonday;

    final _different = calculateDaysBetween(from: _firstMonday, to: date);

    // 주차 계산.
    int _weekOfMonth = (_different / 7 + (isFirstDayMonday ? 1 : 2)).toInt();
    return _weekOfMonth;
  }

  int calculateDaysBetween({required DateTime from, required DateTime to}) {
    return (to.difference(from).inHours / 24).round();
  }
}