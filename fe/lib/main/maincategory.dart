import 'package:fe/category/catepage.dart';
import 'package:fe/ingredients/ingrmain.dart';
import 'package:flutter/material.dart';

class MainCategory extends StatelessWidget {
  const MainCategory({super.key});

  @override
  Widget build(BuildContext context) {
    var category = [
      {'catName' : '과일', 'image' : 'orange', 'catId' : 1, 'subCatId' : null},
      {'catName' : '채소', 'image' : 'cabbage', 'catId' : 2, 'subCatId' : null},
      {'catName' : '곡류/견과', 'image' : 'rice', 'catId' : 3, 'subCatId' : null},
      {'catName' : '정육/달걀', 'image' : 'meat', 'catId' : 4, 'subCatId' : 0},
      {'catName' : '수산물', 'image' : 'seafood', 'catId' : 5, 'subCatId' : null},
      {'catName' : '유제품', 'image' : 'milk', 'catId' : 6, 'subCatId' : null},
      {'catName' : '김치', 'image' : 'kimchi', 'catId' : 7, 'subCatId' : null},
      {'catName' : '면/파스타', 'image' : 'noodle', 'catId' : 8, 'subCatId' : null},
      {'catName' : '통조림', 'image' : 'canned', 'catId' : 9, 'subCatId' : null},
      {'catName' : '가루/조미료', 'image' : 'salt', 'catId' : 10, 'subCatId' : null},
      {'catName' : '오일/소스', 'image' : 'oil', 'catId' : 11, 'subCatId' : null},
      {'catName' : '빵/잼', 'image' : 'bakery', 'catId' : 12, 'subCatId' : null}
    ];

    return SliverGrid(delegate: SliverChildBuilderDelegate(
        (c, i)=> GestureDetector(
          onTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        IngrMain(catId : category[i]['catId'], subCatId : category[i]['subCatId'], catName : category[i]['catName'], sortNum : 0)));
          },
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  width: 60,
                    height: 60,
                    child: Image.asset('assets/images/main/${category[i]['image']}.png',)),
                Text('${category[i]['catName']}',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),)
              ],
            ),
          ),
        ),
    childCount: 12),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 6,
          mainAxisExtent: 80,
          mainAxisSpacing: 5
        ),
    );
  }
}
