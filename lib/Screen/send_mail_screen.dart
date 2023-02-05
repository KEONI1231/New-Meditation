import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:medi/Component/custom_appbar_yellow.dart';
import 'package:medi/Constant/data.dart';
import 'package:medi/Screen/send_main_textfield.dart';

import '../Component/alert_dialog.dart';
import '../Component/custom_button.dart';
import '../Constant/color.dart';
import '../Constant/user.dart';

class SendMail extends StatefulWidget {
  final loginUser user;
  final BoxDecoration ContainerDecoration;

  const SendMail({
    required this.user,
    required this.ContainerDecoration,
    Key? key,
  }) : super(key: key);

  @override
  State<SendMail> createState() => _SendMailState();
}

class _SendMailState extends State<SendMail> {
  final TextEditingController _mailTitleTextController =
      TextEditingController();
  final TextEditingController _mailContentTextController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ts =
        TextStyle(color: TEXT_COLOR, fontSize: 16, fontWeight: FontWeight.w700);
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBarYellow(titleText: '문의하기'),
            Column(
              children: [
                const SizedBox(height: 24),
                Container(
                  width: MediaQuery.of(context).size.width / 1.1,
                  height: 100,
                  decoration: widget.ContainerDecoration,
                  child: Center(
                    child: Text(
                      '받는 사람 : kh991231@naver.com',
                      style: ts,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  width: MediaQuery.of(context).size.width / 1.1,
                  height: 100,
                  decoration: widget.ContainerDecoration,
                  child: Center(
                    child: Text(
                      '보내는 사람 : ${widget.user.email}',
                      style: ts,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("제목", style: ts.copyWith(fontSize: 24)),
                      const SizedBox(height: 24),
                      CustomSendMailTextField(
                          controller: _mailTitleTextController,
                          isMailTtile: true),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Text("내용", style: ts.copyWith(fontSize: 24)),
                          const SizedBox(
                            width: 8,
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      CustomSendMailTextField(
                          controller: _mailContentTextController,
                          isMailTtile: false),
                    ],
                  ),
                ),
                CustomButton(text: '완료', onPressed: onSendEmailBtn),
                SizedBox(height: 48)
              ],
            ),
          ],
        ),
      )),
    );
  }

  Future<String> _getEmailBody() async {
    String body = "";

    body += "====================================\n\n";
    body += "아래 내용을 함께 보내주시면 큰 도움이 됩니다 😄\n\n";

    body += "Email : " + widget.user.email + "\n";
    body += "App Verion : " + version + "\n\n";

    body += "카카오톡 오픈 채팅으로 문의 주시면 \n더욱 원활하게 도와드릴수 있어요!";
    body += "\n\n카카카오 오픈채팅 : ???\n\n";

    body += "====================================\n\n";
    body += "문의 내용 : " + _mailContentTextController.text;

    return body;
  }

  void onSendEmailBtn() async {
    print(_mailContentTextController.text);
    String body = await _getEmailBody();
    final Email email = Email(
      body: body,
      subject: '[${_mailTitleTextController.text}]',
      recipients: ['forstudyhw2@gmail.com'],
      cc: [],
      bcc: [],
      attachmentPaths: [],
      isHTML: false,
    );
    try {
      await FlutterEmailSender.send(email);
    } catch (error) {
      DialogShow(context,
          "기본 메일 앱을 사용할 수 없기 때문에 앱에서 바로 문의를 전송하기 어려운 상황입니다.\n\n아래 이메일로 연락주시면 친절하게 답변해드릴게요 :)\n\nonionfamily.official@gmail.com");
      print(error);
    }
  }
}
