import 'package:fe/recipe/recipedetail.dart';
import 'package:flutter/material.dart';

class FavRec extends StatefulWidget {
  FavRec({super.key, this.favorRec});
  final favorRec;

  @override
  State<FavRec> createState() => _FavRecState();
}

class _FavRecState extends State<FavRec> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.favorRec.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              // 연결후 추가
              // clickRecipe(index);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RecipeDetailPage(
                          recipeId: widget.favorRec[index]['recipeId'])));
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
                        '${widget.favorRec[index]['recipeThumbnail']}'
                        // ),
                        ,
                        height: 100),
                  ),
                  Flexible(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 15, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.favorRec[index]['recipeName'] as String,
                            maxLines: 2, style: TextStyle(fontSize: 15),
                            overflow: TextOverflow.visible, // 생략 기호 추가
                          ),
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
