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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Search(),
          RecipeMainList(),
        ],
    );
  }
}
