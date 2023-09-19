// import 'package:flutter/material.dart';
// // import './popular_product.dart';
// import './catepage.dart';

// class Ingrecate extends StatelessWidget {
//   Ingrecate({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         resizeToAvoidBottomInset: false,
//         appBar: AppBar(
//           backgroundColor: Colors.grey[50],
//           toolbarHeight: 55,
//           title: Text('식재료 카테고리'),
//           centerTitle: true,
//           elevation: 0,
//         ),
//         body: SingleChildScrollView(
//           physics: const BouncingScrollPhysics(),
//           padding: const EdgeInsets.all(2),
//           child: Column(
//             children: [
//               SizedBox(
//                 height: 48,
//                 child: ListTile(
//                   leading: Image.asset('assets/images/category/fr.png'),
//                   title: Text('과일'),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => CatePage()),
//                     );
//                   },
//                   trailing: Icon(Icons.keyboard_arrow_down),
//                 ),
//               ),
//               Divider(),
//               SizedBox(
//                 height: 43,
//                 child: ListTile(
//                   leading: Image.asset('assets/images/category/vg.png'),
//                   title: Text('채소'),
//                   onTap: () {},
//                   trailing: Icon(Icons.keyboard_arrow_down),
//                 ),
//               ),
//               Divider(),
//               SizedBox(
//                 height: 43,
//                 child: ListTile(
//                   leading: Image.asset('assets/images/category/pn.png'),
//                   title: Text('곡류/견과'),
//                   onTap: () {},
//                   trailing: Icon(Icons.keyboard_arrow_down),
//                 ),
//               ),
//               Divider(),
//               CateExpansionTile(),
//               Divider(),
//               SizedBox(
//                 height: 43,
//                 child: ListTile(
//                   leading: Image.asset('assets/images/category/fsh.png'),
//                   title: Text('수산물'),
//                   onTap: () {},
//                   trailing: Icon(Icons.keyboard_arrow_down),
//                 ),
//               ),
//               Divider(),
//               SizedBox(
//                 height: 43,
//                 child: ListTile(
//                   leading: Image.asset('assets/images/category/fsh.png'),
//                   title: Text('유제품'),
//                   onTap: () {},
//                   trailing: Icon(Icons.keyboard_arrow_down),
//                 ),
//               ),
//               Divider(),
//               SizedBox(
//                 height: 43,
//                 child: ListTile(
//                   leading: Image.asset('assets/images/category/gch.png'),
//                   title: Text('김치'),
//                   onTap: () {},
//                   trailing: Icon(Icons.keyboard_arrow_down),
//                 ),
//               ),
//               Divider(),
//               SizedBox(
//                 height: 43,
//                 child: ListTile(
//                   leading: Image.asset('assets/images/category/gch.png'),
//                   title: Text('면/파스타'),
//                   onTap: () {},
//                   trailing: Icon(Icons.keyboard_arrow_down),
//                 ),
//               ),
//               Divider(),
//               SizedBox(
//                 height: 43,
//                 child: ListTile(
//                   leading: Image.asset('assets/images/category/can.png'),
//                   title: Text('통조림'),
//                   onTap: () {},
//                   trailing: Icon(Icons.keyboard_arrow_down),
//                 ),
//               ),
//               Divider(),
//               SizedBox(
//                 height: 43,
//                 child: ListTile(
//                   leading: Image.asset('assets/images/category/sc.png'),
//                   title: Text('가루/조미료'),
//                   onTap: () {},
//                   trailing: Icon(Icons.keyboard_arrow_down),
//                 ),
//               ),
//               Divider(),
//               SizedBox(
//                 height: 43,
//                 child: ListTile(
//                   leading: Image.asset('assets/images/category/sc.png'),
//                   title: Text('오일/소스'),
//                   onTap: () {},
//                   trailing: Icon(Icons.keyboard_arrow_down),
//                 ),
//               ),
//               Divider(),
//               SizedBox(
//                 height: 43,
//                 child: ListTile(
//                   leading: Image.asset('assets/images/category/sc.png'),
//                   title: Text('빵/잼'),
//                   onTap: () {},
//                   trailing: Icon(Icons.keyboard_arrow_down),
//                 ),
//               ),
//               Divider(),
//               // Container(
//               //   margin: EdgeInsets.fromLTRB(3, 20, 0, 5),
//               //   child: Text(
//               //     "항상 인기있는 식재료",
//               //     style: TextStyle(
//               //       fontSize: 18,
//               //       fontWeight: FontWeight.w700,
//               //     ),
//               //   ),
//               // ),
//               // const Padding(
//               //     padding: EdgeInsets.symmetric(vertical: 3.0),
//               //     child: Column(
//               //       crossAxisAlignment: CrossAxisAlignment.start,
//               //       children: [
//               //         Padding(padding: EdgeInsets.symmetric(vertical: 3.0)),
//               //         CategoryBest()
//               //       ],
//               //     )),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CateExpansionTile extends StatefulWidget {
//   const CateExpansionTile({super.key});

