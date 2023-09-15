import 'package:flutter/material.dart';

class Bottom extends StatelessWidget {
  const Bottom({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: (i){},
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.kitchen), label: '식재료'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: '레시피'),
          BottomNavigationBarItem(icon: Image.asset('assets/images/repeat/bottom_logo.png', width: 30), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.manage_search), label: '검색',),
          BottomNavigationBarItem(icon: Icon(Icons.perm_identity), label: '내 정보'),
        ],
      selectedItemColor: Color(0xffA3CCA3),
      selectedLabelStyle: TextStyle(color: Color(0xffA3CCA3), fontSize: 12),
      unselectedItemColor: Color(0xffCACACA),
      unselectedLabelStyle: TextStyle(color: Color(0xffCACACA)),
    );
    }
}

// class Bottom extends StatelessWidget {
//   const Bottom({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Container(
//         height: 70,
//         padding: EdgeInsets.only(bottom: 2, top: 5),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(16),
//             topRight: Radius.circular(16)
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.15),
//               blurRadius: 4,
//               spreadRadius: 0.0,
//               offset: const Offset(0, -0.5)
//             )
//           ]
//         ),
//         child: TabBar(
//           indicatorSize: TabBarIndicatorSize.label,
//             indicatorColor: Colors.transparent,
//             labelColor: Color(0xffA3CCA3),
//             unselectedLabelColor: Color(0xffCACACA),
//             tabs: [
//               Tab(icon: Icon(Icons.kitchen),
//                 text: '식재료',),
//               Tab(icon: Icon(Icons.menu_book,),
//                 text: '레시피',),
//               Tab(icon: Image.asset('assets/images/repeat/bottom_logo.png',
//               width: 30,),
//               ),
//               Tab(icon: Icon(Icons.manage_search),
//                 text: '검색',),
//               Tab(icon: Icon(Icons.perm_identity),
//                 text: '내 정보',),
//         ]),
//       ),
//     );
//   }
// }
