import 'dart:convert';

import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  MyPage({super.key});

  var foodlist = ['bakery.png', 'cabbage.png'];

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
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                    child: Text(
                      'My채움',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff164D16)),
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Row(children: [
                          Text(
                            '레시피 ',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            '(${'3'}건)',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                        ]),
                        Row(
                          children: [
                            SizedBox(
                              height: 100,
                              width: double.infinity,
                              // 높이를 100으로 고정
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: foodlist.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Image.asset(
                                    'assets/images/main/${foodlist[index]}',
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.fill,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
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
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(
                    '비밀번호 변경',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    '회원 탈퇴',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ])),
          ],
        ),
      ),
    );
  }
}
