import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './repeat/bottom.dart';
//메인페이지
import './main/mainbody.dart';
import './main/splash.dart';
import './category/ingrecate.dart';
<<<<<<< HEAD
import './category/recipecate.dart';
import './search/searchpage.dart'; //유저
=======
import './search/searchpage.dart';
//유저
>>>>>>> 9c170422e0d9afebdbfa8632152f3773a4b06ea7
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
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    print('시작');
    await context.watch<UserStore>().storage.read(key: 'login');
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 2,
        length: 5,
        child: Scaffold(
          body: SafeArea(
            child: TabBarView(
              children: [
                Ingrecate(),
                Recipecate(),
                Mainb(),
                SearchPage(),
                LogIn()
                // FavoriteMore(),
              ],
            ),
          ),
          extendBodyBehindAppBar: true,
          bottomNavigationBar: Bottom(),
        ));
  }
}
