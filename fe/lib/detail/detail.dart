import 'package:flutter/material.dart';

class Detail extends StatelessWidget {
  const Detail({super.key, this.category});
  final category;

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        body: CustomScrollView(
          slivers : [
            SliverAppBar(
              backgroundColor: Colors.white,
              expandedHeight: 60,
              elevation: 0,
              title: Text('${category}',
                style: TextStyle(
                 color: Colors.black,
                 fontWeight: FontWeight.w700),),
              pinned: true,
              floating: false,
              leading: const BackButton(
                     color: Colors.black,
                   ),
              centerTitle: true,
            ),
            SliverToBoxAdapter(
              child: Image.asset('assets/images/temporary/sample.jpg'),
            )
          ],
        ),
      );
  }
}
