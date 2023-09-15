import 'package:flutter/material.dart';

class MainCategory extends StatelessWidget {
  const MainCategory({super.key});

  @override
  Widget build(BuildContext context) {
    var category = [
      {'name' : '과일', 'image' : 'orange'},
      {'name' : '채소', 'image' : 'cabbage'},
      {'name' : '곡류/견과', 'image' : 'rice'},
      {'name' : '정육/계란', 'image' : 'meat'},
      {'name' : '수산', 'image' : 'seafood'},
      {'name' : '유제품', 'image' : 'milk'},
      {'name' : '김치', 'image' : 'kimchi'},
      {'name' : '면', 'image' : 'noodle'},
      {'name' : '통조림', 'image' : 'canned'},
      {'name' : '조미료', 'image' : 'salt'},
      {'name' : '오일/소스', 'image' : 'oil'},
      {'name' : '베이커리', 'image' : 'bakery'}
    ];

    return SliverGrid(delegate: SliverChildBuilderDelegate(
        (c, i)=> Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(13, 0, 13, 0),
                width: 60,
                  height: 50,
                  child: Image.asset('assets/images/main/${category[i]['image']}.png',)),
              Text('${category[i]['name']}',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),)
            ],
          ),
        ),
    childCount: 12),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 6,
        ),
    );
  }
}
