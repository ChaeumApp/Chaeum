import 'package:fe/user/login.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../store/userstore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MyPage extends StatefulWidget {
  MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  String? userInfo; //user의 정보를 저장하기 위한 변수

  static final storage =
      FlutterSecureStorage(); //flutter_secure_storage 사용을 위한 초기화 작업
  @override
  void initState() {
    super.initState();

    //비동기로 flutter secure storage 정보를 불러오는 작업.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    //read 함수를 통하여 key값에 맞는 정보를 불러오게 됩니다. 이때 불러오는 결과의 타입은 String 타입임을 기억해야 합니다.
    //(데이터가 없을때는 null을 반환을 합니다.)
    userInfo = await storage.read(key: "login");
    print(userInfo);

    //user의 정보가 있다면 바로 로그아웃 페이지로 넝어가게 합니다.
    if (userInfo != null) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LogIn(storage: storage)));
    }
  }

  List<String> foodlist = ['bakery.png', 'cabbage.png'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffA1CBA1),
        toolbarHeight: 55,
        title: Text('마이페이지'),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace_rounded),
          onPressed: () {
            print('menu butten is clicked');
          },
        ),
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
                              'user ',
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
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(children: [
                              Text(
                                '식재료 ',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                '(${'3'}건)',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w600),
                              ),
                            ]),
                            Text('더보기')
                          ],
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
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              TextButton(
                child: Text(
                  '비밀번호 변경',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                ),
                onPressed: () {},
              ),
              TextButton(
                child: Text(
                  '회원 탈퇴',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                ),
                onPressed: () {},
              ),
              TextButton(
                child: Text(
                  '로그아웃',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                ),
                onPressed: () async {
                  await storage.delete(key: "login");
                },
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
