import 'package:flutter/material.dart';

// class MaterialsApp extends StatelessWidget {
//   const MaterialsApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Materials(),
//     );
//   }
// }

// class Materials extends StatelessWidget {
//   final List<String> ingredients = [
//     '계란 3개',
//     '우유 200ml',
//     '소금 약간',
//     '피자치즈 100g',
//     '베이컨 2줄',
//     '크림치즈 4숟가락',
//   ];

//   Materials({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // EdgeInsets buttonMargin = EdgeInsets.all(8.0);
//     // EdgeInsets buttonPadding = EdgeInsets.all(5.0);

//     return Scaffold(
//       body: ListView.builder(
//         itemCount: ingredients.length,
//         itemBuilder: (context, index) {
//           // 각 버튼의 텍스트 길이를 측정
//           final text = ingredients[index];
//           final textLength = text.length;

//           // 텍스트 길이에 따라 버튼 크기를 동적으로 계산
//           final buttonWidth = textLength * 10.0;
//           const buttonHeight = 32.0;

//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: ElevatedButton(
//               onPressed: () {},
//               style: ElevatedButton.styleFrom(
//                   foregroundColor: Color(0xffA1CBA1),
//                   backgroundColor: Colors.white, // 버튼 텍스트 색상
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15.0), // 둥근 모서리
//                     side: BorderSide(
//                       color: Color(0xff4EC64C), // 테두리 색상
//                       width: 1.0, // 테두리 두께
//                     ),
//                   ),
//                   minimumSize: Size(buttonWidth, buttonHeight)
//                   // padding: buttonPadding,
//                   ),
//               // margin: buttonMargin,
//               child: Text(
//                 ingredients[index],
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// void main() {
//   runApp(MaterialsApp());
// }

// class MaterialsApp extends StatelessWidget {
//   const MaterialsApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Materials(),
//     );
//   }
// }

// class Materials extends StatelessWidget {
//   final List<String> ingredients = [
//     '계란 3개',
//     '우유 200ml',
//     '소금 약간',
//     '피자치즈 100g',
//     '베이컨 2줄',
//     '크림치즈 4숟가락',
//   ];

//   Materials({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView.builder(
//         itemCount: ingredients.length,
//         itemBuilder: (context, index) {
//           final text = ingredients[index];

//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextButton(
//               onPressed: () {},
//               style: TextButton.styleFrom(
//                 foregroundColor: Color(0xffA1CBA1),
//                 backgroundColor: Colors.white,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15.0),
//                   side: BorderSide(
//                     color: Color(0xff4EC64C),
//                     width: 1.0,
//                   ),
//                 ),
//               ),
//               child: Text(
//                 text,
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class MaterialsApp extends StatelessWidget {
//   const MaterialsApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Materials(),
//     );
//   }
// }

class Foods extends StatelessWidget {
  final List<String> ingredients = [
    '계란 3개',
    '우유 200ml',
    '소금 약간',
    '피자치즈 100g',
    '베이컨 2줄',
    '크림치즈 4숟가락',
  ];

  Foods({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Wrap(
          direction: Axis.horizontal,
          runSpacing: 1,
          spacing: 1,
          children: ingredients.map((text) {
            final textLength = text.length;
            return Padding(
              // padding: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.fromLTRB(5, 0.5, 5, 0.5),
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
      ),
    );
  }
}
