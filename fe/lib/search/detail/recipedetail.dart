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
import './similarrecipe.dart';
import './process.dart';

class Recipedetail extends StatelessWidget {
  Recipedetail({super.key});
  final List<String> ingredients = [
    '계란 3개',
    '우유 200ml',
    '소금 약간',
    '피자치즈 100g',
    '베이컨 2줄',
    '크림치즈 4숟가락',
  ];

  final List<RecipeStep> steps = [
    RecipeStep(
      description: '계란을 깨서 그릇에 담습니다.',
    ),
    RecipeStep(
      description: '우유를 계란에 넣고 잘 섞습니다.',
    ),
    RecipeStep(
      description: '소금을 약간 넣고 섞습니다.',
    ),
    RecipeStep(
      description: '피자치즈를 넣고 섞습니다.',
    ),
    RecipeStep(
      description: '베이컨을 추가하고 섞은 다음에 치즈계란소세지를 추가하고 블루치즈소스를 뿌린뒤에 30초간 가열합니다',
    ),
    RecipeStep(
      description: '크림치즈를 넣고 잘 섞습니다.',
    ),
  ];

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
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
              toolbarHeight: 55,
              title: Text(
                '베이컨 치즈 토스트 레시피',
                style: TextStyle(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.w900 // 원하는 색상으로 변경
                    ),
              ),
              centerTitle: true,
              pinned: false,
              elevation: 0,
              // leading: IconButton(
              //   icon: Icon(Icons.keyboard_backspace_rounded),
              //   onPressed: () {
              //     print('menu button is clicked');
              //   },
              // ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(child: Recipeyoutube()),
                  ListTile(
                    title: Text(
                      '베이컨 치즈 토스트 레시피(2인분)',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    trailing: Icon(Icons.favorite_border),
                  ),
                  Expanded(
                    child: SizedBox(
                      child: ListTile(
                        title: Text(
                          '재료',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Wrap(
                      direction: Axis.horizontal,
                      runSpacing: 1,
                      spacing: 1,
                      children: ingredients.map((text) {
                        final textLength = text.length;
                        return Padding(
                          // padding: const EdgeInsets.all(5.0),
                          padding: const EdgeInsets.fromLTRB(20, 0.5, 2, 0.5),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth:
                                  textLength * 25.0, // 최대 너비를 텍스트 길이에 따라 계산
                            ),
                            child: TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                foregroundColor: Color(0xffA1CBA1),
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  side: BorderSide(
                                    color: Color(0xff4EC64C),
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              child: Text(
                                text,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      child: ListTile(
                        title: Text(
                          '조리법',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      child: Column(
                        children: [
                          for (int index = 0; index < steps.length; index++)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 20,
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      shape: CircleBorder(),
                                      backgroundColor: Colors.white,
                                      side: BorderSide(
                                        color: Color(0xffA1CBA1),
                                        width: 3.0,
                                      ),
                                      minimumSize: Size(30, 30),
                                    ),
                                    child: Text(
                                      '${index + 1}',
                                      style: TextStyle(
                                        color: Color(0xffA1CBA1), // 텍스트 색상
                                        fontSize: 18.0, // 텍스트 크기
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
                                    child: Text(
                                      steps[index].description,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      child: ListTile(
                        title: Text(
                          '유사한 레시피',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                  // Expanded(
                  //   child: Process(),
                  // ),
                  Container(
                    child: Similaryoutube(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
