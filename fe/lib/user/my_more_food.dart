import 'package:flutter/material.dart';
import './fav_food.dart';

class FavoriteMoreFood extends StatefulWidget {
  FavoriteMoreFood({super.key, this.favorIngr});
  final favorIngr;

  @override
  State<FavoriteMoreFood> createState() => _FavoriteMoreFoodState();
}

class _FavoriteMoreFoodState extends State<FavoriteMoreFood> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              '좋아하는 식재료',
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
            ),
            elevation: 0.0,
            backgroundColor: Colors.grey[50],
            centerTitle: true,
            toolbarHeight: 65,
            foregroundColor: Colors.black),
        body: FavFood(favorIngr: widget.favorIngr));
  }
}
