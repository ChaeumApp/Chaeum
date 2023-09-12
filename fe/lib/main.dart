import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './repeat/bottom.dart';
import './main/mainbody.dart';
import './main/splash.dart';
import './category/ingrecate.dart';
import './search/searchpage.dart';

void main() {
  // 상태바 색상 변경하는 코드
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark));
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Pretendard",
      ),
      home: const Splash()));
}

class Main extends StatelessWidget {
  const Main({super.key});

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
                Center(child: Text('레시피')),
                Mainb(),
                SearchPage(),
                Center(child: Text('내정보')),
              ],
            ),
          ),
          extendBodyBehindAppBar: true,
          bottomNavigationBar: Bottom(),
        ));
  }
}