//   @override
//   _CateExpansionTileState createState() => _CateExpansionTileState();
// }

// class _CateExpansionTileState extends State<CateExpansionTile> {
//   bool isExpanded = false;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//         height: isExpanded ? 240.0 : 43.0,
//         child: ExpansionTile(
//           onExpansionChanged: (value) {
//             setState(() {
//               isExpanded = value;
//             });
//           },
//           leading: Image.asset('assets/images/category/mt.png'),
//           title: Text("정육·계란"),
//           children: <Widget>[
//             ListTile(dense: true, title: Text('소고기')),
//             ListTile(dense: true, title: Text('돼지고기')),
//             ListTile(dense: true, title: Text('닭고기')),
//             ListTile(dense: true, title: Text('오리고기')),
//             ListTile(dense: true, title: Text('양고기')),
//             ListTile(dense: true, title: Text('달걀')),
//           ],
//         ));
//   }
// }

// import 'package:flutter/material.dart';
// import './catepage.dart';

// class Ingrecate extends StatelessWidget {
//   Ingrecate({super.key});
//   bool isExpanded = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         backgroundColor: Colors.grey[50],
//         toolbarHeight: 55,
//         title: Text('식재료 카테고리'),
//         centerTitle: true,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         padding: const EdgeInsets.all(2),
//         child: Column(
//           children: [
//             SizedBox(
//               height: 48,
//               child: ListTile(
//                 leading: Image.asset('assets/images/category/fr.png'),
//                 title: Text('과일'),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => CatePage()),
//                   );
//                 },
//                 trailing: Icon(Icons.keyboard_arrow_down),
//               ),
//             ),
//             Divider(),
//             SizedBox(
//               height: 43,
//               child: ListTile(
//                 leading: Image.asset('assets/images/category/vg.png'),
//                 title: Text('채소'),
//                 onTap: () {},
//                 trailing: Icon(Icons.keyboard_arrow_down),
//               ),
//             ),
//             Divider(),
//             SizedBox(
//               height: 43,
//               child: ListTile(
//                 leading: Image.asset('assets/images/category/pn.png'),
//                 title: Text('곡류/견과'),
//                 onTap: () {},
//                 trailing: Icon(Icons.keyboard_arrow_down),
//               ),
//             ),
//             Divider(),
//             ExpansionTile(
//               leading: Image.asset('assets/images/category/mt.png'),
//               title: Text("정육·계란"),
//               children: <Widget>[
//                 ListTile(dense: true, title: Text('소고기')),
//                 ListTile(dense: true, title: Text('돼지고기')),
//                 ListTile(dense: true, title: Text('닭고기')),
//                 ListTile(dense: true, title: Text('오리고기')),
//                 ListTile(dense: true, title: Text('양고기')),
//                 ListTile(dense: true, title: Text('달걀')),
//               ],
//             ),
//             Divider(),
//             SizedBox(
//               height: 43,
//               child: ListTile(
//                 leading: Image.asset('assets/images/category/fsh.png'),
//                 title: Text('수산물'),
//                 onTap: () {},
//                 trailing: Icon(Icons.keyboard_arrow_down),
//               ),
//             ),
//             Divider(),
//             SizedBox(
//               height: 43,
//               child: ListTile(
//                 leading: Image.asset('assets/images/category/fsh.png'),
//                 title: Text('유제품'),
//                 onTap: () {},
//                 trailing: Icon(Icons.keyboard_arrow_down),
//               ),
//             ),
//             Divider(),
//             SizedBox(
//               height: 43,
//               child: ListTile(
//                 leading: Image.asset('assets/images/category/gch.png'),
//                 title: Text('김치'),
//                 onTap: () {},
//                 trailing: Icon(Icons.keyboard_arrow_down),
//               ),
//             ),
//             Divider(),
//             SizedBox(
//               height: 43,
//               child: ListTile(
//                 leading: Image.asset('assets/images/category/gch.png'),
//                 title: Text('면/파스타'),
//                 onTap: () {},
//                 trailing: Icon(Icons.keyboard_arrow_down),
//               ),
//             ),
//             Divider(),
//             SizedBox(
//               height: 43,
//               child: ListTile(
//                 leading: Image.asset('assets/images/category/can.png'),
//                 title: Text('통조림'),
//                 onTap: () {},
//                 trailing: Icon(Icons.keyboard_arrow_down),
//               ),
//             ),
//             Divider(),
//             SizedBox(
//               height: 43,
//               child: ListTile(
//                 leading: Image.asset('assets/images/category/sc.png'),
//                 title: Text('가루/조미료'),
//                 onTap: () {},
//                 trailing: Icon(Icons.keyboard_arrow_down),
//               ),
//             ),
//             Divider(),
//             SizedBox(
//               height: 43,
//               child: ListTile(
//                 leading: Image.asset('assets/images/category/sc.png'),
//                 title: Text('오일/소스'),
//                 onTap: () {},
//                 trailing: Icon(Icons.keyboard_arrow_down),
//               ),
//             ),
//             Divider(),
//             SizedBox(
//               height: 43,
//               child: ListTile(
//                 leading: Image.asset('assets/images/category/sc.png'),
//                 title: Text('빵/잼'),
//                 onTap: () {},
//                 trailing: Icon(Icons.keyboard_arrow_down),
//               ),
//             ),
//             Divider(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import './catepage.dart';

