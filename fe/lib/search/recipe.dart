import 'package:flutter/material.dart';
import '../search/detail/recipedetail.dart';

class Recipe extends StatefulWidget {
  const Recipe({super.key});

  @override
  State<Recipe> createState() => _RecipeState();
}

class _RecipeState extends State<Recipe> {
  bool isFavorited = false;

  void _toggleFavorite() {
    setState(() {
      isFavorited = !isFavorited;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.6,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                width: 250,
                height: 250,
                padding: EdgeInsets.symmetric(vertical: 5),
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Recipedetail()));
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(10, 10, 10, 4),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.asset(
                            "assets/images/main/nuts.png",
                            width: 180,
                            height: 180,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 210,
                      margin: EdgeInsets.fromLTRB(10, 1, 10, 1),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 1),
                        child: SizedBox(
                          height: 18,
                          child: Text("디저트",
                              style: TextStyle(
                                color: Colors.grey,
                              )),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 1, 10, 0),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 1),
                        child: Container(
                          child: Text("베이컨 블루치즈 크림토스트",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("9.240원",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              )),
                          IconButton(
                            icon: Icon(
                              isFavorited
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.red[500],
                            ),
                            onPressed: _toggleFavorite,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            childCount: 6,
          ),
        ),
      ],
    );
  }
}
