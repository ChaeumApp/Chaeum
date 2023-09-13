import 'package:flutter/material.dart';
import './searchbar.dart';
import './product.dart';
import './recipe.dart';

// void main() {
//   runApp(SearchPage());
// }

// class SearchPage extends StatefulWidget {
//   SearchPage({Key? key}) : super(key: key);

//   @override
//   State<SearchPage> createState() => _SearchPageState();
// }

// class _SearchPageState extends State<SearchPage> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           toolbarHeight: 80,
//           title: Search(),
//           elevation: 0,
//         ),
//         body: SizedBox(
//           width: 300,
//           child: SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             physics: const BouncingScrollPhysics(),
//             padding: const EdgeInsets.all(2),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 10),
//                 ),
//                 // SizedBox(height: 20),
//                 Container(
//                   margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 15),
//                     child: Text(
//                       "상품 검색 결과",
//                       style: TextStyle(
//                         fontSize: 17,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//                 // SizedBox(height: 8),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 15),
//                   child: Text(
//                     "156개 상품",
//                     style: TextStyle(
//                       fontSize: 15,
//                     ),
//                   ),
//                 ),
//                 // SizedBox(height: 2),
//                 Product()
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(SearchPage());
// }

// class SearchPage extends StatefulWidget {
//   SearchPage({Key? key}) : super(key: key);

//   @override
//   State<SearchPage> createState() => _SearchPageState();
// }

// class _SearchPageState extends State<SearchPage> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//           body: DefaultTabController(
//             length: 3,
//             child: NestedScrollView(
//               headerSliverBuilder: (context, isScrolled),
//             ),

//           )

//     CustomScrollView(
//   slivers: [
//     SliverAppBar(
//       backgroundColor: Colors.transparent,
//       toolbarHeight: 80,
//       title: Search(),
//       elevation: 0,
//     ),
//     SliverPersistentHeader(
//       delegate: MyDelegate(TabBar(
//           labelColor: Colors.black,
//           unselectedLabelColor: Color(0xffD0D0D0),
//           labelPadding: EdgeInsets.fromLTRB(0, 10, 0, 10),
//           labelStyle: TextStyle(
//             fontWeight: FontWeight.w700,
//           ),
//           indicatorColor: Color(0xff4C8C4C),
//           indicatorSize: TabBarIndicatorSize.label,
//           tabs: [
//             Text('식재료'),
//             Text('레시피'),
//           ])),
//       floating: true,
//       pinned: true,
//     ),

//     SliverPadding(
//       padding: EdgeInsets.symmetric(horizontal: 10),
//       sliver: SliverToBoxAdapter(
//         child: Container(
//           margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 15),
//             child: Text(
//               "상품 검색 결과",
//               style: TextStyle(
//                 fontSize: 17,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ),
//       ),
//     ),
//     SliverPadding(
//       padding: EdgeInsets.symmetric(horizontal: 15),
//       sliver: SliverToBoxAdapter(
//         child: Text(
//           "156개 상품",
//           style: TextStyle(
//             fontSize: 15,
//           ),
//         ),
//       ),
//     ),
//     // SliverList(
//     //   delegate: SliverChildListDelegate([Product()]),
//     // ),
//   ],
// )
//       ),
//     );
//   }
// }

// class MyDelegate extends SliverPersistentHeaderDelegate {
//   MyDelegate(this.tabBar);

//   final TabBar tabBar;

//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return Container(
//       // color: Colors.white,
//       child: tabBar,
//     );
//   }

//   @override
//   double get maxExtent => tabBar.preferredSize.height;

//   @override
//   double get minExtent => tabBar.preferredSize.height;

//   @override
//   bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
//     return false;
//   }
// }

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (context, isScrolled) {
              return [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  toolbarHeight: 80,
                  title: Search(),
                  elevation: 0,
                ),
                SliverPersistentHeader(
                  delegate: MyDelegate(TabBar(
                      labelColor: Colors.black,
                      unselectedLabelColor: Color(0xffD0D0D0),
                      labelPadding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                      indicatorColor: Color(0xff4C8C4C),
                      indicatorSize: TabBarIndicatorSize.label,
                      tabs: [
                        Text('식재료'),
                        Text('레시피'),
                      ])),
                  floating: true,
                  pinned: true,
                )
              ];
            },
            body: TabBarView(children: [
              Product(),
              // Recipe(),
              Recipe(),
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
      // color: Colors.white,
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
