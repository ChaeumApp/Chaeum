import 'dart:io';
import 'dart:async';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
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


  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid){
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }

  // 상태바 색상 변경하는 코드
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
    getMyDeviceToken();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      foregroundMessage(message);
    });
    initializeNotification(context);
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
                userInfo == null
                    ? LogIn(storage: storage)
                    : MyPage(storage: storage)
                // FavoriteMore(),
              ],
            ),
          ),
          extendBodyBehindAppBar: true,
          bottomNavigationBar: Bottom(),
        ));
  }
}