// class Ingrecate extends StatelessWidget {
//   Ingrecate({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         resizeToAvoidBottomInset: false,
//         appBar: AppBar(
//           backgroundColor: Colors.grey[50],
//           toolbarHeight: 55,
//           title: Text('식재료 카테고리'),
//           centerTitle: true,
//           elevation: 0,
//         ),
//         body: SingleChildScrollView(
//           physics: const BouncingScrollPhysics(),
//           padding: const EdgeInsets.all(2),
//           child: Column(
//             children: [
//               SizedBox(
//                 height: 48,
//                 child: ListTile(
//                   leading: Image.asset('assets/images/category/fr.png'),
//                   title: Text('과일'),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => CatePage()),
//                     );
//                   },
//                   trailing: Icon(Icons.keyboard_arrow_down),
//                 ),
//               ),
//               Divider(),
//               SizedBox(
//                 height: 43,
//                 child: ListTile(
//                   leading: Image.asset('assets/images/category/vg.png'),
//                   title: Text('채소'),
//                   onTap: () {},
//                   trailing: Icon(Icons.keyboard_arrow_down),
//                 ),
//               ),
//               Divider(),
//               SizedBox(
//                 height: 43,
//                 child: ListTile(
//                   leading: Image.asset('assets/images/category/pn.png'),
//                   title: Text('곡류/견과'),
//                   onTap: () {},
//                   trailing: Icon(Icons.keyboard_arrow_down),
//                 ),
//               ),
//               Divider(),
//               CateExpansionTile(),
//               Divider(),
//               SizedBox(
//                 height: 43,
//                 child: ListTile(
//                   leading: Image.asset('assets/images/category/fsh.png'),
//                   title: Text('수산물'),
//                   onTap: () {},
//                   trailing: Icon(Icons.keyboard_arrow_down),
//                 ),
//               ),
//               Divider(),
//               SizedBox(
//                 height: 43,
//                 child: ListTile(
//                   leading: Image.asset('assets/images/category/fsh.png'),
//                   title: Text('유제품'),
//                   onTap: () {},
//                   trailing: Icon(Icons.keyboard_arrow_down),
//                 ),
//               ),
//               Divider(),
//               SizedBox(
//                 height: 43,
//                 child: ListTile(
//                   leading: Image.asset('assets/images/category/gch.png'),
//                   title: Text('김치'),
//                   onTap: () {},
//                   trailing: Icon(Icons.keyboard_arrow_down),
//                 ),
//               ),
//               Divider(),
//               SizedBox(
//                 height: 43,
//                 child: ListTile(
//                   leading: Image.asset('assets/images/category/gch.png'),
//                   title: Text('면/파스타'),
//                   onTap: () {},
//                   trailing: Icon(Icons.keyboard_arrow_down),
//                 ),
//               ),
//               Divider(),
//               SizedBox(
//                 height: 43,
//                 child: ListTile(
//                   leading: Image.asset('assets/images/category/can.png'),
//                   title: Text('통조림'),
//                   onTap: () {},
//                   trailing: Icon(Icons.keyboard_arrow_down),
//                 ),
//               ),
//               Divider(),
//               SizedBox(
//                 height: 43,
//                 child: ListTile(
//                   leading: Image.asset('assets/images/category/sc.png'),
//                   title: Text('가루/조미료'),
//                   onTap: () {},
//                   trailing: Icon(Icons.keyboard_arrow_down),
//                 ),
//               ),
//               Divider(),
//               SizedBox(
//                 height: 43,
//                 child: ListTile(
//                   leading: Image.asset('assets/images/category/sc.png'),
//                   title: Text('오일/소스'),
//                   onTap: () {},
//                   trailing: Icon(Icons.keyboard_arrow_down),
//                 ),
//               ),
//               Divider(),
//               SizedBox(
//                 height: 43,
//                 child: ListTile(
//                   leading: Image.asset('assets/images/category/sc.png'),
//                   title: Text('빵/잼'),
//                   onTap: () {},
//                   trailing: Icon(Icons.keyboard_arrow_down),
//                 ),
//               ),
//               Divider(),
//               // Container(
//               //   margin: EdgeInsets.fromLTRB(3, 20, 0, 5),
//               //   child: Text(
//               //     "항상 인기있는 식재료",
//               //     style: TextStyle(
//               //       fontSize: 18,
//               //       fontWeight: FontWeight.w700,
//               //     ),
//               //   ),
//               // ),
//               // const Padding(
//               //     padding: EdgeInsets.symmetric(vertical: 3.0),
//               //     child: Column(
//               //       crossAxisAlignment: CrossAxisAlignment.start,
//               //       children: [
//               //         Padding(padding: EdgeInsets.symmetric(vertical: 3.0)),
//               //         CategoryBest()
//               //       ],
//               //     )),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CateExpansionTile extends StatefulWidget {
//   const CateExpansionTile({super.key});

