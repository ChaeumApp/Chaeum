// import 'package:flutter/material.dart';
// import './detailtab.dart';
//
// class Detail extends StatelessWidget {
//   Detail({super.key, this.category});
//
//   final category;
//
//   var data = {'saleper': 10, 'salewon': 300, 'salerank': 1};
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             backgroundColor: Colors.white,
//             expandedHeight: 60,
//             elevation: 0,
//             title: Text(
//               '$category',
//               style:
//               TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
//             ),
//             pinned: true,
//             floating: false,
//             leading: const BackButton(
//               color: Colors.black,
//             ),
//             centerTitle: true,
//           ),
//           SliverToBoxAdapter(
//             child: Image.asset(
//               'assets/images/temporary/sample.png',
//               height: 163,
//               fit: BoxFit.cover,
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: Container(
//               height: 93,
//               padding: EdgeInsets.only(left: 20),
//               margin: EdgeInsets.only(bottom: 5),
//               decoration: BoxDecoration(
//                   border: Border(
//                     bottom: BorderSide(color: Color(0xffB3B3B3), width: 0.3),
//                   )),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     margin: EdgeInsets.only(bottom: 3),
//                     child: Text(
//                       '$category',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   ),
//                   Text(
//                     '어제보다 ${data['saleper']}%(${data['salewon']}원) 더 비싸졌어요.',
//                     style: TextStyle(
//                       color: Color(0xff73324C),
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                   Text('최근 3개월 중 ${data['salerank']}번째로 비싼 날이에요.',
//                       style: TextStyle(
//                         color: Color(0xff73324C),
//                         fontWeight: FontWeight.w700,
//                       )),
//                 ],
//               ),
//             ),
//           ),
//           SliverFillRemaining(
//             child: DefaultTabController(
//               length: 3,
//               child: Column(
//                 children: [
//                   DetailTab(),
//                   Expanded(
//                     child: TabBarView(children: [
//                       Container(
//                         color: Colors.blue,
//                       ),
//                       Container(
//                         color: Colors.red,
//                       ),
//                       Container(
//                         color: Colors.black,
//                       ),
//                     ]),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import './detailtab.dart';
//
// class Detail extends StatelessWidget {
//   Detail({super.key, this.category});
//
//   final category;
//
//   var data = {'saleper': 10, 'salewon': 300, 'salerank': 1};
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: Text(
//           '$category',
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
//         ),
//         leading: const BackButton(
//           color: Colors.black,
//         ),
//         centerTitle: true,
//         actions: [
//           IconButton(onPressed: (){},
//               icon: Icon(Icons.favorite_border, color: Colors.black,))
//         ],
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Image.asset(
//             'assets/images/temporary/sample.png',
//             height: 163,
//             width: double.infinity,
//             fit: BoxFit.cover,
//           ),
//           Container(
//             height: 93,
//             width: double.infinity,
//             padding: EdgeInsets.only(left: 20),
//             margin: EdgeInsets.only(bottom: 5),
//             decoration: BoxDecoration(
//                 border: Border(
//               bottom: BorderSide(color: Color(0xffB3B3B3), width: 0.5),
//             )),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   margin: EdgeInsets.only(bottom: 3),
//                   child: Text(
//                     '$category',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                 ),
//                 Text(
//                   '어제보다 ${data['saleper']}%(${data['salewon']}원) 더 비싸졌어요.',
//                   style: TextStyle(
//                     color: Color(0xff73324C),
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 Text('최근 3개월 중 ${data['salerank']}번째로 비싼 날이에요.',
//                     style: TextStyle(
//                       color: Color(0xff73324C),
//                       fontWeight: FontWeight.w700,
//                     )),
//               ],
//             ),
//           ),
//           DefaultTabController(
//             length: 3,
//             child: Expanded(
//               child: Column(
//                 children: [
//                   DetailTab(),
//                   Expanded(
//                     child: TabBarView(children: [
//                       Container(
//                         color: Colors.blue,
//                       ),
//                       Container(
//                         color: Colors.red,
//                       ),
//                       Container(
//                         color: Colors.black,
//                       ),
//                     ]),
//                   )
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import './recomproduct.dart';
import './profile.dart';
import './priceinfo.dart';
import './detailrecipe.dart';

class Detail extends StatelessWidget {
  Detail({super.key, this.category});

  final category;

  var data = {'saleper': 10, 'salewon': 300, 'salerank': 1};

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: DefaultTabController(
          length: 3,
          child: NestedScrollView(
            // physics: NeverScrollableScrollPhysics(),
            headerSliverBuilder: (context, isScrolled) {
              return [
                SliverAppBar(
                  backgroundColor: Colors.white,
                  iconTheme: IconThemeData(color: Colors.black),
                  collapsedHeight: 320,
                  expandedHeight: 320,
                  flexibleSpace: ProfileView(category: category),
                ),
                SliverPersistentHeader(
                  delegate: MyDelegate(TabBar(
                      labelColor: Colors.black,
                      unselectedLabelColor: Color(0xffD0D0D0),
                      labelPadding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16
                      ),
                      indicatorColor: Color(0xff4C8C4C),
                      indicatorSize: TabBarIndicatorSize.label,
                      tabs: [
                        Text('추천상품'),
                        Text('가격정보'),
                        Text('레시피'),
                      ])),
                  floating: true,
                  pinned: true,
                )
              ];
            },
            body: TabBarView(children: [
              RecommendProduct(),
              PriceInfo(),
              DetailRecipe(),
            ]),
          ),
        ),
      ),
    );
  }
}

class MyDelegate extends SliverPersistentHeaderDelegate {
  MyDelegate(this.tabBar);

  final TabBar tabBar;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: tabBar,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
