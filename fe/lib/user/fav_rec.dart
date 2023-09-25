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
    return ListView.builder(
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              // 연결후 추가
              // clickRecipe(index);
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => RecipeDetailPage(recipeId : recipes[index]['recipeId'])));
            },
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.5)))),
              child: Row(
                children: [
                  Flexible(
                    flex: 3,
                    child: Image.network(
                        // getYoutubeThumbnail(
                        //   recipes[index]['url'],
                        // ),
                        '',
                        height: 100),
                  ),
                  Flexible(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 15, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('하', style: TextStyle(fontSize: 15)),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                            color: Color(0xff868E96),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
