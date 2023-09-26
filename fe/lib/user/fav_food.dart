import 'package:flutter/material.dart';

class FavFood extends StatefulWidget {
  FavFood({super.key, this.favorIngr});
  final favorIngr;

  @override
  State<FavFood> createState() => _FavFoodState();
}

class _FavFoodState extends State<FavFood> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: GridView.count(
                crossAxisCount: 3, // 열 개수
                childAspectRatio: 5 / 5,
                // mainAxisSpacing: 10,
                // crossAxisSpacing: 25,
                children: List<Widget>.generate(widget.favorIngr.length, (idx) {
                  return Container(
                    child: Image.asset(
                      '',
                    ),
                  );
                }).toList()),
          ),
        ],
      ),
    );
  }
}
