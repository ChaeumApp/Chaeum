import 'dart:io';
import 'dart:async';
import 'package:fe/category/categorymain.dart';
import 'package:fe/recipe/recipemain.dart';
import 'package:fe/search/searchmain.dart';
import 'package:fe/store/searchstore.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:fe/api/firebaseapi.dart';
import 'package:fe/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import './repeat/bottom.dart';
//카카오로그인
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
//메인페이지
import './main/mainbody.dart';
import './main/splash.dart';
import './category/ingrecate.dart';
import './category/recipecate.dart';
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

import './search/detail/recipedetail.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }
  KakaoSdk.init(
    nativeAppKey: 'f23e753ee765964826104dd2a8cf6e5d',
    javaScriptAppKey: '60215ddd14cbe2e9467a8c3f2b06ac4d',
  );
  // 상태바 색상 변경하는 코드
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.grey[50],
      statusBarIconBrightness: Brightness.dark));
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<LikeButtonState>(
            create: (c) => LikeButtonState()),
        ChangeNotifierProvider(create: (c) => UserStore()),
        ChangeNotifierProvider(create: (c) => SearchStore()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: "Pretendard",
          ),
          home: const Splash()),
    ),
  );
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
    getMyDeviceToken();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      foregroundMessage(message);
    });
    initializeNotification(context);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _asyncMethod();
      setState(() {});
    });
    super.initState();
  }

  _asyncMethod() async {
    //read 함수를 통하여 key값에 맞는 정보를 불러오게 됩니다. 이때 불러오는 결과의 타입은 String 타입임을 기억해야 합니다.
    //(데이터가 없을때는 null을 반환을 합니다.)

    userInfo = await storage.read(key: "login");

    print('제발 시작이니까 ');
    print(userInfo);
    print('시작2');
  }

  DateTime? currentBackPressTime;
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Color(0xff4C8C4C),
          content: Text('한번 더 뒤로가기를 누를 시 종료됩니다'),
          duration: Duration(seconds: 2),
        ),
      );
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: DefaultTabController(
          initialIndex: 2,
          length: 5,
          child: Scaffold(
            body: SafeArea(
              child: TabBarView(
                children: [
                  CategoryMain(),
                  RecipeMain(),
                  Mainb(),
                  SearchMain(),
                  userInfo == null
                      ? LogIn(storage: storage)
                      : MyPage(storage: storage)
                  // FavoriteMore(),
                ],
              ),
            ),
            extendBodyBehindAppBar: true,
            bottomNavigationBar: Bottom(),
          )),
    );
  }
}
