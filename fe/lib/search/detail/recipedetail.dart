// import 'package:flutter/material.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// void main() {
//   runApp(Recipedetail());
// }

// class Recipedetail extends StatefulWidget {
//   Recipedetail({Key? key}) : super(key: key);

//   @override
//   State<Recipedetail> createState() => _RecipedetailState();
// }

// class _RecipedetailState extends State<Recipedetail> {
//   static String youtubeId = 'J3OqrOJpPVQ';

//   final YoutubePlayerController _con = YoutubePlayerController(
//       initialVideoId: youtubeId,
//       flags: const YoutubePlayerFlags(
//         autoPlay: true,
//         mute: false,
//       ));
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         resizeToAvoidBottomInset: false,
//         appBar: AppBar(
//           backgroundColor: Color(0xffA1CBA1),
//           toolbarHeight: 55,
//           title: Text('베이컨 치즈 토스트 레시피'),
//           centerTitle: true,
//           elevation: 0,
//         ),
//         body: SingleChildScrollView(
//           physics: const BouncingScrollPhysics(),
//           padding: const EdgeInsets.all(2),
//           child: Column(
//             children: [
//               SizedBox(
//                   child: YoutubePlayer(
//                 controller: _con,
//               )),
//               SizedBox(
//                 height: 50,
//                 child: ListTile(
//                   title: Text('베이컨 치즈 토스트 레시피(2인분)'),
//                   trailing: Icon(Icons.favorite_border),
//                 ),
//               ),
//               SizedBox(
//                 height: 42,
//                 child: ListTile(
//                   title: Text('재료'),
//                 ),
//               ),
//               SizedBox(
//                 height: 42,
//               ),
//               SizedBox(
//                 height: 42,
//               ),

//               Container(
//                 margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
//                 child: Text(
//                   "유사 레시피 추천",
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ),
//               // const Padding(
//               //     padding: EdgeInsets.symmetric(vertical: 3.0),
//               //     child: Column(
//               //       crossAxisAlignment: CrossAxisAlignment.start,
//               //       children: [
//               //         Padding(padding: EdgeInsets.symmetric(vertical: 3.0)),
//               //       ],
//               //     )),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import './youtube.dart';

// void main() {
//   runApp(Recipedetail());
// }

// class Recipedetail extends StatefulWidget {
//   Recipedetail({Key? key}) : super(key: key);

//   @override
//   State<Recipedetail> createState() => _RecipedetailState();
// }

// class _RecipedetailState extends State<Recipedetail> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         resizeToAvoidBottomInset: false,
//         appBar: AppBar(
//           backgroundColor: Color(0xffA1CBA1),
//           toolbarHeight: 55,
//           title: Text('베이컨 치즈 토스트 레시피'),
//           centerTitle: true,
//           elevation: 0,
//         ),
//         body: SingleChildScrollView(
//           physics: const BouncingScrollPhysics(),
//           padding: const EdgeInsets.all(2),
//           child: Column(
//             children: [
//               Recipeyoutube(),
//               SizedBox(
//                 height: 50,
//                 child: ListTile(
//                   title: Text('베이컨 치즈 토스트 레시피(2인분)'),
//                   trailing: Icon(Icons.favorite_border),
//                 ),
//               ),
//               SizedBox(
//                 height: 42,
//                 child: ListTile(
//                   title: Text('재료'),
//                 ),
//               ),
//               SizedBox(
//                 height: 42,
//               ),
//               SizedBox(
//                 height: 42,
//               ),
//               Container(
//                 margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
//                 child: Text(
//                   "유사 레시피 추천",
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import './youtube.dart';

// void main() {
//   runApp(Recipedetail());
// }

// class Recipedetail extends StatefulWidget {
//   Recipedetail({Key? key}) : super(key: key);

//   @override
//   State<Recipedetail> createState() => _RecipedetailState();
// }

