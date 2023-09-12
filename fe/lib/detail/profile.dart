import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key, this.category});
  final category;

  var data = {'saleper': 10, 'salewon': 300, 'salerank': 1};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        title: Text(
          '$category',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite_border, color: Colors.black),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/temporary/sample.png',
            height: 163,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            height: 93,
            width: double.infinity,
            padding: EdgeInsets.only(left: 20),
            // margin: EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xffB3B3B3), width: 0.5),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 3),
                  child: Text(
                    '$category',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Text(
                  '어제보다 ${data['saleper']}%(${data['salewon']}원) 더 비싸졌어요.',
                  style: TextStyle(
                    color: Color(0xff73324C),
                    fontWeight: FontWeight.w700,
                    fontSize: 16
                  ),
                ),
                Text(
                  '최근 3개월 중 ${data['salerank']}번째로 비싼 날이에요.',
                  style: TextStyle(
                    color: Color(0xff73324C),
                    fontWeight: FontWeight.w700,
                    fontSize: 16
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}