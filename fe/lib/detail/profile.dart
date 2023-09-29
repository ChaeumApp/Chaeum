import 'package:dio/dio.dart';
import 'package:fe/repeat/needlogin.dart';
import 'package:fe/store/userstore.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  ProfileView({super.key, this.category});
  final category;

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView>{
  var data = {'saleper': 10, 'salewon': 300, 'salerank': 1, 'like' : false};


  Dio dio = Dio();
  final serverURL = 'https://j9c204.p.ssafy.io';

  bool isSet = false;

  Future<dynamic> getProductInfo() async {
    var accessToken = context.read<UserStore>().accessToken;
    print('토큰은 $accessToken');
    try {
      final response = await dio.get(
        '$serverURL/ingr/detail/${widget.category}',
        queryParameters: {'ingrId' : widget.category},
        options: Options(
          headers: {'Authorization': accessToken != '' ? 'Bearer $accessToken' : ''},
        ),
      );

      // Response response;
      // if (accessToken != '') {
      //   response = await dio.get(
      //     '$serverURL/ingr/detail/${widget.category}',
      //     queryParameters: {'ingrId' : widget.category},
      //     options: Options(
      //       headers: {'Authorization': 'Bearer $accessToken'},
      //     ),
      //   );
      // } else {
      //   response = await dio.get(
      //     '$serverURL/ingr/detail/${widget.category}',
      //     queryParameters: {'ingrId' : widget.category},
      //   );
      // }
      if (!isSet) {
        setState(() {
          data['like'] = response.data['savedIngredient'];
          isSet = true;
        });
      }
      // print(response.data);
      return response.data;
    } catch (e) {
      print(e);
    }
  }


  Future<bool?> toggleLike(bool isLiked) async {
    bool liked = false;
    var accessToken = context.read<UserStore>().accessToken;
    print('카테고리임 ${widget.category}');
    if (accessToken != ''){
      final response =await dio.post(
        '$serverURL/ingr/favorite',
        data: {'ingrId' : widget.category},
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );
      if(response.data == 'success'){
        setState(() {
          if (data.containsKey('like') && data['like'] is bool) {
            data['like'] = !(data['like'] as bool);
            liked = data['like'] as bool;
          } else {
            data['like'] = false;
          }
        });
      }
      print(response.data);
      return Future.value(liked);
    } else {
      Alertlogin().needLogin(context);
    }
  }


  @override
  Widget build(BuildContext context) {


    return FutureBuilder(future: getProductInfo(), builder: (BuildContext context, AsyncSnapshot snapshot){
      if (snapshot.hasData == false) {
        return SizedBox.shrink();
      }
      else if (snapshot.hasError) {
        return Padding(
          padding: const EdgeInsets.all(8.0),

          child: Text(
            'Error: ${snapshot.error}',
            style: TextStyle(fontSize: 15),
          ),
        );
      }
      else {
        return  Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey[50],
            elevation: 0,
            title: Text(
              '${snapshot.data['ingrName']}',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
            ),
            centerTitle: true,
            actions: [
              Container(
                margin: EdgeInsets.only(right: 10),
                child: LikeButton(
                  isLiked: data['like'] as bool,
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
                'assets/images/ingr/${snapshot.data['ingrName']}.jpg',
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
                       snapshot.data['ingrName'],
                        style: TextStyle(
                           fontSize: 21,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    // Container(
                    //  margin: EdgeInsets.only(bottom: 3),
                    //  child: Text(
                    //    '어제보다 ${data['saleper']}%(${data['salewon']}원) 더 비싸졌어요.',
                    //    style: TextStyle(
                    //      color: Color(0xff73324C),
                    //      fontWeight: FontWeight.w700,
                    //      fontSize: 16
                    //   ),
                    //  ),
                    //),
                    Text(
                       '식재료에 대한 정보를 확인하세요.',
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
    });
  }
}