//   @override
//   _CateExpansionTileState createState() => _CateExpansionTileState();
// }

// class _CateExpansionTileState extends State<CateExpansionTile> {
//   bool isExpanded = false;

//   @override
//   Widget build(BuildContext context) {
//     return ExpansionTile(
//       onExpansionChanged: (value) {
//         setState(() {
//           isExpanded = value;
//         });
//       },
//       leading: Image.asset('assets/images/category/mt.png'),
//       title: Text("정육·계란"),
//       children: <Widget>[
//         ListTile(dense: true, title: Text('소고기')),
//         ListTile(dense: true, title: Text('돼지고기')),
//         ListTile(dense: true, title: Text('닭고기')),
//         ListTile(dense: true, title: Text('오리고기')),
//         ListTile(dense: true, title: Text('양고기')),
//         ListTile(dense: true, title: Text('달걀')),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import './catepage.dart';

class Ingrecate extends StatelessWidget {
  Ingrecate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        toolbarHeight: 55,
        title: Text('식재료 카테고리'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(2),
        child: Column(
          children: [
            SizedBox(
              height: 45,
              child: ListTile(
                leading: Image.asset('assets/images/category/fr.png'),
                title: Text('과일'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CatePage(num: 1, cate: '과일')),
                  );
                },
                trailing: Icon(Icons.keyboard_arrow_down),
              ),
            ),
            Divider(),
            SizedBox(
              height: 43,
              child: ListTile(
                leading: Image.asset('assets/images/category/vg.png'),
                title: Text('채소'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CatePage(num: 2, cate: '채소')),
                  );
                },
                trailing: Icon(Icons.keyboard_arrow_down),
              ),
            ),
            Divider(),
            SizedBox(
              height: 43,
              child: ListTile(
                leading: Image.asset('assets/images/category/pn.png'),
                title: Text('곡류/견과'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CatePage(num: 3, cate: '곡류/견과')),
                  );
                },
                trailing: Icon(Icons.keyboard_arrow_down),
              ),
            ),
            Divider(),
            MyExpansionTile(),
            Divider(),
            SizedBox(
              height: 43,
              child: ListTile(
                leading: Image.asset('assets/images/category/fsh.png'),
                title: Text('수산물'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CatePage(num: 5, cate: '수산물')),
                  );
                },
                trailing: Icon(Icons.keyboard_arrow_down),
              ),
            ),
            Divider(),
            SizedBox(
              height: 43,
              child: ListTile(
                leading: Image.asset('assets/images/category/fsh.png'),
                title: Text('유제품'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CatePage(num: 6, cate: '유제품')),
                  );
                },
                trailing: Icon(Icons.keyboard_arrow_down),
              ),
            ),
            Divider(),
            SizedBox(
              height: 43,
              child: ListTile(
                leading: Image.asset('assets/images/category/gch.png'),
                title: Text('김치'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CatePage(num: 7, cate: '김치')),
                  );
                },
                trailing: Icon(Icons.keyboard_arrow_down),
              ),
            ),
            Divider(),
            SizedBox(
              height: 43,
              child: ListTile(
                leading: Image.asset('assets/images/category/gch.png'),
                title: Text('면/파스타'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CatePage(num: 8, cate: '면/파스타')),
                  );
                },
                trailing: Icon(Icons.keyboard_arrow_down),
              ),
            ),
            Divider(),
            SizedBox(
              height: 43,
              child: ListTile(
                leading: Image.asset('assets/images/category/can.png'),
                title: Text('통조림'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CatePage(num: 9, cate: '통조림')),
                  );
                },
                trailing: Icon(Icons.keyboard_arrow_down),
              ),
            ),
            Divider(),
            SizedBox(
              height: 43,
              child: ListTile(
                leading: Image.asset('assets/images/category/sc.png'),
                title: Text('가루/조미료'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CatePage(num: 10, cate: '가루/조미료')),
                  );
                },
                trailing: Icon(Icons.keyboard_arrow_down),
              ),
            ),
            Divider(),
            SizedBox(
              height: 43,
              child: ListTile(
                leading: Image.asset('assets/images/category/sc.png'),
                title: Text('오일/소스'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CatePage(num: 11, cate: '오일/소스')),
                  );
                },
                trailing: Icon(Icons.keyboard_arrow_down),
              ),
            ),
            Divider(),
            SizedBox(
              height: 43,
              child: ListTile(
                leading: Image.asset('assets/images/category/sc.png'),
                title: Text('빵/잼'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CatePage(num: 12, cate: '빵/잼')),
                  );
                },
                trailing: Icon(Icons.keyboard_arrow_down),
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}

