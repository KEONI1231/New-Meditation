import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFieldSignUp extends StatelessWidget {
  final String label;

  //'비밀번호 입력' 필드와 '비밀번호 확인'필드의 값을 비교하여 일치한지 아닌지를 판단하기 위한변수
  //다른 텍스트필드엔 필요한 변수가 아니기 때문에 null값이 허용되도록 ?를 사용함.
  final TextEditingController? passwordChecker;
  final TextEditingController Controller;

  //각 텍스트 필드들의 조건을 확인하기 위한 변수. 이 변수를 이용해서 validator에 의한 에러메시지를 출력해주는 판단 지표역할.
  final TextInputType textInputType;
  final bool? donggukCheck;
  const CustomTextFieldSignUp({
    this.donggukCheck,
    this.passwordChecker,
    required this.textInputType,
    required this.Controller,
    required this.label,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _decoration = InputDecoration(
      fillColor: Colors.grey[200],
      filled: true,
      //텍스트 필드를 통일화 하기위한 데코레이션,
      //text 필드 데코레이션 정의 변수.
      labelText: label,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
    );

    return TextFormField(
      controller: Controller,
      validator: (String? val) {
        //이곳에서 조건에 따른 에러메시지를 출력,
        //null이 리턴된다면 에러가 없는 상태.
        if (val == null || val.isEmpty) {
          return '해당 필드는 필수항목입니다.';
        }
        if (textInputType == TextInputType.emailAddress) {
          /*signup_screen.dart에서 CustomTextField를 사용할때 매게변수로 넘겨준 값들중
            TextInputType이 있는데 이 타입이 emailAddress이면 아래의 emailValid라고 하는
            bool값 변수를 활용하여 이메일 형식의 문자열인지 검사함.
          */
          bool emailValid = RegExp(
                  //아랫줄 정규식은 이메일 형식을 조사하기 위한 값인데 걍 구글에서 긁어온거임. 복잡해서 나도 굳이 읽어보진않음
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(val); //이메일 형식이 맞으면 true를 반환.
          if (emailValid == false) {
            return '잘못된 이메일 형식입니다.';
          } else {
            return null;
          }
        }
        if (textInputType == TextInputType.visiblePassword) {
          bool regExp = RegExp(
              r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$"
          )
              .hasMatch(val);
          if (regExp == false) {
            return '특수문자, 대소문자, 숫자 포함 8자 이상 15자 이내로 입력하세요.';
          } else {
            return null;
          }
        }

        /* 텍스트인풋 타입이 visiblePassword일때 signup_screen.dart에서
          passwordChecker: _pwTextController.text, 이 문장을 사용하였음.
          이 파일 8번째 줄에 final String? passwordChecker; 라는 문장이 있는데
          이때 사용하기 위해서 null값이 가능한 변수로 선언해둔거임.
          그래서 password 입력값과 password 확인 값이 다르면 일치하지 않는다는 오류를 출력.
         */
        if (label == 'password 확인') {
          if (Controller.text != passwordChecker?.text) {
            return '비밀번호가 일치하지 않습니다.';
          }
        }

        if (textInputType == TextInputType.phone) {
          bool phoneNumberValid =
              //전화번호 형식을 조사하기 위한 정규식임.
              RegExp(r'^010-?([0-9]{4})-?([0-9]{4})$').hasMatch(val);
          if (phoneNumberValid == false) {
            return '전화번호 형식이 잘못되었습니다';
          }
        }
        return null;
      },
      obscureText: //인풋타입이 패스워드이면 obscureText값을 true아니면 false를 반환해서
          //입력한 값들이 보이게할거냐 말거냐를 결정.
          textInputType == TextInputType.visiblePassword ? true : false,
      decoration: _decoration,
      keyboardType: textInputType,

    );
  }
}
