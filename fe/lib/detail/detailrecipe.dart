import 'package:flutter/material.dart';

class DetailRecipe extends StatefulWidget {
  const DetailRecipe({super.key});

  @override
  State<DetailRecipe> createState() => _DetailRecipeState();
}

class _DetailRecipeState extends State<DetailRecipe> {
  var recipes = [
    {'title' : '복숭아 잼', 'url' : 'https://www.youtube.com/watch?v=-ALrxisJdpI'},
    {'title' : '복숭아 우유', 'url' : 'https://www.youtube.com/watch?v=-ALrxisJdpI'},
    {'title' : '복숭아 커피', 'url' : 'https://www.youtube.com/watch?v=-ALrxisJdpI'},
  ];

 getYoutubeThumbnail(){

 }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (BuildContext context, int index){
      return Container(

        height: 100,
        child: Center(child: Text('Entry ${recipes[index]}')),
      );
    });
  }
}
