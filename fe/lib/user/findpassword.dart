import 'package:fe/user/pageapi.dart';
import 'package:flutter/material.dart';

class FindPassword extends StatefulWidget {
  const FindPassword({super.key});

  @override
  State<FindPassword> createState() => _FindPasswordState();
}

class _FindPasswordState extends State<FindPassword> {
  @override
  final PageApi pageapi = PageApi();
  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();

  bool emailCheck = false;
  bool yearcheck = false;
  bool monthcheck = false;
  bool daycheck = false;
  String? birthday;

  String? emailError;

  String emailMessage = '이메일 형식으로 입력해주세요';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '비밀번호 찾기',
          style: TextStyle(
              fontSize: 23, color: Colors.black, fontWeight: FontWeight.w600),
        ),
        elevation: 0.0,
        backgroundColor: Colors.grey[50],
        centerTitle: true,
        toolbarHeight: 65,
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.keyboard_backspace_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '이메일',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 100,
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 10),
                child: TextField(
                  cursorColor: Color(0xffA1CBA1),
                  onChanged: (value) {
                    if (!RegExp(
                            r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$")
                        .hasMatch(value)) {
                      setState(() {
                        emailError = emailMessage;
                        emailCheck = false;
                      });
                    } else {
                      setState(() {
                        emailError = null; // 에러 없음
                        emailCheck = true;
                      });
                    }
                  },
                  controller: controller,
                  autofocus: true,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 17.0, horizontal: 10.0),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1.5, color: Color(0xffA1CBA1))),
                    prefixIconColor: Color(0xffA1CBA1),
                    prefixIcon: Icon(
                      Icons.alternate_email_rounded,
                    ),
                    suffixIcon: Icon(
                      RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$")
                              .hasMatch(controller.text)
                          ? Icons.check_circle_rounded
                          : Icons.priority_high_rounded,
                      color:
                          RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$")
                                  .hasMatch(controller.text)
                              ? Color(0xffA1CBA1)
                              : Colors.red,
                    ),
                    border: OutlineInputBorder(borderSide: BorderSide()),
                    errorText: emailError,
                    errorStyle: TextStyle(height: 1),
                    focusColor: Color(0xffA1CBA1),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
            ),
            Text(
              '생년월일',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 40),
              child: Row(
                textBaseline: TextBaseline.ideographic,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  Flexible(
                      flex: 3,
                      child: TextField(
                        maxLength: 4,
                        onChanged: (value) {
                          if (!RegExp(r"^(19[0-9][0-9]|20[01][0-9]|202[0-3])$")
                              .hasMatch(value)) {
                            setState(() {
                              yearcheck = false;
                              print(yearcheck);
                            });
                          } else {
                            setState(() {
                              yearcheck = true;
                              print(yearcheck);
                            });
                          }
                        },
                        controller: controller2,
                        cursorColor: Color(0xffA1CBA1),
                        decoration: InputDecoration(
                            enabledBorder: yearcheck
                                ? UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5, color: Colors.black),
                                  )
                                : OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.red)),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1.5,
                                  color: yearcheck
                                      ? Color(0xffA1CBA1)
                                      : Colors.red),
                            ),
                            isDense: true,
                            counterText: '',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 10.0),
                            focusColor: Color(0xffA1CBA1)),
                      )),
                  Flexible(
                      child: Text(' 년 ',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                          ))),
                  Flexible(
                      flex: 2,
                      child: TextField(
                        maxLength: 2,
                        onChanged: (value) {
                          if (!RegExp(r"^(0?[1-9]|1[0-2])$").hasMatch(value)) {
                            setState(() {
                              monthcheck = false;
                              print(monthcheck);
                            });
                          } else {
                            setState(() {
                              monthcheck = true;
                              print(monthcheck);
                            });
                          }
                        },
                        controller: controller3,
                        cursorColor: Color(0xffA1CBA1),
                        decoration: InputDecoration(
                            enabledBorder: monthcheck
                                ? UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5, color: Colors.black),
                                  )
                                : OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.red)),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1.5,
                                  color: monthcheck
                                      ? Color(0xffA1CBA1)
                                      : Colors.red),
                            ),
                            isDense: true,
                            counterText: '',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 10.0),
                            focusColor: Color(0xffA1CBA1)),
                      )),
                  Flexible(
                      child: Text(' 월 ',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                          ))),
                  Flexible(
                      flex: 2,
                      child: TextField(
                        onChanged: (value) {
                          if (!RegExp(r"^(0?[1-9]|[12][0-9]|3[01])$")
                              .hasMatch(value)) {
                            setState(() {
                              daycheck = false;
                            });
                          } else {
                            setState(() {
                              daycheck = true;
                            });
                          }
                        },
                        maxLength: 2,
                        cursorColor: Color(0xffA1CBA1),
                        controller: controller4,
                        decoration: InputDecoration(
                            enabledBorder: daycheck
                                ? UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5, color: Colors.black),
                                  )
                                : OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.red)),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1.5,
                                  color: daycheck
                                      ? Color(0xffA1CBA1)
                                      : Colors.red),
                            ),
                            isDense: true,
                            counterText: '',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 10.0),
                            focusColor: Color(0xffA1CBA1)),
                      )),
                  Flexible(
                      child: Text(' 일',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                          ))),
                ],
              ),
            ),
            TextButton(
                onPressed: emailCheck && yearcheck && daycheck && monthcheck
                    ? () async {
                        if (controller3.text.length == 1) {
                          controller3.text = '0${controller3.text}';
                        }
                        if (controller4.text.length == 1) {
                          controller4.text = '0${controller4.text}';
                        }
                        final birthday =
                            '${controller2.text}-${controller3.text}-${controller4.text}';
                        print(birthday);
                        final findpwdres = await pageapi.findPassword(
                            controller.text, birthday);
                      }
                    : null,
                style: ButtonStyle(
                    backgroundColor:
                        emailCheck && yearcheck && daycheck && monthcheck
                            ? MaterialStatePropertyAll(Color(0xffA1CBA1))
                            : MaterialStatePropertyAll(Colors.grey)),
                child: SizedBox(
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '제출하기',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.white),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
