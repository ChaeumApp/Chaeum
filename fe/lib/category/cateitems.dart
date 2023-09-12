import 'package:flutter/material.dart';

enum MenuType { first, second, thid }

class ItemsCatePage extends StatelessWidget {
  const ItemsCatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      childAspectRatio: 0.6,
      children: [
        for (int i = 1; i < 7; i++)
          Container(
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
                              "assets/images/repeat/top_logo.png",
                              width: 210,
                              height: 200,
                              fit: BoxFit.cover),
                        ))),
                Container(
                  width: 210,
                  margin: EdgeInsets.fromLTRB(10, 2, 10, 2),
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 1),
                    child: SizedBox(
                      height: 30,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.white,
                          side: BorderSide(
                            color: const Color(0xFFD9D9D9),
                            // width: 1,
                          ),
                          minimumSize: Size(210, 0),
                        ),
                        child: Text('알림설정'),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 2, 10, 2),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("바나나"),
                        // PopupMenuButton<MenuType>(
                        //   onSelected: (MenuType result) {
                        //     final SnackBar = SnackBar(
                        //       content: Text("$result is selected"),
                        //       );
                        //   },
                        //   itemBuilder: (BuildContext BuildContext) {
                        //     return [
                        //       for (final value in MenuType.values)
                        //       popupMenuItem(
                        //         value: value,
                        //         child: Text(value.toString()),
                        //       )
                        //     ];
                        //   }
                        //   )
                      ]),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
