import 'package:flutter/material.dart';

class Detail extends StatelessWidget {
  const Detail({super.key, this.category});
  final category;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // backgroundColor: Colors.white,
          title: Text('${category}'),
        ),
      ),
    );
  }
}
