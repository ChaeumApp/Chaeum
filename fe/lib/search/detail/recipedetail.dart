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
//                 SizedBox(
//                   child: ListTile(
//                     title: Text(
//                       '재료',
//                       style: TextStyle(
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Wrap(
//                   direction: Axis.horizontal,
//                   runSpacing: 1,
//                   spacing: 1,
//                   children: ingredients.map((text) {
//                     final textLength = text.length;
//                     return Padding(
//                       // padding: const EdgeInsets.all(5.0),
//                       padding: const EdgeInsets.fromLTRB(20, 0.5, 2, 0.5),
//                       child: ConstrainedBox(
//                         constraints: BoxConstraints(
//                           maxWidth: textLength * 25.0, // 최대 너비를 텍스트 길이에 따라 계산
//                         ),
//                         child: TextButton(
//                           onPressed: () {},
//                           style: TextButton.styleFrom(
//                             foregroundColor: Color(0xffA1CBA1),
//                             backgroundColor: Colors.white,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(15.0),
//                               side: BorderSide(
//                                 color: Color(0xff4EC64C),
//                                 width: 1.0,
//                               ),
//                             ),
//                           ),
//                           child: Text(
//                             text,
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//                 SizedBox(
//                   child: ListTile(
//                     title: Text(
//                       '조리법',
//                       style: TextStyle(fontWeight: FontWeight.w700),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   child: Column(
//                     children: [
//                       for (int index = 0; index < steps.length; index++)
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: EdgeInsets.only(
//                                 left: 20,
//                               ),
//                               child: ElevatedButton(
//                                 onPressed: () {},
//                                 style: ElevatedButton.styleFrom(
//                                   shape: CircleBorder(),
//                                   backgroundColor: Colors.white,
//                                   side: BorderSide(
//                                     color: Color(0xffA1CBA1),
//                                     width: 3.0,
//                                   ),
//                                   minimumSize: Size(30, 30),
//                                 ),
//                                 child: Text(
//                                   '${index + 1}',
//                                   style: TextStyle(
//                                     color: Color(0xffA1CBA1), // 텍스트 색상
//                                     fontSize: 18.0, // 텍스트 크기
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Flexible(
//                               child: Padding(
//                                 padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
//                                 child: Text(
//                                   steps[index].description,
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w900,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   child: ListTile(
//                     title: Text(
//                       '유사한 레시피',
//                       style: TextStyle(fontWeight: FontWeight.w700),
//                     ),
//                   ),
//                 ),
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

// import 'package:flutter/material.dart';
// import './youtube.dart';
// import './similarrecipe.dart';
// import './process.dart';
// import 'package:dio/dio.dart';
// import 'package:like_button/like_button.dart';

// class Recipedetail extends StatefulWidget {
//   Recipedetail({super.key, this.recipeId});
//   final recipeId;

//   @override
//   State<Recipedetail> createState() => _RecipedetailState();
// }

// class _RecipedetailState extends State<Recipedetail> {
//   Dio dio = Dio();
//   final serverURL = 'http://j9c204.p.ssafy.io:8080';

//   var data = {'like': false};

//   Future<bool?> toggleLike(bool isLiked) async {
//     bool liked = false;
//     setState(() {
//       if (data.containsKey('like') && data['like'] is bool) {
//         data['like'] = !(data['like'] as bool);
//         liked = data['like'] as bool;
//       } else {
//         data['like'] = false;
//       }
//     });
//     return Future.value(liked);
//   }

// // 레시피 상세 조회

//   Future<dynamic> getRecipe(recipeid) async {
//     try {
//       Response response = await dio.get('$serverURL/recipe/detail/$recipeid');
//       print(response.data);
//       return response.data;
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
//       body: FutureBuilder(
//         future: getRecipe(widget.recipeId),
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('에러발생: ${snapshot.error.toString()}'));
//             // } else if (!snapshot.hasData || snapshot.data.isEmpty) {
//             //   return Center(child: Text('데이터없음'));
//           } else {
//             return CustomScrollView(
//               slivers: <Widget>[
//                 SliverAppBar(
//                   backgroundColor: Color.fromARGB(255, 255, 255, 255),
//                   toolbarHeight: 55,
//                   title: Text(
//                     '${snapshot.data['recipeName']}',
//                     style: TextStyle(
//                       color: const Color.fromARGB(255, 0, 0, 0),
//                       fontWeight: FontWeight.w900,
//                     ),
//                   ),
//                   centerTitle: true,
//                   pinned: false,
//                   elevation: 0,
//                 ),
//                 SliverList(
//                   delegate: SliverChildListDelegate(
//                     [
//                       Container(
//                           child: Recipeyoutube(
//                               recipeLink: snapshot.data['recipeLink'])),
//                       ListTile(
//                           title: Text(
//                             '${snapshot.data['recipeName']}',
//                             style: TextStyle(
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ),
//                           trailing: SizedBox(
//                             height: 20,
//                             width: 20,
//                             child: LikeButton(
//                               isLiked: data['like'] as bool, // 초기 좋아요 상태
//                               onTap: (isLiked) {
//                                 return toggleLike(data['like'] as bool);
//                               },
//                               circleColor: CircleColor(
//                                   start: Color(0xffff0044),
//                                   end: Color(0xffff4c7c)),
//                               bubblesColor: BubblesColor(
//                                 dotPrimaryColor: Color(0xffff3333),
//                                 dotSecondaryColor: Color(0xffff9999),
//                               ),
//                               likeBuilder: (bool isLiked) {
//                                 return Icon(
//                                   data['like'] as bool
//                                       ? Icons.favorite
//                                       : Icons.favorite_border,
//                                   color: data['like'] as bool
//                                       ? Colors.red
//                                       : Colors.black,
//                                 );
//                               },
//                             ),
//                           )),
//                       SizedBox(
//                         child: ListTile(
//                           title: Text(
//                             '재료',
//                             style: TextStyle(
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ),
//                         ),
//                       ),
//                       Wrap(
//                         direction: Axis.horizontal,
//                         runSpacing: 1,
//                         spacing: 1,
//                         children: ingredients.map((text) {
//                           final textLength = text.length;
//                           return Padding(
//                             padding: const EdgeInsets.fromLTRB(20, 0.5, 2, 0.5),
//                             child: ConstrainedBox(
//                               constraints: BoxConstraints(
//                                 maxWidth: textLength * 25.0,
//                               ),
//                               child: TextButton(
//                                 onPressed: () {},
//                                 style: TextButton.styleFrom(
//                                   foregroundColor: Color(0xffA1CBA1),
//                                   backgroundColor: Colors.white,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(15.0),
//                                     side: BorderSide(
//                                       color: Color(0xff4EC64C),
//                                       width: 1.0,
//                                     ),
//                                   ),
//                                 ),
//                                 child: Text(
//                                   text,
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         }).toList(),
//                       ),
//                       SizedBox(
//                         child: ListTile(
//                           title: Text(
//                             '조리법',
//                             style: TextStyle(fontWeight: FontWeight.w700),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         child: Column(
//                           children: [
//                             for (int index = 0; index < steps.length; index++)
//                               Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Padding(
//                                     padding: EdgeInsets.only(
//                                       left: 20,
//                                     ),
//                                     child: ElevatedButton(
//                                       onPressed: () {},
//                                       style: ElevatedButton.styleFrom(
//                                         shape: CircleBorder(),
//                                         backgroundColor: Colors.white,
//                                         side: BorderSide(
//                                           color: Color(0xffA1CBA1),
//                                           width: 3.0,
//                                         ),
//                                         minimumSize: Size(30, 30),
//                                       ),
//                                       child: Text(
//                                         '${index + 1}',
//                                         style: TextStyle(
//                                           color: Color(0xffA1CBA1),
//                                           fontSize: 18.0,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Flexible(
//                                     child: Padding(
//                                       padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
//                                       child: Text(
//                                         steps[index].description,
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.w900,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         child: ListTile(
//                           title: Text(
//                             '유사한 레시피',
//                             style: TextStyle(fontWeight: FontWeight.w700),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         child: Similaryoutube(),
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             );
//           }
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import './youtube.dart';
import './similarrecipe.dart';
import './process.dart';
import 'package:dio/dio.dart';
// import 'package:like_button/like_button.dart';
import 'package:marquee/marquee.dart';

