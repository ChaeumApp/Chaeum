import 'package:fe/api/firebaseapi.dart';
import 'package:fe/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

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
  static String? userInfo; //user의 정보를 저장하기 위한 변수;
  static final storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();

    //비동기로 flutter secure storage 정보를 불러오는 작업.
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _asyncMethod();
      setState(() {});
    });
  }

  _asyncMethod() async {
    //read 함수를 통하여 key값에 맞는 정보를 불러오게 됩니다. 이때 불러오는 결과의 타입은 String 타입임을 기억해야 합니다.
    //(데이터가 없을때는 null을 반환을 합니다.)

    userInfo = await storage.read(key: "login");

    print('제발 시작이니까 ');
    print(userInfo);
    print('시작2');
  }

  int _selectedIndex = 2;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  final List<Widget> _widgetOptions = <Widget>[
    Ingrecate(),
    Center(child: Text('레시피')),
    Mainb(),
    SearchPage(),
    if (userInfo == null) LogIn(storage: storage) else MyPage(storage: storage)
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    offset: const Offset(0, -0.5))
              ]),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              onTap: _onItemTapped,
              currentIndex: _selectedIndex,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.kitchen), label: '식재료'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.menu_book), label: '레시피'),
                BottomNavigationBarItem(
                    icon: Image.asset('assets/images/repeat/bottom_logo.png',
                        width: 30),
                    label: "홈"),
                BottomNavigationBarItem(
                  icon: Icon(Icons.manage_search),
                  label: '검색',
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.perm_identity), label: '내 정보'),
              ],
              selectedItemColor: Color(0xffA3CCA3),
              selectedLabelStyle:
                  TextStyle(color: Color(0xffA3CCA3), fontSize: 12),
              unselectedItemColor: Color(0xffCACACA),
              unselectedLabelStyle: TextStyle(color: Color(0xffCACACA)),
            ),
          ),
        ));
  }
}
