import 'package:fe/ingredients/ingrmain.dart';
import 'package:flutter/material.dart';

class CategoryMain extends StatefulWidget {
  const CategoryMain({super.key});

  @override
  State<CategoryMain> createState() => _CategoryMainState();
}

class _CategoryMainState extends State<CategoryMain> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        centerTitle: true,
        elevation: 0,
        title: Text('식재료 카테고리',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w700
        )),
        backgroundColor: Colors.grey[50],
        shape: Border(
          bottom: BorderSide(
            color: Colors.black54,
            width: 0.8
          )
        ),
      ),
      body: ListView(
        children: [
          GestureDetector(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          IngrMain(catId : 1, subCatId : null, catName : '과일', sortNum : 0)));
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: Colors.black54,
                      width: 0.5)
                )
              ),
              child: ListTile(
                leading: Image.asset('assets/images/category/fr.png',
                  width: 28,
                  height: 28,),
                title: Text('과일'),
                trailing: Icon(Icons.keyboard_arrow_right),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          IngrMain(catId : 2, subCatId : null, catName: '채소', sortNum : 0)));
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: Colors.black54,
                          width: 0.5)
                  )
              ),
              child: ListTile(
                leading: Image.asset('assets/images/category/vg.png',
                  width: 28,
                  height: 28,),
                title: Text('채소'),
                trailing: Icon(Icons.keyboard_arrow_right),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          IngrMain(catId : 3, subCatId : null, catName: '곡류/견과', sortNum : 0)));
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: Colors.black54,
                          width: 0.5)
                  )
              ),
              child: ListTile(
                leading: Image.asset('assets/images/category/pn.png',
                  width: 28,
                  height: 28,),
                title: Text('곡류/견과'),
                trailing: Icon(Icons.keyboard_arrow_right),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.black54,
                        width: 0.5)
                )
            ),
            child: ExpansionTile(
              // collapsedTextColor: Colors.black,
              onExpansionChanged: (bool expanding){
                setState(() {
                  isExpanded = expanding;
                });
              },
              trailing: Icon(
                isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                color: Colors.black54,
                ),
              leading: Image.asset('assets/images/category/mt.png',
                width: 28,
                height: 28,),
              title: Text('정육/달걀',
                style: TextStyle(
                  color: Colors.black,
                ),),
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                IngrMain(catId : 4, subCatId : 0, catName: '정육/달걀', sortNum : 0)));
                  },
                  child: Container(
                    color: Colors.grey[200],
                    child: ListTile(
                      leading: Image.asset('assets/images/category/barbecue.png',
                        width: 28,
                        height: 28,),
                      title: Text('전체보기'),
                      trailing: Icon(Icons.keyboard_arrow_right),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                IngrMain(catId : 4, subCatId : 1, catName: '소고기', sortNum : 0)));
                  },
                  child: Container(
                    color: Colors.grey[200],
                    child: ListTile(
                      leading: Image.asset('assets/images/category/cow.png',
                        width: 28,
                        height: 28,),
                      title: Text('소고기'),
                      trailing: Icon(Icons.keyboard_arrow_right),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                IngrMain(catId : 4, subCatId : 2, catName: '돼지고기', sortNum : 0)));
                  },
                  child: Container(
                    color: Colors.grey[200],
                    child: ListTile(
                      leading: Image.asset('assets/images/category/pig.png',
                        width: 28,
                        height: 28,),
                      title: Text('돼지고기'),
                      trailing: Icon(Icons.keyboard_arrow_right),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                IngrMain(catId : 4, subCatId : 3, catName: '닭고기', sortNum : 0)));
                  },
                  child: Container(
                    color: Colors.grey[200],
                    child: ListTile(
                      leading: Image.asset('assets/images/category/chicken.png',
                        width: 28,
                        height: 28,),
                      title: Text('닭고기'),
                      trailing: Icon(Icons.keyboard_arrow_right),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                IngrMain(catId : 4, subCatId : 4, catName: '오리고기', sortNum : 0)));
                  },
                  child: Container(
                    color: Colors.grey[200],
                    child: ListTile(
                      leading: Image.asset('assets/images/category/duck.png',
                        width: 28,
                        height: 28,),
                      title: Text('오리고기'),
                      trailing: Icon(Icons.keyboard_arrow_right),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                IngrMain(catId : 4, subCatId : 5, catName: '양고기', sortNum : 0)));
                  },
                  child: Container(
                    color: Colors.grey[200],
                    child: ListTile(
                      leading: Image.asset('assets/images/category/sheep.png',
                        width: 28,
                        height: 28,),
                      title: Text('양고기'),
                      trailing: Icon(Icons.keyboard_arrow_right),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                IngrMain(catId : 4, subCatId : 6, catName: '달걀', sortNum : 0)));
                  },
                  child: Container(
                    color: Colors.grey[200],
                    child: ListTile(
                      leading: Image.asset('assets/images/category/eggs.png',
                        width: 28,
                        height: 28,),
                      title: Text('달걀'),
                      trailing: Icon(Icons.keyboard_arrow_right),
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          IngrMain(catId : 5, subCatId : null, catName: '수산물', sortNum : 0)));
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: Colors.black54,
                          width: 0.5)
                  )
              ),
              child: ListTile(
                leading: Image.asset('assets/images/category/fsh.png',
                  width: 28,
                  height: 28,),
                title: Text('수산물'),
                trailing: Icon(Icons.keyboard_arrow_right),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          IngrMain(catId : 6, subCatId : null, catName: '유제품', sortNum : 0)));
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: Colors.black54,
                          width: 0.5)
                  )
              ),
              child: ListTile(
                leading: Image.asset('assets/images/category/dairy-products.png',
                  width: 25,
                  height: 25,),
                title: Text('유제품'),
                trailing: Icon(Icons.keyboard_arrow_right),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          IngrMain(catId : 7, subCatId : null, catName: '김치', sortNum : 0)));
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: Colors.black54,
                          width: 0.5)
                  )
              ),
              child: ListTile(
                leading: Image.asset('assets/images/category/gch.png',
                  width: 28,
                  height: 28,),
                title: Text('김치'),
                trailing: Icon(Icons.keyboard_arrow_right),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          IngrMain(catId : 8, subCatId : null, catName: '면/파스타', sortNum : 0)));
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: Colors.black54,
                          width: 0.5)
                  )
              ),
              child: ListTile(
                leading: Image.asset('assets/images/category/noodles.png',
                  width: 33,
                  height: 33,),
                title: Text('면/파스타'),
                trailing: Icon(Icons.keyboard_arrow_right),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          IngrMain(catId : 9, subCatId : null, catName: '통조림', sortNum : 0)));
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: Colors.black54,
                          width: 0.5)
                  )
              ),
              child: ListTile(
                leading: Image.asset('assets/images/category/can.png',
                  width: 28,
                  height: 28,),
                title: Text('통조림'),
                trailing: Icon(Icons.keyboard_arrow_right),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          IngrMain(catId : 10, subCatId : null, catName: '가루/조미료', sortNum : 0)));
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: Colors.black54,
                          width: 0.5)
                  )
              ),
              child: ListTile(
                leading: Image.asset('assets/images/category/sc.png',
                  width: 28,
                  height: 28,),
                title: Text('가루/조미료'),
                trailing: Icon(Icons.keyboard_arrow_right),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          IngrMain(catId : 11, subCatId : null, catName: '오일/소스', sortNum : 0)));
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: Colors.black54,
                          width: 0.5)
                  )
              ),
              child: ListTile(
                leading: Image.asset('assets/images/category/oil.png',
                  width: 28,
                  height: 28,),
                title: Text('오일/소스'),
                trailing: Icon(Icons.keyboard_arrow_right),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          IngrMain(catId : 12, subCatId : null, catName: '빵/잼', sortNum : 0)));
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: Colors.black54,
                          width: 0.5)
                  )
              ),
              child: ListTile(
                leading: Image.asset('assets/images/category/toast.png',
                width: 28,
                height: 28,),
                title: Text('빵/잼'),
                trailing: Icon(Icons.keyboard_arrow_right),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
