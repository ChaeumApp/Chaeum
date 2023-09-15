import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './repeat/bottom.dart';
//메인페이지
import './main/mainbody.dart';
import './main/splash.dart';
import './category/ingrecate.dart';
import './search/searchpage.dart';
//유저
import './user/mypage.dart';
import './user/login.dart';
import './user/signup.dart';
import './user/addinfo.dart';
import './user/my_more.dart';
//스토어
import 'package:provider/provider.dart';
import 'store/userstore.dart';

void main() {
  // 상태바 색상 변경하는 코드
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.grey[50],
      statusBarIconBrightness: Brightness.dark));
  runApp(ChangeNotifierProvider(
    create: (c) => UserStore(),
    child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Pretendard",
        ),
        home: const Splash()),
  ));
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {

  int _selectedIndex = 2;
  static const TextStyle optionStyle = TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold
  );


  final List<Widget> _widgetOptions = <Widget>[
    Ingrecate(),
    Center(child: Text('레시피')),
    Mainb(),
    SearchPage(),
    MyPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    // return DefaultTabController(
    //     initialIndex: 2,
    //     length: 5,
    //     child: Scaffold(
    //       body: SafeArea(
    //         child: TabBarView(
    //           children: [
    //             Ingrecate(),
    //             Center(child: Text('레시피')),
    //             Mainb(),
    //             SearchPage(),
    //             MyPage()
    //             // FavoriteMore(),
    //           ],
    //         ),
    //       ),
    //       extendBodyBehindAppBar: true,
    //       bottomNavigationBar: Bottom(),
    //     ));
    return Scaffold(
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        height: 70,
        // padding: EdgeInsets.only(bottom: 2, top: 5),
        decoration: BoxDecoration(
        //   borderRadius: BorderRadius.only(
        //   topLeft: Radius.circular(16),
        //   topRight: Radius.circular(16)
        // ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 4,
            spreadRadius: 0.0,
            offset: const Offset(0, -0.5)
          )
        ]
        ),
        child: ClipRRect(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(16),
      topRight: Radius.circular(16)
    ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            onTap: _onItemTapped,
            currentIndex: _selectedIndex,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.kitchen), label: '식재료'),
              BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: '레시피'),
              BottomNavigationBarItem(icon: Image.asset('assets/images/repeat/bottom_logo.png', width: 30), label: "홈"),
              BottomNavigationBarItem(icon: Icon(Icons.manage_search), label: '검색',),
              BottomNavigationBarItem(icon: Icon(Icons.perm_identity), label: '내 정보'),
            ],
            selectedItemColor: Color(0xffA3CCA3),
            selectedLabelStyle: TextStyle(color: Color(0xffA3CCA3), fontSize: 12),
            unselectedItemColor: Color(0xffCACACA),
            unselectedLabelStyle: TextStyle(color: Color(0xffCACACA)),
          ),
        ),
      )
    );
  }
}
