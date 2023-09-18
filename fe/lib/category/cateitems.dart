import 'package:flutter/material.dart';

// enum MenuType { first, second, thid }

// class ItemsCatePage extends StatefulWidget {
//   const ItemsCatePage({super.key});

//   @override
//   State<ItemsCatePage> createState() => _ItemsCatePageState();
// }

// class _ItemsCatePageState extends State<ItemsCatePage> {
//   @override
//   Widget build(BuildContext context) {
//     return CustomScrollView(
//       slivers:[
//     SliverGrid(
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//       crossAxisCount: 2,
//       childAspectRatio: 0.6,),
//       delegate: SliverChildBuilderDelegate(
//       children: [
//         for (int i = 1; i < 7; i++)
//           Container(
//             width: 250,
//             height: 250,
//             padding: EdgeInsets.symmetric(vertical: 5),
//             margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
//             child: Column(
//               children: [
//                 InkWell(
//                     onTap: () {
//                       Navigator.pushNamed(context, "singleItemPage");
//                     },
//                     child: Container(
//                         margin: EdgeInsets.fromLTRB(10, 10, 10, 4),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(5),
//                           child: Image.asset(
//                               "assets/images/repeat/top_logo.png",
//                               width: 210,
//                               height: 200,
//                               fit: BoxFit.cover),
//                         ))),
//                 Container(
//                   width: 210,
//                   margin: EdgeInsets.fromLTRB(10, 2, 10, 2),
//                   child: Padding(
//                     padding: EdgeInsets.only(bottom: 1),
//                     child: SizedBox(
//                       height: 30,
//                       child: ElevatedButton.icon(
//                         onPressed: () {},
//                         style: ElevatedButton.styleFrom(
//                           foregroundColor: Colors.black,
//                           backgroundColor: Colors.white,
//                           side: BorderSide(
//                             color: const Color(0xFFD9D9D9),
//                             // width: 1,
//                           ),
//                           minimumSize: Size(210, 0),
//                         ),
//                         label: Text('알림설정'),
//                         icon: Icon(Icons.shopping_cart),
//                         // child: Text('알림설정'),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.fromLTRB(10, 2, 10, 2),
//                   child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text("바나나"),
//                         // PopupMenuButton<MenuType>(
//                         //   onSelected: (MenuType result) {
//                         //     final SnackBar = SnackBar(
//                         //       content: Text("$result is selected"),
//                         //       );
//                         //   },
//                         //   itemBuilder: (BuildContext BuildContext) {
//                         //     return [
//                         //       for (final value in MenuType.values)
//                         //       popupMenuItem(
//                         //         value: value,
//                         //         child: Text(value.toString()),
//                         //       )
//                         //     ];
//                         //   }
//                         //   )
//                       ]),
//                 ),
//               ],
//             ),
//           ),
//       ],
//     )
//       ]
//     );

//   }
// }

// enum MenuType { first, second, third }

// class ItemsCatePage extends StatefulWidget {
//   const ItemsCatePage({super.key});

//   @override
//   State<ItemsCatePage> createState() => _ItemsCatePageState();
// }

// class _ItemsCatePageState extends State<ItemsCatePage> {
//   @override
//   Widget build(BuildContext context) {
//     return CustomScrollView(
//       slivers: [
//         SliverGrid(
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             childAspectRatio: 0.6,
//           ),
//           delegate: SliverChildBuilderDelegate(
//             (BuildContext context, int index) {
//               return Container(
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
//                             "assets/images/repeat/top_logo.png",
//                             width: 210,
//                             height: 200,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       width: 210,
//                       margin: EdgeInsets.fromLTRB(10, 2, 10, 2),
//                       child: Padding(
//                         padding: EdgeInsets.only(bottom: 1),
//                         child: ElevatedButton.icon(
//                           onPressed: () {},
//                           style: ElevatedButton.styleFrom(
//                             primary: Colors.white,
//                             onPrimary: Colors.black,
//                             side: BorderSide(
//                               color: const Color(0xFFD9D9D9),
//                             ),
//                             minimumSize: Size(210, 0),
//                           ),
//                           label: Text('알림설정'),
//                           icon: Icon(Icons.shopping_cart),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       margin: EdgeInsets.fromLTRB(10, 2, 10, 2),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text("바나나"),
//                           // PopupMenuButton<MenuType>(
//                           //   onSelected: (MenuType result) {
//                           //     final snackBar = SnackBar(
//                           //       content: Text("$result is selected"),
//                           //     );
//                           //     ScaffoldMessenger.of(context)
//                           //         .showSnackBar(snackBar);
//                           //   },
//                           //   itemBuilder: (BuildContext context) {
//                           //     return [
//                           //       for (final value in MenuType.values)
//                           //         PopupMenuItem(
//                           //           value: value,
//                           //           child: Text(value.toString()),
//                           //         )
//                           //     ];
//                           //   },
//                           // ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//             childCount: 6,
//           ),
//         ),
//       ],
//     );
//   }
// }

