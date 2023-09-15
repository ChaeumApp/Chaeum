import 'dart:ffi';

import 'package:flutter/material.dart';
import '../user/mypage.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();

  bool emailCheck = false;
  bool passwordCheck = false;
  bool samepasswordCheck = false;

  String emailMessage = '이메일 형식으로 입력해주세요';
  String passwordMessage = '비밀번호는 특수문자, 숫자, 영어가 필수로 1개씩 있어야 합니다.';
  String samepasswordMessage = '비밀번호와 다릅니다.';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '회원가입',
            style: TextStyle(
                fontSize: 25, color: Colors.black, fontWeight: FontWeight.w700),
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
        // email, password 입력하는 부분을 제외한 화면을 탭하면, 키보드 사라지게 GestureDetector 사용
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                    child: Theme(
                  data: ThemeData(
                      primaryColor: Colors.grey,
                      inputDecorationTheme: InputDecorationTheme(
                          labelStyle:
                              TextStyle(color: Colors.grey, fontSize: 16.0))),
                  child: Container(
                      padding: EdgeInsets.all(40.0),
                      child: Builder(builder: (context) {
                        return SizedBox(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 50,
                                child: TextField(
                                  controller: controller,
                                  autofocus: true,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 16.0, horizontal: 10.0),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1.5,
                                              color: Color(0xffA1CBA1))),
                                      prefixIconColor: Color(0xffA1CBA1),
                                      prefixIcon: Icon(
                                        Icons.alternate_email_rounded,
                                      ),
                                      suffixIcon:
                                          Icon(Icons.priority_high_rounded),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide()),
                                      labelText: '이메일',
                                      focusColor: Color(0xffA1CBA1)),
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              ),
                              SizedBox(
                                height: 50,
                                child: TextField(
                                  controller: controller2,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 16.0, horizontal: 10.0),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1.5,
                                              color: Color(0xffA1CBA1))),
                                      prefixIconColor: Color(0xffA1CBA1),
                                      prefixIcon: Icon(Icons.vpn_key_outlined),
                                      border: OutlineInputBorder(),
                                      labelText: '비밀번호',
                                      focusColor: Color(0xffA1CBA1)),
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: true, // 비밀번호 안보이도록 하는 것
                                ),
                              ),
                              SizedBox(
                                height: 50,
                                child: TextField(
                                  controller: controller3,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 16.0, horizontal: 10.0),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1.5,
                                              color: Color(0xffA1CBA1))),
                                      prefixIconColor: Color(0xffA1CBA1),
                                      prefixIcon: Icon(Icons.key),
                                      border: OutlineInputBorder(),
                                      labelText: '비밀번호 확인',
                                      focusColor: Color(0xffA1CBA1)),
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: true, // 비밀번호 안보이도록 하는 것
                                ),
                              ),
                              SizedBox(
                                height: 60,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                  child: ButtonTheme(
                                      child: TextButton(
                                          onPressed: () async {
                                            if (controller.text ==
                                                    'mei@hello.com' &&
                                                controller2.text == '1234') {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          MyPage()));
                                            } else if (controller.text ==
                                                    'mei@hello.com' &&
                                                controller2.text != '1234') {
                                              showSnackBar(context,
                                                  Text('Wrong password'));
                                            } else if (controller.text !=
                                                    'mei@hello.com' &&
                                                controller2.text == '1234') {
                                              showSnackBar(
                                                  context, Text('Wrong email'));
                                            } else {
                                              showSnackBar(
                                                  context,
                                                  Text(
                                                      'Check your info again'));
                                            }
                                          },
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      Color(0xffA1CBA1))),
                                          child: SizedBox(
                                            height: 40,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '이메일 회원가입',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ))),
                                ),
                              ),
                              SizedBox(
                                height: 60,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                  child: ButtonTheme(
                                      child: TextButton(
                                          onPressed: () {},
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      Color(0xffFEE500))),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/images/login/kakaoLogo.png',
                                                width: 40,
                                              ),
                                              Center(
                                                child: Text(
                                                  '카카오로 시작하기',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                            ],
                                          ))),
                                ),
                              ),
                              SizedBox(
                                height: 60,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                  child: ButtonTheme(
                                      child: TextButton(
                                          onPressed: () {},
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      Color(0xff03C75A))),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/images/login/naverLogo.png',
                                                width: 40,
                                              ),
                                              Text(
                                                '네이버로 시작하기',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ],
                                          ))),
                                ),
                              ),
                            ],
                          ),
                        );
                      })),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void showSnackBar(BuildContext context, Text text) {
  final snackBar = SnackBar(content: text, backgroundColor: Color(0xffA1CBA1));

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

// class NextPage extends StatelessWidget {
//   const NextPage({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
