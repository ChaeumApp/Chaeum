import 'package:flutter/material.dart';
import './cateitems.dart';

// class CatePage extends StatelessWidget {
//   CatePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: CustomScrollView(
//           slivers: <Widget>[
//             SliverAppBar(
//               backgroundColor: Color(0xffA1CBA1),
//               toolbarHeight: 55,
//               title: Text('과일'),
//               centerTitle: true,
//               elevation: 0,
//               leading: IconButton(
//                 icon: Icon(Icons.keyboard_backspace_rounded),
//                 onPressed: () {
//                   print('menu button is clicked');
//                 },
//               ),
//               pinned: true,
//             ),
//             SliverPadding(
//               padding: EdgeInsets.symmetric(horizontal: 10),
//               sliver: SliverList(
//                 delegate: SliverChildListDelegate(
//                   [
//                     SizedBox(height: 30),
//                     Text(
//                       "이런 재료들은 어때요?",
//                       style: TextStyle(
//                         fontSize: 17,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       "총 156건",
//                       style: TextStyle(
//                         fontSize: 15,
//                       ),
//                     ),
//                     ItemsCatePage(),
//                   ],
//                 ),
//               ),
//             ),
//             SliverToBoxAdapter(
//               child: Positioned(
//                 left: 334,
//                 top: 22,
//                 child: SizedBox(
//                   width: 16,
//                   height: 405,
//                   child: Stack(
//                     children: [
//                       Positioned(
//                         left: 0,
//                         top: 0,
//                         child: Container(
//                           width: 16,
//                           height: 405,
//                           decoration: ShapeDecoration(
//                             color: Color(0xCCD7D7D7),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8.50),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         left: 3,
//                         top: 8.59,
//                         child: SizedBox(
//                           width: 9,
//                           height: 389.05,
//                           child: Text(
//                             '&\nㄱ\n\nㄴ\n\nㄷ\n\nㄸ\n\nㄹ\n\nㅁ\n\nㅂ\n\nㅃ\n\nㅅ\n\nㅆ\n\nㅇ\n\nㅈ\n\nㅋ\n\nㅌ\n\nㅍ\n\nㅎ',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 10,
//                               fontFamily: 'Pretendard Variable',
//                               fontWeight: FontWeight.w500,
//                               height: 0,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CatePage extends StatelessWidget {
//   CatePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: CustomScrollView(
//           slivers: <Widget>[
//             SliverAppBar(
//               backgroundColor: Color(0xffA1CBA1),
//               toolbarHeight: 55,
//               title: Text('과일'),
//               centerTitle: true,
//               elevation: 0,
//               leading: IconButton(
//                 icon: Icon(Icons.keyboard_backspace_rounded),
//                 onPressed: () {
//                   print('menu button is clicked');
//                 },
//               ),
//               pinned: true,
//             ),
//             SliverPadding(
//               padding: EdgeInsets.symmetric(horizontal: 10),
//               sliver: SliverList(
//                 delegate: SliverChildListDelegate(
//                   [
//                     SizedBox(height: 30),
//                     Text(
//                       "이런 재료들은 어때요?",
//                       style: TextStyle(
//                         fontSize: 17,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       "총 156건",
//                       style: TextStyle(
//                         fontSize: 15,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SliverToBoxAdapter(
//               child: SizedBox(
//                 width: 16,
//                 height: 405,
//                 child: Stack(
//                   children: [
//                     Positioned(
//                       left: 0,
//                       top: 0,
//                       child: Container(
//                         width: 16,
//                         height: 405,
//                         decoration: ShapeDecoration(
//                           color: Color(0xCCD7D7D7),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8.50),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       left: 3,
//                       top: 8.59,
//                       child: SizedBox(
//                         width: 9,
//                         height: 389.05,
//                         child: Text(
//                           '&\nㄱ\n\nㄴ\n\nㄷ\n\nㄸ\n\nㄹ\n\nㅁ\n\nㅂ\n\nㅃ\n\nㅅ\n\nㅆ\n\nㅇ\n\nㅈ\n\nㅋ\n\nㅌ\n\nㅍ\n\nㅎ',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 10,
//                             fontFamily: 'Pretendard Variable',
//                             fontWeight: FontWeight.w500,
//                             height: 0,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SliverToBoxAdapter(
//               child: ItemsCatePage(), // 아이템 목록 출력
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CatePage extends StatelessWidget {
//   CatePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: CustomScrollView(
//           slivers: <Widget>[
//             SliverAppBar(
//               backgroundColor: Color(0xffA1CBA1),
//               toolbarHeight: 55,
//               title: Text('과일'),
//               centerTitle: true,
//               elevation: 0,
//               leading: IconButton(
//                 icon: Icon(Icons.keyboard_backspace_rounded),
//                 onPressed: () {
//                   print('menu button is clicked');
//                 },
//               ),
//               pinned: true,
//             ),
//             SliverPadding(
//               padding: EdgeInsets.symmetric(horizontal: 10),
//               sliver: SliverList(
//                 delegate: SliverChildListDelegate(
//                   [
//                     SizedBox(height: 30),
//                     Text(
//                       "이런 재료들은 어때요?",
//                       style: TextStyle(
//                         fontSize: 17,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       "총 156건",
//                       style: TextStyle(
//                         fontSize: 15,
//                       ),
//                     ),
//                     ItemsCatePage(),
//                   ],
//                 ),
//               ),
//             ),
//             SliverToBoxAdapter(
//               child: Positioned(
//                 left: 334,
//                 top: 22,
//                 child: SizedBox(
//                   width: 16,
//                   height: 405,
//                   child: Stack(
//                     children: [
//                       Positioned(
//                         left: 0,
//                         top: 0,
//                         child: Container(
//                           width: 16,
//                           height: 405,
//                           decoration: ShapeDecoration(
//                             color: Color(0xCCD7D7D7),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8.50),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         left: 3,
//                         top: 8.59,
//                         child: SizedBox(
//                           width: 9,
//                           height: 389.05,
//                           child: Text(
//                             '&\nㄱ\n\nㄴ\n\nㄷ\n\nㄸ\n\nㄹ\n\nㅁ\n\nㅂ\n\nㅃ\n\nㅅ\n\nㅆ\n\nㅇ\n\nㅈ\n\nㅋ\n\nㅌ\n\nㅍ\n\nㅎ',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 10,
//                               fontFamily: 'Pretendard Variable',
//                               fontWeight: FontWeight.w500,
//                               height: 0,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class CatePage extends StatelessWidget {
  CatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Color(0xffA1CBA1),
              toolbarHeight: 55,
              title: Text('과일'),
              centerTitle: true,
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.keyboard_backspace_rounded),
                onPressed: () {
                  print('menu button is clicked');
                },
              ),
              // expandedHeight: 200,
              pinned: true,
              // flexibleSpace: FlexibleSpaceBar(
              //   title: Text('과일'),
              //   centerTitle: true,
              // ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    SizedBox(height: 30),
                    Text(
                      "이런 재료들은 어때요?",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "총 156건",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    // SizedBox(height: 2),
                    ItemsCatePage()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
