import 'package:flutter/material.dart';
import '../repeat/search.dart';
import './maincategory.dart';


class Mainb extends StatefulWidget {
  const Mainb({super.key});

  @override
  State<Mainb> createState() => _MainbState();
}

class _MainbState extends State<Mainb> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Search(),
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 3),
          child: Image.asset('assets/images/main/main_banner1.png',)),
        MainCategory(),
      ],
    );
  }
}