import './toggleheart.dart';

class Recipedetail extends StatefulWidget {
  Recipedetail({super.key, this.recipeId});
  final recipeId;

  @override
  State<Recipedetail> createState() => _RecipedetailState();
}

class _RecipedetailState extends State<Recipedetail> {
  Dio dio = Dio();
  final serverURL = 'http://j9c204.p.ssafy.io:8080';

  // var data = {'like': false};

  // Future<bool?> toggleLike(bool isLiked) async {
  //   bool liked = false;
  //   setState(() {
  //     if (data.containsKey('like') && data['like'] is bool) {
  //       data['like'] = !(data['like'] as bool);
  //       liked = data['like'] as bool;
  //     } else {
  //       data['like'] = false;
  //     }
  //   });
  //   return Future.value(liked);
  // }

  var data = {'like': false};

  // Future<void> toggleLike(bool isLiked) async {
  //   if (data['like'] != null) {
  //     final liked = !data['like']!;
  //     setState(() {
  //       data['like'] = liked;
  //     });
  //   }
  // }

  // Future<bool> toggleLike(bool isLiked) async {
  //   final liked = !data['like'];
  //   setState(() {
  //     data['like'] = liked;
  //   });
  //   return liked; // Future<bool>을 반환
  // }

  bool isLiked = false;

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
  }

