import 'package:fe/main.dart';
import 'package:flutter/material.dart';

void NeedLogin(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            content: Column(mainAxisSize: MainAxisSize.min,
                children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Image.asset(
                  'assets/images/repeat/bottom_logo.png',
                  height: 50,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text('로그인이 필요한 서비스입니다.', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
              SizedBox(
                height: 30,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 1, color: Colors.black26)
                  )
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Main(initialTabIndex : 4),
                            ), (route)=> false,
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(width: 1, color: Colors.black26)
                            )
                          ),
                          child: Text(
                            '로그인',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color(0xff4C8C4C),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                          child: Text(
                            '취소',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ]));
      });
}
