import 'package:flutter/material.dart';

class MyPageAppBar extends StatelessWidget {
  const MyPageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 70,
      title: Text('마이페이지'),
      centerTitle: true,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.keyboard_backspace_rounded),
        onPressed: () {
          print('menu butten is clicked');
        },
      ),
    );
  }
}
