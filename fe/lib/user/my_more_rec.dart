import 'package:flutter/material.dart';

import './fav_rec.dart';

class FavoriteMoreRec extends StatefulWidget {
  FavoriteMoreRec({super.key, this.favorRec});
  final favorRec;

  @override
  State<FavoriteMoreRec> createState() => _FavoriteMoreRecState();
}

class _FavoriteMoreRecState extends State<FavoriteMoreRec> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              '좋아하는 레시피',
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
        body: FavRec(favorRec: widget.favorRec));
  }
}
