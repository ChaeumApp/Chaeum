// import 'package:flutter/material.dart';

// void main() {
//   runApp(MaterialsApp());
// }

// class MaterialsApp extends StatelessWidget {
//   const MaterialsApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Process(),
//     );
//   }
// }

// class Process extends StatelessWidget {
//   Process({Key? key}) : super(key: key);

//   // 레시피 절차 데이터
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
//       body: ListView.builder(
//         itemCount: steps.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(steps[index].description),
//           );
//         },
//       ),
//     );
//   }
// }

// class RecipeStep {
//   final String description;

//   RecipeStep({
//     required this.description,
//   });

// }

// import 'package:flutter/material.dart';

// void main() {
//   runApp(MaterialsApp());
// }

// class MaterialsApp extends StatelessWidget {
//   const MaterialsApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Process(),
//     );
//   }
// }

// class Process extends StatelessWidget {
//   Process({Key? key}) : super(key: key);

//   // 레시피 절차 데이터
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
//       body: ListView.separated(
//           itemCount: steps.length,
//           separatorBuilder: (context, index) {
//             return SizedBox(
//               height: 1.0,
//             );
//           },
//           itemBuilder: (context, index) {
//             return ListTile(
//                 leading: ElevatedButton(
//                   onPressed: () {},
//                   style: ElevatedButton.styleFrom(
//                     shape: CircleBorder(),
//                     backgroundColor: Colors.white,
//                     side: BorderSide(
//                       color: Color(0xffA1CBA1), // 테두리 색상 설정
//                       width: 3.0, // 테두리 굵기 설정
//                     ),
//                     minimumSize: Size(25, 25),
//                   ),
//                   child: Text(
//                     '${index + 1}',
//                     style: TextStyle(
//                       color: Color(0xffA1CBA1), // 텍스트 색상
//                       fontSize: 18.0, // 텍스트 크기
//                     ),
//                   ),
//                 ),
//                 title: Padding(
//                   padding: EdgeInsets.symmetric(vertical: 3.0),
//                   child: Text(
//                     steps[index].description,
//                     style: TextStyle(
//                       fontWeight: FontWeight.w800,
//                     ),
//                   ),
//                 )
//                 );
//           }),
//     );
//   }
// }

// class RecipeStep {
//   final String description;

//   RecipeStep({
//     required this.description,
//   });
// }

import 'package:flutter/material.dart';

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MyApp(
//       home: Process(),
//     );
//   }
// }

class Process extends StatelessWidget {
  Process({Key? key}) : super(key: key);

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
      body: ListView.separated(
        itemCount: steps.length,
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 0.1,
          );
        },
        itemBuilder: (context, index) {
          return Wrap(
            children: [
              ElevatedButton(
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
              Padding(
                padding: EdgeInsets.fromLTRB(10, 2, 2, 2),
                child: Text(
                  steps[index].description,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class RecipeStep {
  final String description;

  RecipeStep({
    required this.description,
  });
}
