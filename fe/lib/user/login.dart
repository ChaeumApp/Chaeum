import 'package:fe/store/userstore.dart';
import 'package:fe/user/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../user/mypage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../main.dart';
import 'pageapi.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class LogIn extends StatefulWidget {
  LogIn({super.key, this.storage});

  final storage;
  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final PageApi pageapi = PageApi();

  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
            title: Text(
              '로그인',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
            ),
            elevation: 0.0,
            backgroundColor: Colors.grey[50],
            centerTitle: true,
            toolbarHeight: 65),
        // email, password 입력하는 부분을 제외한 화면을 탭하면, 키보드 사라지게 GestureDetector 사용
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                    child: Theme(
                  data: ThemeData(
                      primaryColor: Colors.grey,
                      inputDecorationTheme: InputDecorationTheme(
                          labelStyle:
                              TextStyle(color: Colors.grey, fontSize: 16.0))),
                  child: Container(
                      padding: EdgeInsets.all(40.0),
                      child: Builder(builder: (context) {
                        return SizedBox(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 58,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                  child: TextField(
                                    onChanged: (context) {},
                                    style: TextStyle(fontSize: 15),
                                    controller: controller,
                                    autofocus: true,
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 16.0, horizontal: 10.0),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1.5,
                                                color: Color(0xffA1CBA1))),
                                        prefixIconColor: Color(0xffA1CBA1),
                                        prefixIcon: Icon(
                                          Icons.alternate_email_rounded,
                                        ),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide()),
                                        labelText: '이메일',
                                        focusColor: Color(0xffA1CBA1)),
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 58,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                  child: TextField(
                                    controller: controller2,
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 16.0, horizontal: 10.0),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1.5,
                                                color: Color(0xffA1CBA1))),
                                        prefixIconColor: Color(0xffA1CBA1),
                                        prefixIcon:
                                            Icon(Icons.vpn_key_outlined),
                                        border: OutlineInputBorder(),
                                        labelText: '비밀번호',
                                        focusColor: Color(0xffA1CBA1)),
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: true, // 비밀번호 안보이도록 하는 것
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 60,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                  child: ButtonTheme(
                                      child: TextButton(
                                          onPressed: () async {
                                            final response =
                                                await pageapi.login(
                                                    controller.text.toString(),
                                                    controller2.text
                                                        .toString());
                                            if (response["accessToken"] !=
                                                null) {
                                              final accessToken =
                                                  response["accessToken"];
                                              final refreshToken =
                                                  response["refreshToken"];
                                              await widget.storage.write(
                                                  key: "login",
                                                  value:
                                                      "accessToken $accessToken refreshToken $refreshToken");

                                              print('여기는 로그인 버튼');
                                              print(widget.storage);
                                              await context
                                                  .read<UserStore>()
                                                  .changeUserInfo(
                                                      controller.text);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        Main()),
                                              );
                                              // write 함수를 통하여 key에 맞는 정보를 적게 됩니다.
                                              //{"login" : "id id_value password password_value"}
                                              //와 같은 형식으로 저장이 된다고 생각을 하면 됩니다.
                                            } else {
                                              showSnackBar(context,
                                                  Text('아이디 비밀번호를 확인해주세요'));
                                            }
                                          },
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      Color(0xffA1CBA1))),
                                          child: SizedBox(
                                            height: 40,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '로그인',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ))),
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        child: Text('아이디 찾기'),
                                      ),
                                      Text(' | '),
                                      GestureDetector(
                                        child: Text('비밀번호 찾기'),
                                      ),
                                    ]),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                child: Column(children: [
                                  Text(
                                    '소셜 로그인',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Card(
                                          shape: const CircleBorder(),
                                          clipBehavior: Clip.antiAlias,
                                          child: Ink.image(
                                            image: AssetImage(
                                                'assets/images/login/kakaoLogo.png'),
                                            width: 60,
                                            height: 60,
                                            child: InkWell(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(35.0),
                                              ),
                                              onTap: () async {
                                                if (await isKakaoTalkInstalled()) {
                                                  try {
                                                    OAuthToken token =
                                                        await UserApi.instance
                                                            .loginWithKakaoTalk();
                                                    print('카카오톡으로 로그인 성공');
                                                    print('1');
                                                    print(token.accessToken);
                                                  } catch (error) {
                                                    print(
                                                        '카카오톡으로 로그인 실패 $error');
                                                    print('1');

                                                    // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
                                                    // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
                                                    if (error
                                                            is PlatformException &&
                                                        error.code ==
                                                            'CANCELED') {
                                                      return;
                                                    }
                                                    // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
                                                    try {
                                                      OAuthToken token =
                                                          await UserApi.instance
                                                              .loginWithKakaoAccount();
                                                      print('카카오계정으로 로그인 성공');
                                                      print('2');
                                                      print(token.accessToken);
                                                    } catch (error) {
                                                      print(
                                                          '카카오계정으로 로그인 실패 $error');
                                                      print('2');
                                                    }
                                                  }
                                                } else {
                                                  try {
                                                    OAuthToken token = await UserApi
                                                        .instance
                                                        .loginWithKakaoAccount();
                                                    print('3');
                                                    print(token.accessToken);
                                                  } catch (error) {
                                                    print(
                                                        '카카오계정으로 로그인 실패 $error');
                                                    print('3');
                                                  }
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Card(
                                          shape: const CircleBorder(),
                                          clipBehavior: Clip.antiAlias,
                                          child: Ink.image(
                                            image: AssetImage(
                                                'assets/images/login/naverLogo.png'),
                                            width: 60,
                                            height: 60,
                                            child: InkWell(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(35.0),
                                              ),
                                              onTap: () async {},
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text('아직 회원이 아니신가요?  '),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          SignUp()),
                                            );
                                          },
                                          child: Text(
                                            '회원가입',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ))
                                    ],
                                  ),
                                ]),
                              )
                            ],
                          ),
                        );
                      })),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void showSnackBar(BuildContext context, Text text) {
  final snackBar = SnackBar(content: text, backgroundColor: Color(0xffA1CBA1));

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

// class NextPage extends StatelessWidget {
//   const NextPage({Key key}) : super(key: key

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
