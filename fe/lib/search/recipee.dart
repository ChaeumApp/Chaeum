import 'package:flutter/material.dart';

class Recipee extends StatelessWidget {
  const Recipee ({super.key});

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
                        Navigator.pushNamed(context, "singleItemPage");
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
                      margin: EdgeInsets.fromLTRB(10, 1, 10, 1),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 1),
                        child: Container(
                          child: Text("베이컨 치즈 토스트",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 1, 10, 1),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("9.240원",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                )),
                            Icon(
                              Icons.favorite_border,
                              size: 22,
                            )
                          ]),
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
