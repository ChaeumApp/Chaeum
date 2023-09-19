import 'package:flutter/material.dart';
import './searchbar.dart';
import './product.dart';
import './recipe.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});

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
            body: TabBarView(children: [Product(), Recipe()]),
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