// 레시피 상세 조회

  Future<dynamic> getRecipe(recipeid) async {
    try {
      Response response = await dio.get('$serverURL/recipe/detail/$recipeid');
      print(response.data);
      return response.data;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getRecipe(widget.recipeId),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('에러발생: ${snapshot.error.toString()}'));
            // } else if (!snapshot.hasData || snapshot.data.isEmpty) {
            //   return Center(child: Text('데이터없음'));
          } else {
            return CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  backgroundColor: Color.fromARGB(255, 255, 255, 255),
                  toolbarHeight: 55,
                  title: SizedBox(
                    height: 55,
                    child: Marquee(
                      text: '${snapshot.data['recipeName']}',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.w800,
                      ),
                      scrollAxis: Axis.horizontal,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      blankSpace: 20.0,
                      startPadding: 20.0,
                      accelerationDuration: Duration(seconds: 1),
                      accelerationCurve: Curves.easeInOut,
                      decelerationDuration: Duration(milliseconds: 500),
                      decelerationCurve: Curves.easeOut,
                    ),
                  ),
                  centerTitle: true,
                  pinned: false,
                  elevation: 0,
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Container(
                          child: Recipeyoutube(
                              recipeLink: snapshot.data['recipeLink'])),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                                child: Container(
                              margin: EdgeInsets.fromLTRB(23, 14, 10, 0),
                              child: Text(
                                '${snapshot.data['recipeName']}',
                                style: TextStyle(
                                  // fontFamily: ,
                                  fontSize: 19,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            )),
                            // Container(
                            //   margin: EdgeInsets.fromLTRB(0, 12, 20, 0),
                            //   child: LikeButton(
                            //     isLiked: data['like'] as bool, // 초기 좋아요 상태
                            //     onTap: (isLiked) {
                            //       return toggleLike(isLiked);
                            //     },
                            //     circleColor: CircleColor(
                            //         start: Color(0xffff0044),
                            //         end: Color(0xffff4c7c)),
                            //     bubblesColor: BubblesColor(
                            //       dotPrimaryColor: Color(0xffff3333),
                            //       dotSecondaryColor: Color(0xffff9999),
                            //     ),
                            //     likeBuilder: (bool isLiked) {
                            //       return Icon(
                            //         data['like'] as bool
                            //             ? Icons.favorite
                            //             : Icons.favorite_border,
                            //         color: data['like'] as bool
                            //             ? Colors.red
                            //             : Colors.black,
                            //       );
                            //     },
                            //   ),
                            // )

                            Container(
                              margin: EdgeInsets.fromLTRB(0, 12, 20, 0),
                              child: LikeButton(
                                isLiked: false,
                                onTap: toggleLike,
                              ),
                            ),

                            // Container(
                            //   margin: EdgeInsets.fromLTRB(0, 12, 20, 0),
                            //   child: IconButton(
                            //     icon: Icon(
                            //       isFavorited
                            //           ? Icons.favorite
                            //           : Icons.favorite_border,
                            //       color: Colors.red[500],
                            //     ),
                            //     onPressed: toggleFavorite,
                            //   ),
                            // )
                          ]),
                      Container(
                        margin: EdgeInsets.fromLTRB(30, 15, 0, 0),
                        child: Text(
                          '재료',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      // Flexible(
                      //   child:
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                        child: Wrap(
                          direction: Axis.horizontal,
                          runSpacing: 1,
                          spacing: 1,
                          children: (snapshot.data['recipeIngredients'] !=
                                      null &&
                                  snapshot.data['recipeIngredients'].isNotEmpty)
                              ? snapshot.data['recipeIngredients']
                                  .map<Widget>((ingredient) {
                                  final text =
                                      '${ingredient[0]} ${ingredient[1]}'; // 재료 데이터에서 추출
                                  final textLength = text.length;
                                  return Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(12, 3, 1, 3),
                                    child: ConstrainedBox(
                                      constraints: BoxConstraints(
                                        maxWidth: textLength * 25.0,
                                        maxHeight: 35.0,
                                      ),
                                      child: TextButton(
                                        onPressed: () {},
                                        style: TextButton.styleFrom(
                                          foregroundColor: Color(0xffA1CBA1),
                                          backgroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
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
                                }).toList()
                              : [], // 재료 데이터가 없는 경우 빈 리스트 반환
                        ),
                      ),
                      // ),
                      SizedBox(
                        child: Column(
                          children: [
                            for (int index = 0;
                                index < snapshot.data['recipeProcess'].length;
                                index++)
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
                                          color: Color(0xffA1CBA1),
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(1, 11, 30, 2),
                                      child: Text(
                                        snapshot.data['recipeProcess'][index],
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
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
                            '유사한 레시피 추천',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      Container(
                        child: Similaryoutube(
                            recipeLink: snapshot.data['recipeLink']),
                      )
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

// class CustomLikeButton extends StatelessWidget {
//   final bool isLiked;
//   final void Function(bool) onTap; // onTap 함수의 반환 타입을 수정

//   CustomLikeButton({
//     super.key,
//     required this.isLiked,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return LikeButton(
//       isLiked: isLiked,
//       onTap: onTap,
//       circleColor: CircleColor(
//         start: Color(0xffff0044),
//         end: Color(0xffff4c7c),
//       ),
//       bubblesColor: BubblesColor(
//         dotPrimaryColor: Color(0xffff3333),
//         dotSecondaryColor: Color(0xffff9999),
//       ),
//       likeBuilder: (bool isLiked) {
//         return Icon(
//           isLiked ? Icons.favorite : Icons.favorite_border,
//           color: isLiked ? Colors.red : Colors.black,
//         );
//       },
//     );
//   }
// }
