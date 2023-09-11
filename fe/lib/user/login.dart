import 'package:flutter/material.dart';
import '../user/mypage.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
            title: Text(
              '로그인',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
            ),
            elevation: 0.0,
            backgroundColor: Colors.white,
            centerTitle: true,
            toolbarHeight: 65),
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
                                height: 58,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                  child: TextField(
                                    style: TextStyle(fontSize: 15),
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
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide()),
                                        labelText: '이메일',
                                        focusColor: Color(0xffA1CBA1)),
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 58,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
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
                                        prefixIcon:
                                            Icon(Icons.vpn_key_outlined),
                                        border: OutlineInputBorder(),
                                        labelText: '비밀번호',
                                        focusColor: Color(0xffA1CBA1)),
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: true, // 비밀번호 안보이도록 하는 것
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 60,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                  child: ButtonTheme(
                                      child: TextButton(
                                          onPressed: () {
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
                                                  '로그인',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ))),
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        child: Text('아이디 찾기'),
                                      ),
                                      Text(' | '),
                                      GestureDetector(
                                        child: Text('비밀번호 찾기'),
                                      ),
                                    ]),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                child: Column(children: [
                                  Text(
                                    '소셜 로그인',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                            width: 55,
                                            height: 55,
                                            child: Image.asset(
                                                'assets/images/login/kakaoLogo.png')),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                            width: 55,
                                            height: 55,
                                            child: Image.asset(
                                                'assets/images/login/naverLogo.png')),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text('아직 회원이 아니신가요?  '),
                                      Text(
                                        '회원가입',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    ],
                                  ),
                                ]),
                              )
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
