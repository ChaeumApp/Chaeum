import 'package:fe/user/addinfo.dart';
import 'package:flutter/material.dart';
import '../user/mypage.dart';
import 'pageapi.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key, this.storage});

  final storage;
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();

  bool emailCheck = false;
  bool emailCodeCheck = false;
  bool passwordCheck = false;
  bool samepasswordCheck = false;
  bool emailCheckButton = false;

  String? emailError;
  String? passwordError;
  String? samepasswordError;
  String emailMessage = '이메일 형식으로 입력해주세요';
  String passwordMessage = '특수문자, 숫자, 영어가 필수로 1개씩 있어야 합니다.';
  String samepasswordMessage = '비밀번호와 다릅니다.';

  final PageApi pageapi = PageApi();

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
                                height: 83,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
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
                                        enabled:
                                            emailCheckButton ? false : true,
                                        autofocus: true,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 17.0, horizontal: 10.0),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1.5,
                                                  color: Color(0xffA1CBA1))),
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
                                                        .hasMatch(
                                                            controller.text)
                                                    ? Color(0xffA1CBA1)
                                                    : Colors.red,
                                          ),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide()),
                                          labelText: '이메일',
                                          errorText: emailError,
                                          errorStyle: TextStyle(height: 1),
                                          focusColor: Color(0xffA1CBA1),
                                        ),
                                        keyboardType:
                                            TextInputType.emailAddress,
                                      ),
                                    ),
                                    SizedBox(
                                        height: 53,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 0, 0),
                                          child: TextButton(
                                            style: ButtonStyle(
                                              minimumSize:
                                                  MaterialStateProperty.all(
                                                      Size(75, 0)),
                                              backgroundColor: emailCheck
                                                  ? MaterialStateProperty.all<
                                                      Color>(Color(0xffA1CBA1))
                                                  : MaterialStateProperty.all<
                                                      Color>(Colors.grey),
                                            ),
                                            onPressed: emailCheck
                                                ? () async {
                                                    String? dupcheck =
                                                        await pageapi
                                                            .duplicatecheck(
                                                                controller.text
                                                                    .toString());
                                                    if (dupcheck.toString() ==
                                                        'success') {
                                                      String? emailsend =
                                                          await pageapi.sendEmail(
                                                              controller.text
                                                                  .toString());
                                                      if (emailsend
                                                              .toString() ==
                                                          'success') {
                                                        showDialog(
                                                            context: context,
                                                            builder:
                                                                ((context) {
                                                              return AlertDialog(
                                                                actions: <Widget>[
                                                                  TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      },
                                                                      child: Text(
                                                                          '닫기'))
                                                                ],
                                                                content:
                                                                    SingleChildScrollView(
                                                                  child: Text(
                                                                      '입력하신 이메일을 확인하세요.'),
                                                                ),
                                                              );
                                                            }));
                                                        setState(() {
                                                          emailCheckButton =
                                                              true;
                                                        });
                                                      }
                                                    } else {
                                                      showDialog(
                                                          context: context,
                                                          builder: ((context) {
                                                            return AlertDialog(
                                                              actions: <Widget>[
                                                                TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                    child: Text(
                                                                        '닫기'))
                                                              ],
                                                              content:
                                                                  SingleChildScrollView(
                                                                child: Text(
                                                                    '이미 있는 ID입니다.'),
                                                              ),
                                                            );
                                                          }));
                                                    }
                                                  }
                                                : null,
                                            child: Text(
                                              '인증 하기',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                              emailCheckButton
                                  ? SizedBox(
                                      height: 83,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: TextField(
                                              controller: controller4,
                                              cursorColor: Color(0xffA1CBA1),
                                              enabled:
                                                  emailCodeCheck ? false : true,
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 17.0,
                                                        horizontal: 10.0),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 1.5,
                                                            color: Color(
                                                                0xffA1CBA1))),
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide()),
                                                labelText: '인증 번호',
                                                focusColor: Color(0xffA1CBA1),
                                              ),
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                            ),
                                          ),
                                          SizedBox(
                                              height: 53,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 0, 0, 0),
                                                child: TextButton(
                                                  style: ButtonStyle(
                                                      minimumSize:
                                                          MaterialStateProperty
                                                              .all(Size(75, 0)),
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all<Color>(Color(
                                                                  0xffA1CBA1))),
                                                  onPressed: emailCodeCheck
                                                      ? null
                                                      : () async {
                                                          print(
                                                              controller4.text);
                                                          print(controller4.text
                                                              .runtimeType);

                                                          String? checkcode =
                                                              await pageapi.checkcode(
                                                                  controller
                                                                      .text
                                                                      .toString(),
                                                                  int.parse(
                                                                      controller4
                                                                          .text));
                                                          print(checkcode);
                                                          if (checkcode
                                                                  .toString() ==
                                                              "success") {
                                                            setState(() {
                                                              emailCodeCheck =
                                                                  true;
                                                            });
                                                          }
                                                        },
                                                  child: emailCodeCheck
                                                      ? Icon(
                                                          Icons.check,
                                                          color: Colors.black,
                                                        )
                                                      : Text(
                                                          '인증 확인',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                ),
                                              )),
                                        ],
                                      ),
                                    )
                                  : SizedBox(),
                              SizedBox(
                                height: 83,
                                child: TextField(
                                  cursorColor: Color(0xffA1CBA1),

                                  onChanged: (value) {
                                    if (!RegExp(
                                            r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$")
                                        .hasMatch(value)) {
                                      setState(() {
                                        passwordError = passwordMessage;
                                        passwordCheck = false;
                                      });
                                    } else {
                                      setState(() {
                                        passwordError = null; // 에러 없음
                                        passwordCheck = true;
                                      });
                                    }
                                  },

                                  controller: controller2,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 17.0, horizontal: 10.0),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1.5,
                                              color: Color(0xffA1CBA1))),
                                      prefixIconColor: Color(0xffA1CBA1),
                                      prefixIcon: Icon(Icons.vpn_key_outlined),
                                      border: OutlineInputBorder(),
                                      suffixIcon: Icon(
                                          RegExp(r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$")
                                                  .hasMatch(controller2.text)
                                              ? Icons.check_circle_rounded
                                              : Icons.priority_high_rounded,
                                          color:
                                              RegExp(r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$")
                                                      .hasMatch(
                                                          controller2.text)
                                                  ? Color(0xffA1CBA1)
                                                  : Colors.red),
                                      labelText: '비밀번호',
                                      errorText: passwordError,
                                      errorStyle: TextStyle(height: 1),
                                      focusColor: Color(0xffA1CBA1)),
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: true, // 비밀번호 안보이도록 하는 것
                                ),
                              ),
                              SizedBox(
                                height: 83,
                                child: TextField(
                                  cursorColor: Color(0xffA1CBA1),

                                  onChanged: (value) {
                                    if (controller2.text != controller3.text) {
                                      setState(() {
                                        samepasswordError = samepasswordMessage;
                                        samepasswordCheck = false;
                                      });
                                    } else {
                                      setState(() {
                                        samepasswordError = null; // 에러 없음
                                        samepasswordCheck = true;
                                      });
                                    }
                                  },
                                  controller: controller3,

                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 17.0, horizontal: 10.0),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1.5,
                                              color: Color(0xffA1CBA1))),
                                      prefixIconColor: Color(0xffA1CBA1),
                                      prefixIcon: Icon(Icons.key),
                                      suffixIcon: Icon(
                                        (controller2.text == controller3.text &&
                                                controller3.text != '')
                                            ? Icons.check_circle_rounded
                                            : Icons.priority_high_rounded,
                                        color: (controller2.text ==
                                                    controller3.text &&
                                                controller3.text != '')
                                            ? Color(0xffA1CBA1)
                                            : Colors.red,
                                      ),
                                      border: OutlineInputBorder(),
                                      labelText: '비밀번호 확인',
                                      errorText: samepasswordError,
                                      errorStyle: TextStyle(height: 1),
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
                                          onPressed:
                                              emailCheck &&
                                                      emailCodeCheck &&
                                                      passwordCheck &&
                                                      samepasswordCheck
                                                  ? () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    AddInfo(
                                                                      user: {
                                                                        'userEmail':
                                                                            controller.text,
                                                                        'userPwd':
                                                                            controller2.text
                                                                      },
                                                                      storage:
                                                                          widget
                                                                              .storage,
                                                                    )),
                                                      );
                                                    }
                                                  : null,
                                          style: ButtonStyle(
                                              backgroundColor: emailCheck &&
                                                      emailCodeCheck &&
                                                      passwordCheck &&
                                                      samepasswordCheck
                                                  ? MaterialStatePropertyAll(
                                                      Color(0xffA1CBA1))
                                                  : MaterialStatePropertyAll(
                                                      Colors.grey)),
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
