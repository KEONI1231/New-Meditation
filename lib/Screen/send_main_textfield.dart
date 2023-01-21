import 'package:flutter/material.dart';


class CustomSendMailTextField extends StatelessWidget {
  final bool isMailTtile;
  final TextEditingController controller;
  const CustomSendMailTextField({
    required this.controller,
    required this.isMailTtile,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _decoration = InputDecoration(
      hintText: isMailTtile == true ? '이메일 제목' : '[ 이메일 내용 ]\n\n: ID를 기재하시면 더 빠르게 \n 문의를 처리해 드릴수 있어요!!',
      fillColor: Colors.grey[200],
      filled: true,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
    );

    return Container(
      height: isMailTtile == true ? 75 : 250,
      child: TextFormField(
        controller: controller,
        expands: true,

        keyboardType: TextInputType.multiline,
        maxLines: null,
        validator: (String? val) {
          if (val == null || val.isEmpty) {
            return '해당 필드는 필수항복입니다.';
          }

          return null;
        },
        decoration: _decoration,
      ),
    );
  }
}