class MyExpansionTile extends StatefulWidget {
  const MyExpansionTile({super.key});

  @override
  _MyExpansionTileState createState() => _MyExpansionTileState();
}

class _MyExpansionTileState extends State<MyExpansionTile> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          // contentPadding: EdgeInsets.symmetric(vertical: 0),
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          leading: Image.asset('assets/images/category/mt.png'),
          title: Text("정육·계란"),
          trailing: isExpanded
              ? Icon(Icons.keyboard_arrow_up)
              : Icon(Icons.keyboard_arrow_down),
        ),
        if (isExpanded) ...[
          ListTile(
            dense: true,
            title: Text('소고기'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CatePage(num: 4, subnum: 1, cate: '소고기')),
              );
            },
          ),
          ListTile(
            dense: true,
            title: Text('돼지고기'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CatePage(num: 4, subnum: 2, cate: '돼지고기')),
              );
            },
          ),
          ListTile(
            dense: true,
            title: Text('닭고기'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CatePage(num: 4, subnum: 3, cate: '닭고기')),
              );
            },
          ),
          ListTile(
            dense: true,
            title: Text('오리고기'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CatePage(num: 4, subnum: 4, cate: '오리고기')),
              );
            },
          ),
          ListTile(
            dense: true,
            title: Text('양고기'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CatePage(num: 4, subnum: 5, cate: '양고기')),
              );
            },
          ),
          ListTile(
            dense: true,
            title: Text('달걀'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CatePage(num: 6, subnum: 6, cate: '달걀')),
              );
            },
          ),
        ],
      ],
    );
  }
}