// class ItemsCatePage extends StatefulWidget {
//   const ItemsCatePage({super.key});

//   @override
//   State<ItemsCatePage> createState() => _ItemsCatePageState();
// }

// class _ItemsCatePageState extends State<ItemsCatePage> {
//   bool isAlarmed = false;

//   void toggleAlarm() {
//     setState(() {
//       isAlarmed = !isAlarmed;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CustomScrollView(
//       slivers: [
//         SliverGrid(
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             childAspectRatio: 0.6,
//           ),
//           delegate: SliverChildBuilderDelegate(
//             (BuildContext context, int index) {
//               return Container(
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
//                             "assets/images/repeat/top_logo.png",
//                             width: 210,
//                             height: 200,
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
//                           child: Text("바나나",
//                               style: TextStyle(
//                                 color: Colors.grey,
//                               )),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       margin: EdgeInsets.fromLTRB(10, 1, 10, 1),
//                       child: Padding(
//                         padding: EdgeInsets.only(bottom: 1),
//                         child: Container(
//                           child: Text("과테말라 고당도 치키타 바나나 2.5kg",
//                               style: TextStyle(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w600,
//                               )),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       margin: EdgeInsets.fromLTRB(10, 1, 10, 1),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text("9.240원",
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w800,
//                               )),
//                           IconButton(
//                             icon: Icon(
//                               isAlarmed
//                                   ? Icons.favorite
//                                   : Icons.favorite_border,
//                               color: Colors.red[500],
//                             ),
//                             onPressed: toggleAlarm,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//             childCount: 6,
//           ),
//         ),
//       ],
//     );
//   }
// }

// class ItemsCatePage extends StatefulWidget {
//   const ItemsCatePage({Key? key}) : super(key: key);

//   @override
//   State<ItemsCatePage> createState() => _ItemsCatePageState();
// }

// class _ItemsCatePageState extends State<ItemsCatePage> {
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: 6, // 항목 수
//       itemBuilder: (BuildContext context, int index) {
//         return Container(
//           width: 250,
//           height: 250,
//           padding: EdgeInsets.symmetric(vertical: 5),
//           margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
//           child: Column(
//             children: [
//               InkWell(
//                 onTap: () {
//                   Navigator.pushNamed(context, "singleItemPage");
//                 },
//                 child: Container(
//                   margin: EdgeInsets.fromLTRB(10, 10, 10, 4),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(5),
//                     child: Image.asset(
//                       "assets/images/repeat/top_logo.png",
//                       width: 210,
//                       height: 200,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 width: 210,
//                 margin: EdgeInsets.fromLTRB(10, 2, 10, 2),
//                 child: Padding(
//                   padding: EdgeInsets.only(bottom: 1),
//                   child: ElevatedButton.icon(
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                       : Colors.white,
//                       onPrimary: Colors.black,
//                       side: BorderSide(
//                         color: const Color(0xFFD9D9D9),
//                       ),
//                       minimumSize: Size(210, 0),
//                     ),
//                     label: Text('알림설정'),
//                     icon: Icon(Icons.shopping_cart),
//                   ),
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.fromLTRB(10, 2, 10, 2),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text("바나나"),
//                     // PopupMenuButton<MenuType>(
//                     //   onSelected: (MenuType result) {
//                     //     final snackBar = SnackBar(
//                     //       content: Text("$result is selected"),
//                     //     );
//                     //     ScaffoldMessenger.of(context)
//                     //         .showSnackBar(snackBar);
//                     //   },
//                     //   itemBuilder: (BuildContext context) {
//                     //     return [
//                     //       for (final value in MenuType.values)
//                     //         PopupMenuItem(
//                     //           value: value,
//                     //           child: Text(value.toString()),
//                     //         )
//                     //     ];
//                     //   },
//                     // ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