// class _RecipedetailState extends State<Recipedetail> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         resizeToAvoidBottomInset: false,
//         appBar: AppBar(
//           backgroundColor: Color(0xffA1CBA1),
//           toolbarHeight: 55,
//           title: Text('베이컨 치즈 토스트 레시피'),
//           centerTitle: true,
//           elevation: 0,
//         ),
//         body: SingleChildScrollView(
//           physics: const BouncingScrollPhysics(),
//           padding: const EdgeInsets.all(2),
//           child: Column(
//             children: [
//               Recipeyoutube(),
//               SizedBox(
//                 height: 50,
//                 child: ListTile(
//                   title: Text('베이컨 치즈 토스트 레시피(2인분)'),
//                   trailing: Icon(Icons.favorite_border),
//                 ),
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: SizedBox(
//                       height: 42,
//                       child: ListTile(
//                         title: Text('재료'),
//                       ),
//                     ),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                       foregroundColor: Color(0xffA1CBA1),
//                       backgroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15.0),
//                         side: BorderSide(
//                           color: Color(0xffA1CBA1),
//                           width: 1.0,
//                         ),
//                       ),
//                     ),
//                     child: Text(
//                       '계란3개',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//               SizedBox(
//                 height: 42,
//               ),
//               SizedBox(
//                 height: 42,
//               ),
//               Container(
//                 margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
//                 child: Text(
//                   "유사 레시피 추천",
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import './youtube.dart';
// import './materials.dart';

// void main() {
//   runApp(Recipedetail());
// }

// class Recipedetail extends StatefulWidget {
//   Recipedetail({Key? key}) : super(key: key);

//   @override
//   State<Recipedetail> createState() => _RecipedetailState();
// }

// class _RecipedetailState extends State<Recipedetail> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         resizeToAvoidBottomInset: false,
//         appBar: AppBar(
//           backgroundColor: Color(0xffA1CBA1),
//           toolbarHeight: 55,
//           title: Text('베이컨 치즈 토스트 레시피'),
//           centerTitle: true,
//           elevation: 0,
//         ),
//         body: SingleChildScrollView(
//           padding: const EdgeInsets.all(2),
//           child: Column(
//             children: [
//               Recipeyoutube(),
//               SizedBox(
//                 height: 50,
//                 child: ListTile(
//                   title: Text('베이컨 치즈 토스트 레시피(2인분)'),
//                   trailing: Icon(Icons.favorite_border),
//                 ),
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: SizedBox(
//                       height: 42,
//                       child: ListTile(
//                         title: Text('재료'),
//                       ),
//                     ),
//                   ),
//                   SizedBox(child: MaterialsApp())
//                 ],
//               ),
//               SizedBox(
//                 height: 42,
//               ),
//               SizedBox(
//                 height: 42,
//               ),
//               Container(
//                 margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
//                 child: Text(
//                   "유사 레시피 추천",
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import './youtube.dart';
import './materials.dart';

class Recipedetail extends StatelessWidget {
  const Recipedetail({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Color(0xffA1CBA1),
        //   toolbarHeight: 45,
        //   title: Text('베이컨 치즈 토스트 레시피'),
        //   centerTitle: true,
        //   elevation: 0,
        // ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Color(0xffA1CBA1),
              toolbarHeight: 55,
              title: Text('베이컨 치즈 토스트 레시피'),
              centerTitle: true,
              elevation: 0,
              // leading: IconButton(
              //   icon: Icon(Icons.keyboard_backspace_rounded),
              //   onPressed: () {
              //     print('menu button is clicked');
              //   },
              // ),
              pinned: true,
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(child: Recipeyoutube()),

                  ListTile(
                    title: Text('베이컨 치즈 토스트 레시피(2인분)'),
                    trailing: Icon(Icons.favorite_border),
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          child: ListTile(
                            title: Text('재료'),
                          ),
                        ),
                      ),
                      MaterialsApp()
                    ],
                  ),
                  // SizedBox(
                  //   height: 42,
                  // ),
                  // SizedBox(
                  //   height: 42,
                  // ),
                  Container(
                    height: 50,
                    margin: EdgeInsets.fromLTRB(10, 10, 0, 5),
                    child: Text(
                      "유사 레시피 추천",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
