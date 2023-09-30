import 'package:dio/dio.dart';
import 'package:fe/repeat/needlogin.dart';
import 'package:fe/store/userstore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IngrFavBtn extends StatefulWidget {
  const IngrFavBtn({super.key, this.isFav, this.ingrId});
  final isFav;
  final ingrId;

  @override
  State<IngrFavBtn> createState() => _IngrFavBtnState();
}

class _IngrFavBtnState extends State<IngrFavBtn> {
  bool fabBtnClick = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fabBtnClick = widget.isFav;
  }

  Dio dio = Dio();
  final serverURL = 'https://j9c204.p.ssafy.io';

  Future<dynamic> likeIngr(ingrId) async {
    var accessToken = context.read<UserStore>().accessToken;
    if (accessToken != '') {
      final response = await dio.post(
        '$serverURL/ingr/favorite',
        data: {'ingrId': ingrId},
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );
      if (response.data == 'success'){
        setState(() {
          fabBtnClick = !fabBtnClick;
        });
        if(fabBtnClick){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Color(0xff4C8C4C),
              content: Text('좋아하는 재료로 추가되었습니다.',
              style: TextStyle(color: Colors.white)),
              duration: Duration(seconds: 2),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Color(0xff4C8C4C),
              content: Text('좋아하는 재료에서 삭제되었습니다.',
                  style: TextStyle(color: Colors.white)),
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    } else {
      Alertlogin().needLogin(context);
    }
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        likeIngr(widget.ingrId);
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 7, 0, 0),
        padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
        decoration: BoxDecoration(
          border: fabBtnClick ? Border.all(color: Color(0xff4C8C4C)) : Border.all(color: Color(0xffD9D9D9)),
          borderRadius:
          BorderRadius.all(Radius.circular(3),),
          // color: fabBtnClick ? Color(0xff4C8C4C) : Colors.white,
        ),
        child: Row(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  0, 0, 5, 0),
              child: Icon(
                  Icons.shopping_cart_outlined,
                  size: 17,
              color: fabBtnClick ? Color(0xff4C8C4C) : Colors.black,),
            ),
            Text(
              '알림설정',
              style: TextStyle(fontSize: 15,
                color: fabBtnClick ? Color(0xff4C8C4C) : Colors.black,),
            )
          ],
        ),
      ),
    );
  }
}
