import 'package:fe/detail/detail.dart';
import 'package:flutter/material.dart';

class FavFood extends StatefulWidget {
  FavFood({super.key, this.favorIngr, this.scrollController});
  final favorIngr;
  final scrollController;

  @override
  State<FavFood> createState() => _FavFoodState();
}

class _FavFoodState extends State<FavFood> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: List<Widget>.generate(widget.favorIngr.length, (index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Detail(category: widget.favorIngr[index]['ingrId'])));
          },
          child: Container(
            margin: EdgeInsets.all(3),
            child: Image.asset(
              'assets/images/ingr/${widget.favorIngr[index]['ingrName']}.jpg',
              fit: BoxFit.fill,
            ),
          ),
        );
      }),
    );
  }
}
