import 'package:flutter/material.dart';
import './cateitems.dart';

void main() {
  runApp(CatePage());
}

class CatePage extends StatelessWidget {
  CatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffA1CBA1),
          toolbarHeight: 55,
          title: Text('과일'),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.keyboard_backspace_rounded),
            onPressed: () {
              print('menu butten is clicked');
            },
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
              ),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "이런 재료들은 어때요?",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "총 156건",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(height: 2),
              ItemsCatePage()
            ],
          ),
        ),
      ),
    );
  }
}
