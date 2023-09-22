import 'package:flutter/material.dart';

class FavRec extends StatefulWidget {
  FavRec({super.key});
  List<String> favoriteRec = [
    'bakery.png',
    'kimchi.png',
    'meat.png',
    'rice.png'
  ];

  @override
  State<FavRec> createState() => _FavRecState();
}

class _FavRecState extends State<FavRec> {
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
                children:
                    List<Widget>.generate(widget.favoriteRec.length, (idx) {
                  return Container(
                    color: Colors.amber,
                    padding: const EdgeInsets.all(40),
                    margin: const EdgeInsets.all(8),
                    child: Image.asset(
                      'assets/images/main/${widget.favoriteRec[idx]}',
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
