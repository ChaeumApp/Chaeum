// import 'package:flutter/material.dart';
// import './youtube.dart';
// import './similarrecipe.dart';
// import './process.dart';
// import 'package:dio/dio.dart';

// class Recipedetail extends StatefulWidget {
//   Recipedetail({super.key, this.recipeId});
//   final recipeId;

//   @override
//   State<Recipedetail> createState() => _RecipedetailState();
// }

// class _RecipedetailState extends State<Recipedetail> {
//   Dio dio = Dio(BaseOptions(
//     baseUrl: 'http://10.0.2.2:8080/',
//   ));

// // 레시피 상세 조회
//   var categoryDetail = [];

//   Future<void> getRecipe(recipeid) async {
//     try {
//       Response response = await dio.get('recipe/detail/$recipeid');
//       print(response.data);
//       setState(() {
//         categoryDetail = response.data;
//       });
//     } catch (e) {
//       print(e);
//     }
//   }

//   final List<String> ingredients = [
//     '계란 3개',
//     '우유 200ml',
//     '소금 약간',
//     '피자치즈 100g',
//     '베이컨 2줄',
//     '크림치즈 4숟가락',
//   ];

//   final List<RecipeStep> steps = [
//     RecipeStep(
//       description: '계란을 깨서 그릇에 담습니다.',
//     ),
//     RecipeStep(
//       description: '우유를 계란에 넣고 잘 섞습니다.',
//     ),
//     RecipeStep(
//       description: '소금을 약간 넣고 섞습니다.',
//     ),
//     RecipeStep(
//       description: '피자치즈를 넣고 섞습니다.',
//     ),
//     RecipeStep(
//       description: '베이컨을 추가하고 섞은 다음에 치즈계란소세지를 추가하고 블루치즈소스를 뿌린뒤에 30초간 가열합니다',
//     ),
//     RecipeStep(
//       description: '크림치즈를 넣고 잘 섞습니다.',
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: <Widget>[
//           SliverAppBar(
//             backgroundColor: Color.fromARGB(255, 255, 255, 255),
//             toolbarHeight: 55,
//             title: Text(
//               '베이컨 치즈 토스트 레시피',
//               style: TextStyle(
//                   color: const Color.fromARGB(255, 0, 0, 0),
//                   fontWeight: FontWeight.w900 // 원하는 색상으로 변경
//                   ),
//             ),
//             centerTitle: true,
//             pinned: false,
//             elevation: 0,
//           ),
//           SliverList(
//             delegate: SliverChildListDelegate(
//               [
//                 Container(child: Recipeyoutube()),
//                 ListTile(
//                   title: Text(
//                     '베이컨 치즈 토스트 레시피(2인분)',
//                     style: TextStyle(
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                   trailing: Icon(Icons.favorite_border),
//                 ),
//                 Expanded(
//                   child: SizedBox(
//                     child: ListTile(
//                       title: Text(
//                         '재료',
//                         style: TextStyle(
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Wrap(
//                     direction: Axis.horizontal,
//                     runSpacing: 1,
//                     spacing: 1,
//                     children: ingredients.map((text) {
//                       final textLength = text.length;
//                       return Padding(
//                         // padding: const EdgeInsets.all(5.0),
//                         padding: const EdgeInsets.fromLTRB(20, 0.5, 2, 0.5),
//                         child: ConstrainedBox(
//                           constraints: BoxConstraints(
//                             maxWidth: textLength * 25.0, // 최대 너비를 텍스트 길이에 따라 계산
//                           ),
//                           child: TextButton(
//                             onPressed: () {},
//                             style: TextButton.styleFrom(
//                               foregroundColor: Color(0xffA1CBA1),
//                               backgroundColor: Colors.white,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(15.0),
//                                 side: BorderSide(
//                                   color: Color(0xff4EC64C),
//                                   width: 1.0,
//                                 ),
//                               ),
//                             ),
//                             child: Text(
//                               text,
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//                 Expanded(
//                   child: SizedBox(
//                     child: ListTile(
//                       title: Text(
//                         '조리법',
//                         style: TextStyle(fontWeight: FontWeight.w700),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: SizedBox(
//                     child: Column(
//                       children: [
//                         for (int index = 0; index < steps.length; index++)
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Padding(
//                                 padding: EdgeInsets.only(
//                                   left: 20,
//                                 ),
//                                 child: ElevatedButton(
//                                   onPressed: () {},
//                                   style: ElevatedButton.styleFrom(
//                                     shape: CircleBorder(),
//                                     backgroundColor: Colors.white,
//                                     side: BorderSide(
//                                       color: Color(0xffA1CBA1),
//                                       width: 3.0,
//                                     ),
//                                     minimumSize: Size(30, 30),
//                                   ),
//                                   child: Text(
//                                     '${index + 1}',
//                                     style: TextStyle(
//                                       color: Color(0xffA1CBA1), // 텍스트 색상
//                                       fontSize: 18.0, // 텍스트 크기
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Flexible(
//                                 child: Padding(
//                                   padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
//                                   child: Text(
//                                     steps[index].description,
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.w900,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: SizedBox(
//                     child: ListTile(
//                       title: Text(
//                         '유사한 레시피',
//                         style: TextStyle(fontWeight: FontWeight.w700),
//                       ),
//                     ),
//                   ),
//                 ),
//                 // Expanded(
//                 //   child: Process(),
//                 // ),
//                 Container(
//                   child: Similaryoutube(),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import './youtube.dart';
// import './similarrecipe.dart';
// import './process.dart';
// import 'package:dio/dio.dart';

// class Recipedetail extends StatefulWidget {
//   Recipedetail({super.key, this.recipeId});
//   final recipeId;

//   @override
//   State<Recipedetail> createState() => _RecipedetailState();
// }

// class _RecipedetailState extends State<Recipedetail> {
//   Dio dio = Dio(BaseOptions(
//     baseUrl: 'http://10.0.2.2:8080/',
//   ));

// // 레시피 상세 조회
//   var categoryDetail = [];

//   Future<void> getRecipe(recipeid) async {
//     try {
//       Response response = await dio.get('recipe/detail/$recipeid');
//       print(response.data);
//       setState(() {
//         categoryDetail = response.data;
//       });
//     } catch (e) {
//       print(e);
//     }
//   }

//   final List<String> ingredients = [
//     '계란 3개',
//     '우유 200ml',
//     '소금 약간',
//     '피자치즈 100g',
//     '베이컨 2줄',
//     '크림치즈 4숟가락',
//   ];

//   final List<RecipeStep> steps = [
//     RecipeStep(
//       description: '계란을 깨서 그릇에 담습니다.',
//     ),
//     RecipeStep(
//       description: '우유를 계란에 넣고 잘 섞습니다.',
//     ),
//     RecipeStep(
//       description: '소금을 약간 넣고 섞습니다.',
//     ),
//     RecipeStep(
//       description: '피자치즈를 넣고 섞습니다.',
//     ),
//     RecipeStep(
//       description: '베이컨을 추가하고 섞은 다음에 치즈계란소세지를 추가하고 블루치즈소스를 뿌린뒤에 30초간 가열합니다',
//     ),
//     RecipeStep(
//       description: '크림치즈를 넣고 잘 섞습니다.',
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<void>(future: getRecipe(recipeid), builder:(BuildContext context, AsyncSnapshot){

//     });

//     return Scaffold(
//       body: CustomScrollView(
//         slivers: <Widget>[
//           SliverAppBar(
//             backgroundColor: Color.fromARGB(255, 255, 255, 255),
//             toolbarHeight: 55,
//             title: Text(
//               '베이컨 치즈 토스트 레시피',
//               style: TextStyle(
//                   color: const Color.fromARGB(255, 0, 0, 0),
//                   fontWeight: FontWeight.w900 // 원하는 색상으로 변경
//                   ),
//             ),
//             centerTitle: true,
//             pinned: false,
//             elevation: 0,
//           ),
//           SliverList(
//             delegate: SliverChildListDelegate(
//               [
//                 Container(child: Recipeyoutube()),
//                 ListTile(
//                   title: Text(
//                     '베이컨 치즈 토스트 레시피(2인분)',
//                     style: TextStyle(
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                   trailing: Icon(Icons.favorite_border),
//                 ),
//                 Expanded(
//                   child: SizedBox(
//                     child: ListTile(
//                       title: Text(
//                         '재료',
//                         style: TextStyle(
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Wrap(
//                     direction: Axis.horizontal,
//                     runSpacing: 1,
//                     spacing: 1,
//                     children: ingredients.map((text) {
//                       final textLength = text.length;
//                       return Padding(
//                         // padding: const EdgeInsets.all(5.0),
//                         padding: const EdgeInsets.fromLTRB(20, 0.5, 2, 0.5),
//                         child: ConstrainedBox(
//                           constraints: BoxConstraints(
//                             maxWidth: textLength * 25.0, // 최대 너비를 텍스트 길이에 따라 계산
//                           ),
//                           child: TextButton(
//                             onPressed: () {},
//                             style: TextButton.styleFrom(
//                               foregroundColor: Color(0xffA1CBA1),
//                               backgroundColor: Colors.white,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(15.0),
//                                 side: BorderSide(
//                                   color: Color(0xff4EC64C),
//                                   width: 1.0,
//                                 ),
//                               ),
//                             ),
//                             child: Text(
//                               text,
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//                 Expanded(
//                   child: SizedBox(
//                     child: ListTile(
//                       title: Text(
//                         '조리법',
//                         style: TextStyle(fontWeight: FontWeight.w700),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: SizedBox(
//                     child: Column(
//                       children: [
//                         for (int index = 0; index < steps.length; index++)
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Padding(
//                                 padding: EdgeInsets.only(
//                                   left: 20,
//                                 ),
//                                 child: ElevatedButton(
//                                   onPressed: () {},
//                                   style: ElevatedButton.styleFrom(
//                                     shape: CircleBorder(),
//                                     backgroundColor: Colors.white,
//                                     side: BorderSide(
//                                       color: Color(0xffA1CBA1),
//                                       width: 3.0,
//                                     ),
//                                     minimumSize: Size(30, 30),
//                                   ),
//                                   child: Text(
//                                     '${index + 1}',
//                                     style: TextStyle(
//                                       color: Color(0xffA1CBA1), // 텍스트 색상
//                                       fontSize: 18.0, // 텍스트 크기
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Flexible(
//                                 child: Padding(
//                                   padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
//                                   child: Text(
//                                     steps[index].description,
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.w900,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: SizedBox(
//                     child: ListTile(
//                       title: Text(
//                         '유사한 레시피',
//                         style: TextStyle(fontWeight: FontWeight.w700),
//                       ),
//                     ),
//                   ),
//                 ),
//                 // Expanded(
//                 //   child: Process(),
//                 // ),
//                 Container(
//                   child: Similaryoutube(),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import './youtube.dart';
import './similarrecipe.dart';
import './process.dart';
import 'package:dio/dio.dart';

class Recipedetail extends StatefulWidget {
  Recipedetail({super.key, this.recipeId});
  final recipeId;

  @override
  State<Recipedetail> createState() => _RecipedetailState();
}

class _RecipedetailState extends State<Recipedetail> {
  Dio dio = Dio(BaseOptions(
    baseUrl: 'http://10.0.2.2:8080/',
  ));

// 레시피 상세 조회
  var categoryDetail = [];

  Future<void> getRecipe(recipeid) async {
    try {
      Response response = await dio.get('recipe/detail/$recipeid');
      print(response.data);
      setState(() {
        categoryDetail = response.data;
      });
    } catch (e) {
      print(e);
    }
  }

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
    return Scaffold(
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
                SizedBox(
                  child: ListTile(
                    title: Text(
                      '재료',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                Wrap(
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
                          maxWidth: textLength * 25.0, // 최대 너비를 텍스트 길이에 따라 계산
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
                SizedBox(
                  child: ListTile(
                    title: Text(
                      '조리법',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                SizedBox(
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
                SizedBox(
                  child: ListTile(
                    title: Text(
                      '유사한 레시피',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                Container(
                  child: Similaryoutube(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
