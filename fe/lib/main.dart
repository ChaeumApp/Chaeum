import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './repeat/bottom.dart';
import './main/mainbody.dart';


void main() {
  // 상태바 색상 변경하는 코드
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark
    )
  );
  runApp(MaterialApp(
    theme: ThemeData(
      fontFamily: "Pretendard",
    ),
      home: const Main())
  );
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
                Center(child: Text('식재료')),
                Center(child: Text('레시피')),
                Mainb(),
                Center(child: Text('검색')),
                Center(child: Text('내정보')),
              ],
            ),
          ),
          extendBodyBehindAppBar: true,
          bottomNavigationBar: Bottom(),)

    );
  }
}

