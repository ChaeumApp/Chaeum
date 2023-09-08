import 'package:flutter/material.dart';

class MainCategory extends StatelessWidget {
  const MainCategory({super.key});

  @override
  Widget build(BuildContext context) {
    var category = [
      {'name' : '과일', 'image' : 'orange'},
      {'name' : '곡류/견과', 'image' : 'rice'},
      {'name' : '채소', 'image' : 'cabbage'},
      {'name' : '수산', 'image' : 'seafood'},
      {'name' : '축산', 'image' : 'meat'},
      {'name' : '유제품', 'image' : 'milk'},
      {'name' : '김치', 'image' : 'kimchi'},
      {'name' : '면/통조림', 'image' : 'noodle'},
      {'name' : '양념', 'image' : 'oil'},
      {'name' : '베이커리/잼', 'image' : 'bakery'}
    ];
    
    return SliverGrid(delegate: SliverChildBuilderDelegate(
        (c, i)=> Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(13, 0, 13, 0),
                width: 60,
                  height: 60,
                  child: Image.asset('assets/images/main/${category[i]['image']}.png',)),
              Text('${category[i]['name']}',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),)
            ],
          ),
        ),
    childCount: 10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5
        ));
  }
}