// class ItemsCatePage extends StatefulWidget {
//   const ItemsCatePage({Key? key}) : super(key: key);

//   @override
//   State<ItemsCatePage> createState() => _ItemsCatePageState();
// }

// class _ItemsCatePageState extends State<ItemsCatePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(children: [
//       Expanded(
//           child: ListView.builder(
//         itemCount: 6,
//         itemBuilder: (BuildContext context, int index) {
//           return Container(
//             padding: EdgeInsets.symmetric(vertical: 5),
//             margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
//             child: Column(
//               children: [
//                 InkWell(
//                   onTap: () {
//                     // Navigator.pushNamed(context, "singleItemPage");
//                   },
//                   child: Container(
//                     margin: EdgeInsets.fromLTRB(10, 10, 10, 4),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(5),
//                       child: Image.asset(
//                         "assets/images/repeat/top_logo.png",
//                         width: 210,
//                         height: 200,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   width: 210,
//                   margin: EdgeInsets.fromLTRB(10, 2, 10, 2),
//                   child: Padding(
//                     padding: EdgeInsets.only(bottom: 1),
//                     child: ElevatedButton.icon(
//                       onPressed: () {},
//                       style: ElevatedButton.styleFrom(
//                         // primary: Colors.white,
//                         // onPrimary: Colors.black,
//                         side: BorderSide(
//                           color: const Color(0xFFD9D9D9),
//                         ),
//                         minimumSize: Size(210, 0),
//                       ),
//                       label: Text('알림설정'),
//                       icon: Icon(Icons.shopping_cart),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.fromLTRB(10, 2, 10, 2),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text("바나나"),
//                       // PopupMenuButton<MenuType>(
//                       //   onSelected: (MenuType result) {
//                       //     final snackBar = SnackBar(
//                       //       content: Text("$result is selected"),
//                       //     );
//                       //     ScaffoldMessenger.of(context)
//                       //         .showSnackBar(snackBar);
//                       //   },
//                       //   itemBuilder: (BuildContext context) {
//                       //     return [
//                       //       for (final value in MenuType.values)
//                       //         PopupMenuItem(
//                       //           value: value,
//                       //           child: Text(value.toString()),
//                       //         )
//                       //     ];
//                       //   },
//                       // ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ))
//     ]);
//   }
// }

