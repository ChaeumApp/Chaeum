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
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: Colors.black54,
                    width: 0.8)
              )
            ),
            child: ListTile(
              leading: Image.asset('assets/images/category/fr.png'),
              title: Text('과일'),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.black54,
                        width: 0.8)
                )
            ),
            child: ListTile(
              leading: Image.asset('assets/images/category/vg.png'),
              title: Text('채소'),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.black54,
                        width: 0.8)
                )
            ),
            child: ListTile(
              leading: Image.asset('assets/images/category/pn.png'),
              title: Text('곡류/견과'),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.black54,
                        width: 0.8)
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
                isExpanded ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
                color: Colors.black54,
                ),
              leading: Image.asset('assets/images/category/mt.png'),
              title: Text('정육',
                style: TextStyle(
                  color: Colors.black,
                ),),
              children: <Widget>[
                Container(
                  color: Colors.grey[200],
                  child: ListTile(
                    leading: Image.asset('assets/images/category/cow.png',
                      width: 28,
                      height: 28,),
                    title: Text('소고기'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                ),
                Container(
                  color: Colors.grey[200],
                  child: ListTile(
                    leading: Image.asset('assets/images/category/pig.png',
                      width: 28,
                      height: 28,),
                    title: Text('돼지고기'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                ),
                Container(
                  color: Colors.grey[200],
                  child: ListTile(
                    leading: Image.asset('assets/images/category/chicken.png',
                      width: 28,
                      height: 28,),
                    title: Text('닭고기'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                ),
                Container(
                  color: Colors.grey[200],
                  child: ListTile(
                    leading: Image.asset('assets/images/category/duck.png',
                      width: 28,
                      height: 28,),
                    title: Text('오리고기'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                ),
                Container(
                  color: Colors.grey[200],
                  child: ListTile(
                    leading: Image.asset('assets/images/category/sheep.png',
                      width: 28,
                      height: 28,),
                    title: Text('양고기'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                ),
                Container(
                  color: Colors.grey[200],
                  child: ListTile(
                    leading: Image.asset('assets/images/category/eggs.png',
                      width: 28,
                      height: 28,),
                    title: Text('달걀'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.black54,
                        width: 0.8)
                )
            ),
            child: ListTile(
              leading: Image.asset('assets/images/category/fsh.png'),
              title: Text('수산물'),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.black54,
                        width: 0.8)
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
          Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.black54,
                        width: 0.8)
                )
            ),
            child: ListTile(
              leading: Image.asset('assets/images/category/gch.png'),
              title: Text('김치'),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.black54,
                        width: 0.8)
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
          Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.black54,
                        width: 0.8)
                )
            ),
            child: ListTile(
              leading: Image.asset('assets/images/category/can.png'),
              title: Text('통조림'),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.black54,
                        width: 0.8)
                )
            ),
            child: ListTile(
              leading: Image.asset('assets/images/category/sc.png'),
              title: Text('가루/조미료'),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.black54,
                        width: 0.8)
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
          Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.black54,
                        width: 0.8)
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
        ],
      ),
    );
  }
}
