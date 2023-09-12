import 'package:fe/search/heart/heartpro.dart';
import 'package:flutter/material.dart';

enum MenuType { first, second, thid }

class Product extends StatelessWidget {
  const Product({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: GridView.count(
//         crossAxisCount: 2,
//         shrinkWrap: true,
//         childAspectRatio: 0.6,
//         children: [
//           for (int i = 1; i < 7; i++)
//             Container(
//               width: 250,
//               height: 250,
//               padding: EdgeInsets.symmetric(vertical: 5),
//               margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
//               child: Column(
//                 children: [
//                   InkWell(
//                       onTap: () {
//                         Navigator.pushNamed(context, "singleItemPage");
//                       },
//                       child: Container(
//                           margin: EdgeInsets.fromLTRB(10, 10, 10, 4),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(5),
//                             child: Image.asset("assets/images/main/nuts.png",
//                                 width: 180, height: 180, fit: BoxFit.cover),
//                           ))),
//                   Container(
//                     width: 210,
//                     margin: EdgeInsets.fromLTRB(10, 1, 10, 1),
//                     child: Padding(
//                       padding: EdgeInsets.only(bottom: 1),
//                       child: SizedBox(
//                         height: 18,
//                         child: Text("바나나",
//                             style: TextStyle(
//                               color: Colors.grey,
//                             )),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.fromLTRB(10, 1, 10, 1),
//                     child: Padding(
//                       padding: EdgeInsets.only(bottom: 1),
//                       child: Container(
//                         child: Text("과테말라 고당도 치키타 바나나 2.5kg",
//                             style: TextStyle(
//                               fontSize: 15,
//                               fontWeight: FontWeight.w600,
//                             )),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.fromLTRB(10, 1, 10, 1),
//                     child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text("9.240원",
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w800,
//                               )),
//                           Icon(
//                             Icons.favorite_border,
//                             // color: Colors.red,
//                             size: 22,
//                           )
//                         ]),
//                   ),
//                 ],
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

// class Product extends StatelessWidget {
//   const Product({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SliverToBoxAdapter(
//       child: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: Row(
//           children: [
//             for (int i = 1; i < 7; i++)
//               Container(
//                 width: 250,
//                 height: 250,
//                 padding: EdgeInsets.symmetric(vertical: 5),
//                 margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
//                 child: Column(
//                   children: [
//                     InkWell(
//                       onTap: () {
//                         Navigator.pushNamed(context, "singleItemPage");
//                       },
//                       child: Container(
//                         margin: EdgeInsets.fromLTRB(10, 10, 10, 4),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(5),
//                           child: Image.asset(
//                             "assets/images/main/nuts.png",
//                             width: 180,
//                             height: 180,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       width: 210,
//                       margin: EdgeInsets.fromLTRB(10, 1, 10, 1),
//                       child: Padding(
//                         padding: EdgeInsets.only(bottom: 1),
//                         child: SizedBox(
//                           height: 18,
//                           child: Text(
//                             "바나나",
//                             style: TextStyle(
//                               color: Colors.grey,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       margin: EdgeInsets.fromLTRB(10, 1, 10, 1),
//                       child: Padding(
//                         padding: EdgeInsets.only(bottom: 1),
//                         child: Container(
//                           child: Text(
//                             "과테말라 고당도 치키타 바나나 2.5kg",
//                             style: TextStyle(
//                               fontSize: 15,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       margin: EdgeInsets.fromLTRB(10, 1, 10, 1),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "9.240원",
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.w800,
//                             ),
//                           ),
//                           Icon(
//                             Icons.favorite_border,
//                             size: 22,
//                           )
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class Product extends StatelessWidget {
//   const Product({super.key, Key? key});

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
              return Consumer<HeartProvider>(
                  builder: (context, HeartProvider, child) {
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
                            child: Text("바나나",
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
                            child: Text("과테말라 고당도 치키타 바나나 2.5kg",
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
                              GestureDetector(
                                onTap: () {
                                  HeartProvider.onHeartTap();
                                },
                                child: AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 500),
                                    transitionBuilder: (child, animation) {
                                      return ScaleTransition(
                                        scale: animation,
                                        child: child,
                                      );
                                    },
                                    child: Icon(
                                      HeartProvider.animatedHeart
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      size: 22,
                                      color: HeartProvider.animatedHeart
                                          ? Colors.red
                                          : Colors.black,
                                    )),
                              )
                              // Icon(
                              //   Icons.favorite_border,
                              //   size: 22,
                              // )
                            ]),
                      ),
                    ],
                  ),
                );
              });
            },
            childCount: 6,
          ),
        ),
      ],
    );
  }
}
