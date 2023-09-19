import 'package:fe/main.dart';
import 'package:fe/user/userapi.dart';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'package:provider/provider.dart';
import '../store/userstore.dart';

class MyPage extends StatefulWidget {
  MyPage({super.key, this.storage});

  final storage;
  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final UserApi userapi = UserApi();

  List<String> foodlist = ['bakery.png', 'cabbage.png'];
  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();

  Dio dio = Dio();

  changepassword() async {
    try {
      Response response =
          await dio.post('http://10.0.2.2:8080/user/signin', data: {
        'curpassword': controller.text.toString(),
        'nextpassword': controller2.text.toString()
      });
      print('여기문제없어');
      return response.data;
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getuserinfo();
  }

  getuserinfo() async {
    print('이게 토큰');
    print(context.watch<UserStore>().userId);
    final token = await widget.storage.read(key: 'login');
    final info = await userapi.getinfo(context.watch<UserStore>().userId,
        token.toString().split(" ")[1].toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffA1CBA1),
        toolbarHeight: 55,
        title: Text('마이페이지'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 35),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: Text(
                            '안녕하세요,',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                            child: Text(
                              '${context.watch<UserStore>().userId.split('@')[0]} ',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xffA1CBA1)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                            child: Text(
                              '님',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: Text(
                          '오늘도 긍살!',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ])),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 25),
                      child: Text(
                        'My채움',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff164D16)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(children: [
                                Text(
                                  '레시피 ',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  '(${'3'}건)',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              ]),
                              Text('더보기')
                            ],
                          ),
                        ),
                        Expanded(
                          child: GridView.count(
                              crossAxisCount: 2, // 열 개수
                              children:
                                  List<Widget>.generate(foodlist.length, (idx) {
                                return Container(
                                  color: Colors.amber,
                                  padding: const EdgeInsets.all(30),
                                  margin: const EdgeInsets.all(8),
                                  child: Image.asset(
                                    'assets/images/main/${foodlist[idx]}',
                                    width: 100,
                                    height: 100,
                                  ),
                                );
                              }).toList()),
                        ),
                        SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(children: [
                                Text(
                                  '식재료 ',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  '(${'3'}건)',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              ]),
                              Text('더보기')
                            ],
                          ),
                        ),
                        Expanded(
                          child: GridView.count(
                              crossAxisCount: 2, // 열 개수
                              children:
                                  List<Widget>.generate(foodlist.length, (idx) {
                                return Container(
                                  color: Colors.amber,
                                  padding: const EdgeInsets.all(40),
                                  margin: const EdgeInsets.all(8),
                                  child: Image.asset(
                                    'assets/images/main/${foodlist[idx]}',
                                    width: 100,
                                    height: 100,
                                  ),
                                );
                              }).toList()),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              TextButton(
                child: Text(
                  '비밀번호 변경',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: true, //바깥 영역 터치시 닫을지 여부 결정
                    builder: ((context) {
                      return AlertDialog(
                        title: Text("비밀번호 변경"),
                        content: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(1, 0, 1, 10),
                                child: TextField(
                                  maxLength: 20,
                                  controller: controller,
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: true, // 비밀번호 안보이도록 하는 것
                                  decoration: InputDecoration(
                                      counterText: '',
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 16.0, horizontal: 10.0),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1.5,
                                              color: Color(0xffA1CBA1))),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide()),
                                      labelText: '현재 비밀번호',
                                      focusColor: Color(0xffA1CBA1)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(1, 0, 1, 10),
                                child: TextField(
                                  maxLength: 20,

                                  controller: controller2,
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: true, // 비밀번호 안보이도록 하는 것
                                  decoration: InputDecoration(
                                      counterText: '',
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 16.0, horizontal: 10.0),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1.5,
                                              color: Color(0xffA1CBA1))),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide()),
                                      labelText: '새로운 비밀번호',
                                      focusColor: Color(0xffA1CBA1)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(1, 0, 1, 0),
                                child: TextField(
                                  maxLength: 20,

                                  controller: controller3,
                                  obscureText: true, // 비밀번호 안보이도록 하는 것
                                  decoration: InputDecoration(
                                      counterText: '',
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 16.0, horizontal: 10.0),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1.5,
                                              color: Color(0xffA1CBA1))),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide()),
                                      labelText: '비밀번호 확인',
                                      focusColor: Color(0xffA1CBA1)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(1, 0, 1, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Color(0xffA1CBA1))),
                                    child: Text("변경하기"),
                                    onPressed: () async {
                                      if (RegExp(r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$")
                                              .hasMatch(controller2.text) &&
                                          RegExp(r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$")
                                              .hasMatch(controller3.text) &&
                                          controller2.text ==
                                              controller3.text) {
                                        final response = await changepassword();
                                      } else if (!RegExp(
                                              r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$")
                                          .hasMatch(controller2.text)) {
                                        showSnackBar(context,
                                            Text('비밀번호는 특수문자,영어, 숫자를 포함해 주세요'));
                                      } else if (controller2.text !=
                                          controller3.text) {
                                        showSnackBar(context,
                                            Text('비밀번호화 비밀번호 확인이 다릅니다.'));
                                      } else {
                                        showSnackBar(context,
                                            Text('현재비밀번호가 다릅니다 다시 시도해주세요'));
                                      }
                                    }),
                                ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Color(0xffA1CBA1))),
                                  onPressed: () {
                                    Navigator.of(context).pop(); //창 닫기
                                  },
                                  child: Text("취소하기"),
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    }),
                  );
                },
              ),
              Text('|'),
              TextButton(
                  child: Text(
                    '로그아웃',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                  onPressed: () async {
                    await widget.storage.delete(key: "login");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => Main()),
                    );
                  }),
              Text('|'),
              TextButton(
                child: Text(
                  '회원 탈퇴',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                ),
                onPressed: () {},
              ),
            ]),
          ],
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
