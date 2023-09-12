import 'package:flutter/material.dart';
import './popular_product.dart';
import './catepage.dart';

void main() {
  runApp(Ingrecate());
}

class Ingrecate extends StatelessWidget {
  Ingrecate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Color(0xffA1CBA1),
          toolbarHeight: 55,
          title: Text('식재료카테고리'),
          centerTitle: true,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(2),
          child: Column(
            children: [
              SizedBox(
                height: 42,
                child: ListTile(
                  leading: Image.asset('assets/images/category/fr.png'),
                  title: Text('과일'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CatePage()),
                    );
                  },
                  trailing: Icon(Icons.keyboard_arrow_down),
                ),
              ),
              Divider(),
              SizedBox(
                height: 42,
                child: ListTile(
                  leading: Image.asset('assets/images/category/pn.png'),
                  title: Text('견과류'),
                  onTap: () {},
                  trailing: Icon(Icons.keyboard_arrow_down),
                ),
              ),
              Divider(),
              SizedBox(
                height: 42,
                child: ListTile(
                  leading: Image.asset('assets/images/category/vg.png'),
                  title: Text('채소'),
                  onTap: () {},
                  trailing: Icon(Icons.keyboard_arrow_down),
                ),
              ),
              Divider(),
              SizedBox(
                height: 42,
                child: ListTile(
                  leading: Image.asset('assets/images/category/fsh.png'),
                  title: Text('수산·해산·건어물'),
                  onTap: () {},
                  trailing: Icon(Icons.keyboard_arrow_down),
                ),
              ),
              Divider(),
              // SizedBox(
              //   height: 45,
              //   child: ExpansionTile(
              //     leading: Image.asset('assets/images/category/mt.png'),
              //     title: Text('정육·계란'),
              //     children: <Widget>[
              //       ListTile(dense: true, title: Text('전체보기')),
              //       ListTile(dense: true, title: Text('돼지고기')),
              //       ListTile(dense: true, title: Text('소고기')),
              //       ListTile(dense: true, title: Text('양고기')),
              //     ],
              //   ),
              // ),
              CateExpansionTile(),

              Divider(),
              SizedBox(
                height: 42,
                child: ListTile(
                  leading: Image.asset('assets/images/category/gch.png'),
                  title: Text('김치·반찬'),
                  onTap: () {},
                  trailing: Icon(Icons.keyboard_arrow_down),
                ),
              ),
              Divider(),
              SizedBox(
                height: 42,
                child: ListTile(
                  leading: Image.asset('assets/images/category/sc.png'),
                  title: Text('조미료·소스'),
                  onTap: () {},
                  trailing: Icon(Icons.keyboard_arrow_down),
                ),
              ),
              Divider(),
              SizedBox(
                height: 42,
                child: ListTile(
                  leading: Image.asset('assets/images/category/can.png'),
                  title: Text('통조림·캔'),
                  onTap: () {},
                  trailing: Icon(Icons.keyboard_arrow_down),
                ),
              ),
              Divider(),
              Container(
                margin: EdgeInsets.fromLTRB(3, 20, 0, 5),
                child: Text(
                  "항상 인기있는 식재료",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Padding(
                  padding: EdgeInsets.symmetric(vertical: 3.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(padding: EdgeInsets.symmetric(vertical: 3.0)),
                      CategoryBest()
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class CateExpansionTile extends StatefulWidget {
  const CateExpansionTile({super.key});

  @override
  _CateExpansionTileState createState() => _CateExpansionTileState();
}

class _CateExpansionTileState extends State<CateExpansionTile> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: isExpanded ? 300.0 : 42.0,
        child: ExpansionTile(
          onExpansionChanged: (value) {
            setState(() {
              isExpanded = value;
            });
          },
          leading: Image.asset('assets/images/category/mt.png'),
          title: Text("정육·계란"),
          children: <Widget>[
            ListTile(dense: true, title: Text('전체보기')),
            ListTile(dense: true, title: Text('돼지고기')),
            ListTile(dense: true, title: Text('소고기')),
            ListTile(dense: true, title: Text('양고기')),
          ],
        ));
  }
}
