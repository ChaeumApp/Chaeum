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
                crossAxisCount: 2, // 열 개수
                childAspectRatio: 5 / 5,
                // mainAxisSpacing: 10,
                // crossAxisSpacing: 25,
                children: List<Widget>.generate(widget.favorIngr.length, (idx) {
                  return Container(
                    color: Colors.amber,
                    padding: const EdgeInsets.all(40),
                    margin: const EdgeInsets.all(8),
                    child: Image.asset(
                      'assets/images/main/${widget.favorIngr[idx]}',
                      width: 100,
                      height: 100,
                    ),
                  );
                }).toList()),
          ),
        ],
      ),
    );
  }
}