// class ItemsCatePage extends StatelessWidget {
//   const ItemsCatePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//       ),
//       itemBuilder: (BuildContext context, int index) {
//         return Container(
//           padding: EdgeInsets.symmetric(vertical: 5),
//           margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
//           child: Column(
//             children: [
//               InkWell(
//                 onTap: () {
//                   Navigator.pushNamed(context, "");
//                 },
//                 child: Container(
//                   margin: EdgeInsets.fromLTRB(10, 10, 10, 4),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(5),
//                     child: Image.asset(
//                       "assets/images/repeat/top_logo.png",
//                       width: 210,
//                       height: 200,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 width: 210,
//                 margin: EdgeInsets.fromLTRB(10, 2, 10, 2),
//                 child: Padding(
//                   padding: EdgeInsets.only(bottom: 1),
//                   child: ElevatedButton.icon(
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                       side: BorderSide(
//                         color: const Color(0xFFD9D9D9),
//                       ),
//                       minimumSize: Size(210, 0),
//                     ),
//                     label: Text('알림설정'),
//                     icon: Icon(Icons.shopping_cart),
//                   ),
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.fromLTRB(10, 2, 10, 2),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text("바나나"),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//       itemCount: 6, // 아이템 개수 설정
//     );
//   }
// }

// class ItemsCatePage extends StatelessWidget {
//   const ItemsCatePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GridView.count(
//       physics: ScrollPhysics(),
//       scrollDirection: Axis.vertical,
//       crossAxisCount: 2,
//       shrinkWrap: true,
//       childAspectRatio: 0.6,
//       children: [
//         for (int i = 1; i < 7; i++)
//           Container(
//             width: 250,
//             height: 250,
//             padding: EdgeInsets.symmetric(vertical: 5),
//             margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
//             child: Column(
//               children: [
//                 InkWell(
//                     onTap: () {
//                       Navigator.pushNamed(context, "singleItemPage");
//                     },
//                     child: Container(
//                         margin: EdgeInsets.fromLTRB(10, 10, 10, 4),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(5),
//                           child: Image.asset(
//                               "assets/images/repeat/top_logo.png",
//                               width: 210,
//                               height: 200,
//                               fit: BoxFit.cover),
//                         ))),
//                 Container(
//                   width: 210,
//                   margin: EdgeInsets.fromLTRB(10, 2, 10, 2),
//                   child: Padding(
//                     padding: EdgeInsets.only(bottom: 1),
//                     child: SizedBox(
//                       height: 30,
//                       child: ElevatedButton(
//                         onPressed: () {},
//                         style: ElevatedButton.styleFrom(
//                           foregroundColor: Colors.black,
//                           backgroundColor: Colors.white,
//                           side: BorderSide(
//                             color: const Color(0xFFD9D9D9),
//                             // width: 1,
//                           ),
//                           minimumSize: Size(210, 0),
//                         ),
//                         child: Text('알림설정'),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.fromLTRB(10, 2, 10, 2),
//                   child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text("바나나"),
//                         // PopupMenuButton<MenuType>(
//                         //   onSelected: (MenuType result) {
//                         //     final SnackBar = SnackBar(
//                         //       content: Text("$result is selected"),
//                         //       );
//                         //   },
//                         //   itemBuilder: (BuildContext BuildContext) {
//                         //     return [
//                         //       for (final value in MenuType.values)
//                         //       popupMenuItem(
//                         //         value: value,
//                         //         child: Text(value.toString()),
//                         //       )
//                         //     ];
//                         //   }
//                         //   )
//                       ]),
//                 ),
//               ],
//             ),
//           ),
//       ],
//     );
//   }
// }

class ItemsCatePage extends StatefulWidget {
  const ItemsCatePage({Key? key}) : super(key: key);

  @override
  State<ItemsCatePage> createState() => _ItemsCatePageState();
}

class _ItemsCatePageState extends State<ItemsCatePage> {
  bool alarmPressed = false;
  Color customColor = Color(0xFFA1CBA1);
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: ScrollPhysics(),
      scrollDirection: Axis.vertical,
      crossAxisCount: 2,
      shrinkWrap: true,
      childAspectRatio: 0.6,
      children: [
        for (int i = 1; i < 7; i++)
          Container(
            width: 260,
            height: 260,
            padding: EdgeInsets.symmetric(vertical: 5),
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "singleItemPage");
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(10, 2, 10, 4),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.asset(
                        "assets/images/category/uuuu.jpg",
                        width: 210,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 210,
                  margin: EdgeInsets.fromLTRB(10, 2, 10, 0),
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 1),
                    child: SizedBox(
                      height: 30,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            alarmPressed = !alarmPressed;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor:
                              alarmPressed ? Colors.white : Colors.black,
                          backgroundColor:
                              alarmPressed ? customColor : Colors.white,
                          side: BorderSide(
                            color: const Color(0xFFD9D9D9),
                            // width: 1,
                          ),
                          minimumSize: Size(210, 0),
                        ),
                        label: Text(
                          '알림설정',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                        icon: Icon(Icons.shopping_cart_outlined),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("바나나",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                          )),
                      PopupMenuButton<String>(
                        onSelected: (String result) {
                          // 팝업 메뉴에서 선택한 결과 처리
                          final snackBar = SnackBar(
                            content: Text("$result 바나나에 대한 추천을 받지 않습니다."),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        itemBuilder: (BuildContext context) {
                          return [
                            PopupMenuItem<String>(
                              value: "옵션 1",
                              child: Text("관심없음"),
                            ),
                            // PopupMenuItem<String>(
                            //   value: "옵션 2",
                            //   child: Text("옵션 2"),
                            // ),
                          ];
                        },
                        icon: Icon(Icons.more_vert), // 팝업 메뉴 아이콘
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
