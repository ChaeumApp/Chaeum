import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailRecipe extends StatefulWidget {
  const DetailRecipe({super.key});

  @override
  State<DetailRecipe> createState() => _DetailRecipeState();
}

class _DetailRecipeState extends State<DetailRecipe> {
  var recipes = [
    {'title' : '복숭아 잼', 'url' : 'https://www.youtube.com/watch?v=zqvatzbtXXg'},
    {'title' : '복숭아 우유', 'url' : 'https://www.youtube.com/watch?v=-ALrxisJdpI'},
    {'title' : '복숭아 통조림', 'url' : 'https://www.youtube.com/watch?v=hzkMaSGJEB4'},
  ];

 getYoutubeThumbnail(url){
   String id = url.substring(url.length -11);
   String quality = ThumbnailQuality.medium;
   return 'https://i3.ytimg.com/vi/$id/$quality.jpg';
 }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
      child: ListView.builder(
          itemCount: recipes.length,
          itemBuilder: (BuildContext context, int index){
        return Container(
          height: 100,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.5))
            )
          ),
          child: Row(
            children: [
              Flexible(
                flex: 3,
                child: Image.network(getYoutubeThumbnail(recipes[index]['url'],),
                height: 100),
              ),
              Flexible(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 15, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(recipes[index]['title'] as String, style: TextStyle(
                        fontSize: 15
                      )),
                      Icon(Icons.arrow_forward_ios, size: 15, color: Color(0xff868E96),)
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
