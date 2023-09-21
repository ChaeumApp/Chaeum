import 'package:dio/dio.dart';
import 'package:fe/recipe/recipemainlist.dart';
import 'package:fe/repeat/search.dart';
import 'package:flutter/material.dart';

class RecipeMain extends StatefulWidget {
  const RecipeMain({super.key});

  @override
  State<RecipeMain> createState() => _RecipeMainState();
}

class _RecipeMainState extends State<RecipeMain> {
  final ScrollController scrollController = ScrollController();
  bool isFabVisible = false;

  // @override
  // void initState() {
  //   super.initState();
  //   scrollController.addListener(() {
  //     setState(() {
  //       isFabVisible = scrollController.offset > 100;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Search(),
          RecipeMainList(scrollController: scrollController),
        ],
      ),
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
                side: BorderSide(width: 1,
                color: Color(0xffA1CBA1)),
                  borderRadius: BorderRadius.circular(12)),
        child: Icon(Icons.arrow_upward_sharp,
        color: Color(0xffA1CBA1)),
            )
    );
  }
}
