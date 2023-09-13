import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class ProfileView extends StatefulWidget {
  ProfileView({super.key, this.category});
  final category;

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView>{
  var data = {'saleper': 10, 'salewon': 300, 'salerank': 1, 'like' : true};


  Future<bool?> toggleLike(bool isLiked) async {
    bool liked = false;
    setState(() {
      if (data.containsKey('like') && data['like'] is bool) {
        data['like'] = !(data['like'] as bool);
        liked = data['like'] as bool;
      } else {
        data['like'] = false;
      }
    });
    return Future.value(liked);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        title: Text(
          '${widget.category}',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: LikeButton(
              isLiked: data['like'] as bool, // 초기 좋아요 상태
              onTap: (isLiked) {
                return toggleLike(isLiked);
              },
              circleColor: CircleColor(
                  start: Color(0xffff0044),
                  end: Color(0xffff4c7c)
              ),
              bubblesColor: BubblesColor(
                dotPrimaryColor: Color(0xffff3333),
                dotSecondaryColor: Color(0xffff9999),
              ),
              likeBuilder: (bool isLiked) {
                return Icon(
                  data['like'] as bool ? Icons.favorite : Icons.favorite_border,
                  color: data['like'] as bool ? Colors.red : Colors.black,
                );
              },

            ),
          )
          // IconButton(
          //   onPressed: () {
          //     toggleLike();
          //   },
          //   icon: Icon(data['like'] as bool ? Icons.favorite : Icons.favorite_border,
          //     color: data['like'] as bool ? Colors.red : Colors.black,),
          // )
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
            height: 100,
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
                  margin: EdgeInsets.only(bottom: 5),
                  child: Text(
                    '${widget.category}',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 3),
                  child: Text(
                    '어제보다 ${data['saleper']}%(${data['salewon']}원) 더 비싸졌어요.',
                    style: TextStyle(
                      color: Color(0xff73324C),
                      fontWeight: FontWeight.w700,
                      fontSize: 16
                    ),
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