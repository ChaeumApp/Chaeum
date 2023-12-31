import 'dart:io';
import 'dart:async';
import 'package:fe/category/categorymain.dart';
import 'package:fe/recipe/recipemain.dart';
import 'package:fe/search/searchmain.dart';
import 'package:fe/store/searchstore.dart';
import 'package:fe/user/pageapi.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:fe/api/firebaseapi.dart';
import 'package:fe/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './repeat/bottom.dart';
//카카오로그인
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
//메인페이지
import './main/mainbody.dart';
import './main/splash.dart';
//유저
import './user/mypage.dart';
import './user/login.dart';
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
  static String? userToken; //user의 정보를 저장하기 위한 변수;
  static final storage = FlutterSecureStorage();
  final PageApi pageapi = PageApi();
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
    userToken = await storage.read(key: "login");
    if (userToken != null) {
      try {
        final response =
            await pageapi.tokenValidation(userToken.toString().split(" ")[1]);
        if (response == 'success') {
          await context
              .read<UserStore>()
              .changeAccessToken(userToken.toString().split(" ")[1].toString());
        } else {
          await storage.delete(key: "login");
          await context.read<UserStore>().changeAccessToken('');
          userToken = null;
          setState(() {});
        }
      } catch (e) {
        await storage.delete(key: "login");
        await context.read<UserStore>().changeAccessToken('');
        userToken = null;
        setState(() {});
      }
    } else {
      await storage.delete(key: "login");
      await context.read<UserStore>().changeAccessToken('');
      userToken = null;

      setState(() {});
    }
    final devicetoken = await getMyDeviceToken();
    await context.read<UserStore>().savedevicetoken(devicetoken.toString());
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
    SystemNavigator.pop();
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
                  userToken == null
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
