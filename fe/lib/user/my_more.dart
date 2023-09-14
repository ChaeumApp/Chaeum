import 'package:flutter/material.dart';
import './fav_food.dart';
import './fav_rec.dart';

class FavoriteMore extends StatelessWidget {
  FavoriteMore({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              '즐겨찾기',
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
            ),
            elevation: 0.0,
            backgroundColor: Colors.white,
            centerTitle: true,
            toolbarHeight: 65),
        body: FavFood());
  }
}
