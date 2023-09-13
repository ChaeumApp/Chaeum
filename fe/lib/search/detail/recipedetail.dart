import 'package:flutter/material.dart';


void main() {
  runApp(Recipedetail());
}

class Recipedetail extends StatefulWidget {
  Recipedetail({Key? key}) : super(key: key);

  @override
  State<Recipedetail> createState() => _RecipedetailState();
}

class _RecipedetailState extends State<Recipedetail> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Color(0xffA1CBA1),
          toolbarHeight: 55,
          title: Text('베이컨 치즈 토스트 레시피'),
          centerTitle: true,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(2),
          child: Column(
            children: [
              SizedBox(),
              SizedBox(
                height: 50,
                child: ListTile(
                  title: Text('베이컨 치즈 토스트 레시피(2인분)'),
                  trailing: Icon(Icons.keyboard_arrow_down),
                ),
              ),
              Divider(),
              SizedBox(
                height: 42,
                child: ListTile(
                  title: Text('재료'),
                  onTap: () {},
                  trailing: Icon(Icons.keyboard_arrow_down),
                ),
              ),
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
              ),

              SizedBox(
                height: 42,
              ),
              Divider(),
              Container(
                margin: EdgeInsets.fromLTRB(3, 20, 0, 5),
                child: Text(
                  "유사 레시피 추천",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              // const Padding(
              //     padding: EdgeInsets.symmetric(vertical: 3.0),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Padding(padding: EdgeInsets.symmetric(vertical: 3.0)),
              //       ],
              //     )),
            ],
          ),
        ),
      ),
    );
  }
}
