import 'package:flutter/material.dart';

import './fav_rec.dart';

class FavoriteMoreRec extends StatefulWidget {
  FavoriteMoreRec({super.key, this.favorRec});
  final favorRec;

  @override
  State<FavoriteMoreRec> createState() => _FavoriteMoreRecState();
}

class _FavoriteMoreRecState extends State<FavoriteMoreRec> {
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.small(
          onPressed: () {
            scrollController.animateTo(
              scrollController.position.minScrollExtent,
              duration: Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
            );
          },
          backgroundColor: Colors.grey[50],
          shape: RoundedRectangleBorder(
              side: BorderSide(width: 1, color: Color(0xffA1CBA1)),
              borderRadius: BorderRadius.circular(12)),
          child: Icon(Icons.arrow_upward_sharp, color: Color(0xffA1CBA1)),
        ),
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
        body: FavRec(
            favorRec: widget.favorRec, scrollController: scrollController));
  }
}
