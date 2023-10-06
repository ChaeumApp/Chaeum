import 'dart:math';

import 'package:fe/main.dart';
import 'package:fe/user/my_more_food.dart';
import 'package:fe/user/my_more_rec.dart';
import 'package:fe/user/pageapi.dart';

import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

import 'package:provider/provider.dart';
import '../store/userstore.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MyPage extends StatefulWidget {
  MyPage({super.key, this.storage});

  final storage;
  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final PageApi pageapi = PageApi();

  List<dynamic> favoringredient = [];
  List<dynamic> favorrecipe = [];

  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();

  List<String> veganList = [
    'none',
    'vegan',
    'lacto',
    'ovo',
    'lacto-ovo',
    'pesco',
    'pollo',
    'flexi',
  ];
  String selectedVegan = 'none';
  int selectedVeganNumber = 0;
  List<String> allergieList = ['없음', '있음'];
  String havAllergie = '없음';
  List<dynamic> allergieNameList = [
    '난류',
    '우유',
    '메밀',
    '땅콩',
    '대두',
    '밀',
    '고등어',
    '게',
    '새우',
    '돼지고기',
    '복숭아',
    '토마토',
    '호두',
    '닭고기',
    '쇠고기',
    '오징어',
    '조개류'
  ];
  List<dynamic> selectedAllergie = [];
  List<dynamic> selectedAllergieNumber = [];

  bool algdropdown = false;

  openDialog() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: ((context) {
          return AlertDialog(
            title: Text("회원 정보 수정"),
            content: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                      child: Row(
                        children: [
                          Flexible(
                            fit: FlexFit.tight,
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '비건여부',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                DropdownButton(
                                  alignment: Alignment.bottomLeft,
                                  value: selectedVegan,
                                  items: veganList.map((String item) {
                                    return DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(item),
                                    );
                                  }).toList(),
                                  onChanged: (dynamic value) {
                                    setState(() {
                                      selectedVegan = value;
                                      Navigator.of(context).pop();
                                      openDialog();
                                    });
                                    for (int i = 0; i < veganList.length; i++) {
                                      if (veganList[i] == selectedVegan) {
                                        selectedVeganNumber = i;
                                      }
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            fit: FlexFit.tight,
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '알러지여부',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                                DropdownButton(
                                  alignment: Alignment.bottomLeft,
                                  value: havAllergie,
                                  items: allergieList.map((String item) {
                                    return DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(item),
                                    );
                                  }).toList(),
                                  onChanged: (dynamic value) {
                                    setState(() {
                                      havAllergie = value;
                                    });
                                    if (value == '있음') {
                                      setState(() {
                                        algdropdown = true;
                                        Navigator.of(context).pop();
                                        openDialog();
                                      });
                                    } else {
                                      setState(() {
                                        algdropdown = false;
                                        selectedAllergie = [];
                                        selectedAllergieNumber = [];

                                        Navigator.of(context).pop();
                                        openDialog();
                                      });
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: algdropdown
                          ? <Widget>[
                              MultiSelectBottomSheetField(
                                backgroundColor: Colors.white,
                                confirmText: Text('선택하기'),
                                cancelText: Text(
                                  '취소하기',
                                  style: TextStyle(color: Colors.black),
                                ),
                                selectedColor: Color(0xffA1CBA1),
                                checkColor: Colors.white,
                                selectedItemsTextStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0x00ffffff),
                                  border: Border.all(color: Colors.grey),
                                ),
                                initialChildSize: 0.4,
                                listType: MultiSelectListType.CHIP,
                                buttonText: Text("Allergy foods"),
                                title: Text(""),
                                items: allergieNameList
                                    .map((allergie) => MultiSelectItem<String>(
                                        allergie, allergie))
                                    .toList(),
                                onConfirm: (values) async {
                                  print(values);
                                  setState(() {
                                    selectedAllergie = values;
                                  });
                                  List<int> resultList = [];

                                  for (int i = 0;
                                      i < selectedAllergie.length;
                                      i++) {
                                    for (int j = 0;
                                        j < allergieNameList.length;
                                        j++) {
                                      if (selectedAllergie[i] ==
                                          allergieNameList[j]) {
                                        resultList.add(j);
                                      }
                                    }
                                  }
                                  selectedAllergieNumber = resultList;
                                },
                                initialValue: selectedAllergie,
                                chipDisplay: MultiSelectChipDisplay(
                                  chipColor: Color(0xffA1CBA1),
                                  textStyle: TextStyle(color: Colors.white),
                                ),
                              ),
                            ]
                          : [],
                    ),
                  ]),
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(1, 0, 1, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Color(0xffA1CBA1))),
                        onPressed: () async {
                          print(selectedVeganNumber);
                          print(selectedAllergieNumber);

                          final response = await pageapi.updateuserinfo(
                              context.read<UserStore>().accessToken,
                              selectedVeganNumber,
                              selectedAllergieNumber);

                          if (response == 'success') {
                            showDialog(
                                context: context,
                                barrierDismissible: true, //바깥 영역 터치시 닫을지 여부 결정
                                builder: ((context) {
                                  return AlertDialog(
                                      content: Text('정상적으로 변경되었습니다.'),
                                      actions: <Widget>[
                                        Container(
                                          child: TextButton(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(); //창 닫기
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          Main()),
                                                  (route) => false);
                                            },
                                            child: Text("닫기"),
                                          ),
                                        )
                                      ]);
                                }));
                          } else {
                            showDialog(
                                context: context,
                                barrierDismissible: true, //바깥 영역 터치시 닫을지 여부 결정
                                builder: ((context) {
                                  return AlertDialog(
                                      content: Text('잠시 후 시도해주세요.'),
                                      actions: <Widget>[
                                        Container(
                                          child: TextButton(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(); //창 닫기
                                            },
                                            child: Text("닫기"),
                                          ),
                                        )
                                      ]);
                                }));
                          }
                        },
                        child: Text("변경하기")),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Color(0xffA1CBA1))),
                      onPressed: () {
                        Navigator.of(context).pop(); //창 닫기
                      },
                      child: Text("취소하기"),
                    ),
                  ],
                ),
              )
            ],
          );
        }));
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      final userStore = Provider.of<UserStore>(context, listen: false);
      final accessToken = userStore.accessToken;
      final info = await pageapi.getinfo(accessToken);

      if (info != null) {
        await userStore.changeUserInfo(info['userEmail']);
        favoringredient = info['ingredientList'];
        favorrecipe = info['recipeList'];
        selectedVeganNumber = info['veganId'];
        selectedVegan = veganList[selectedVeganNumber];

        final resallergyList = (info['allergyList']);
        if (resallergyList.isNotEmpty) {
          algdropdown = true;
          havAllergie = '있음';
        }
        for (int i = 0; i < resallergyList.length; i++) {
          selectedAllergieNumber.add(resallergyList[i]['algyId']);
          selectedAllergie.add(resallergyList[i]['algyName']);
        }
      }
      setState(() {});
      // 이제 userStore를 사용할 수 있습니다.
      // ...
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffA1CBA1),
        toolbarHeight: 55,
        title: Text('마이페이지'),
        centerTitle: true,
        elevation: 0,
        leading: Text(''),
      ),
      body: Container(
        padding: EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 35),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: Text(
                            '안녕하세요,',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                            child: Text(
                              '${context.read<UserStore>().userId.split('@')[0]} ',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xffA1CBA1)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                            child: Text(
                              '님',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: Text(
                          '오늘도 채움하세요 !',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ])),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 25),
                      child: Text(
                        'My채움',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff164D16)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Column(
                            children: [
                              SizedBox(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(children: [
                                        Text(
                                          '레시피 ',
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          '(${favorrecipe.length}건)',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ]),
                                      favorrecipe.isNotEmpty
                                          ? GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          FavoriteMoreRec(
                                                              favorRec:
                                                                  favorrecipe)),
                                                );
                                              },
                                              child: Text('더보기'))
                                          : Text('')
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                    onTap: favorrecipe.isNotEmpty
                                        ? () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          FavoriteMoreRec(
                                                              favorRec:
                                                                  favorrecipe)),
                                            );
                                          }
                                        : null,
                                    child: favorrecipe.isNotEmpty
                                        ? GridView.count(
                                            crossAxisCount: 2,
                                            childAspectRatio: 2 / 1.1,
                                            children: List<Widget>.generate(
                                                favorrecipe.length > 2
                                                    ? 2
                                                    : favorrecipe.length,
                                                (idx) {
                                              return Container(
                                                margin: const EdgeInsets.all(5),
                                                child: Image.network(
                                                  favorrecipe[idx]
                                                      ['recipeThumbnail'],
                                                ),
                                              );
                                            }).toList())
                                        : Center(
                                            child: Text('좋아하는 레시피를 추가해 보세요'))),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(children: [
                                      Text(
                                        '식재료 ',
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        '(${favoringredient.length}건)',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ]),
                                    favoringredient.isNotEmpty
                                        ? GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        FavoriteMoreFood(
                                                            favorIngr:
                                                                favoringredient)),
                                              );
                                            },
                                            child: Text('더보기'))
                                        : Text('')
                                  ],
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                    onTap: favoringredient.isNotEmpty
                                        ? () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (BuildContext
                                                          context) =>
                                                      FavoriteMoreFood(
                                                          favorIngr:
                                                              favoringredient)),
                                            );
                                          }
                                        : null,
                                    child: favoringredient.isNotEmpty
                                        ? GridView.count(
                                            crossAxisCount: 2, // 열 개수
                                            childAspectRatio: 1 / 0.9,
                                            children: List<Widget>.generate(
                                                favoringredient.length > 2
                                                    ? 2
                                                    : favoringredient.length,
                                                (idx) {
                                              return Container(
                                                margin: const EdgeInsets.all(3),
                                                child: Image.asset(
                                                  'assets/images/ingr/${favoringredient[idx]['ingrName']}.jpg',
                                                  fit: BoxFit.fill,
                                                ),
                                              );
                                            }).toList())
                                        : Center(
                                            child: Text('좋아하는 식재료를 추가해 보세요'))),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              TextButton(
                child: Text('회원정보 수정'),
                onPressed: () {
                  openDialog();
                },
              ),
              Text('|'),
              TextButton(
                onPressed: context.read<UserStore>().userId.substring(0, 1) !=
                        '['
                    ? () {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: ((context) {
                            return AlertDialog(
                              title: Text("비밀번호 변경"),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          1, 0, 1, 10),
                                      child: TextField(
                                        maxLength: 20,
                                        controller: controller,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        obscureText: true, // 비밀번호 안보이도록 하는 것
                                        decoration: InputDecoration(
                                            counterText: '',
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 16.0,
                                                    horizontal: 10.0),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1.5,
                                                    color: Color(0xffA1CBA1))),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide()),
                                            labelText: '현재 비밀번호',
                                            focusColor: Color(0xffA1CBA1)),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          1, 0, 1, 10),
                                      child: TextField(
                                        maxLength: 20,

                                        controller: controller2,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        obscureText: true, // 비밀번호 안보이도록 하는 것
                                        decoration: InputDecoration(
                                            counterText: '',
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 16.0,
                                                    horizontal: 10.0),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1.5,
                                                    color: Color(0xffA1CBA1))),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide()),
                                            labelText: '새로운 비밀번호',
                                            focusColor: Color(0xffA1CBA1)),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(1, 0, 1, 0),
                                      child: TextField(
                                        maxLength: 20,

                                        controller: controller3,
                                        obscureText: true, // 비밀번호 안보이도록 하는 것
                                        decoration: InputDecoration(
                                            counterText: '',
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 16.0,
                                                    horizontal: 10.0),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1.5,
                                                    color: Color(0xffA1CBA1))),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide()),
                                            labelText: '비밀번호 확인',
                                            focusColor: Color(0xffA1CBA1)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(1, 0, 1, 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      Color(0xffA1CBA1))),
                                          child: Text("변경하기"),
                                          onPressed: () async {
                                            if (RegExp(r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$")
                                                    .hasMatch(
                                                        controller2.text) &&
                                                RegExp(r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$")
                                                    .hasMatch(
                                                        controller3.text) &&
                                                controller2.text ==
                                                    controller3.text) {
                                              final response =
                                                  await pageapi.changepassword(
                                                      context
                                                          .read<UserStore>()
                                                          .accessToken,
                                                      controller.text,
                                                      controller2.text);

                                              if (response == 'success') {
                                                //메인페이지 이동 후 알림창 띄우고 토큰 삭제하기
                                              } else if (response == 'fail') {
                                                showDialog(
                                                    context: context,
                                                    barrierDismissible:
                                                        true, //바깥 영역 터치시 닫을지 여부 결정
                                                    builder: ((context) {
                                                      return AlertDialog(
                                                          content: Text(
                                                              '현재 비밀번호와 다릅니다.'),
                                                          actions: <Widget>[
                                                            Container(
                                                              child: TextButton(
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop(); //창 닫기
                                                                },
                                                                child:
                                                                    Text("닫기"),
                                                              ),
                                                            )
                                                          ]);
                                                    }));
                                              }
                                            } else if (!RegExp(
                                                    r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$")
                                                .hasMatch(controller2.text)) {
                                              showDialog(
                                                  context: context,
                                                  barrierDismissible:
                                                      true, //바깥 영역 터치시 닫을지 여부 결정
                                                  builder: ((context) {
                                                    return AlertDialog(
                                                        content: Text(
                                                            '특수문자,영어, 숫자를 포함해 주세요'),
                                                        actions: <Widget>[
                                                          Container(
                                                            child: TextButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(); //창 닫기
                                                              },
                                                              child: Text("닫기"),
                                                            ),
                                                          )
                                                        ]);
                                                  }));
                                            } else if (controller2.text !=
                                                controller3.text) {
                                              showDialog(
                                                  context: context,
                                                  barrierDismissible:
                                                      true, //바깥 영역 터치시 닫을지 여부 결정
                                                  builder: ((context) {
                                                    return AlertDialog(
                                                        content: Text(
                                                            '새로 입력한 비밀번호 같지 않습니다.'),
                                                        actions: <Widget>[
                                                          Container(
                                                            child: TextButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(); //창 닫기
                                                              },
                                                              child: Text("닫기"),
                                                            ),
                                                          )
                                                        ]);
                                                  }));
                                            } else {
                                              showSnackBar(
                                                  context,
                                                  Text(
                                                      '현재비밀번호가 다릅니다 다시 시도해주세요'));
                                            }
                                          }),
                                      ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    Color(0xffA1CBA1))),
                                        onPressed: () {
                                          Navigator.of(context).pop(); //창 닫기
                                          controller.text = '';
                                          controller2.text = '';
                                          controller3.text = '';
                                        },
                                        child: Text("취소하기"),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            );
                          }),
                        );
                      }
                    : null,
                child: Text(
                  '비밀번호 변경',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                ),
              ),
              Text('|'),
              TextButton(
                  child: Text(
                    '로그아웃',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                  onPressed: () async {
                    await widget.storage.delete(key: "login");
                    await pageapi.logout(context.read<UserStore>().accessToken);
                    await context.read<UserStore>().changeAccessToken('');

                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => Main()),
                        (route) => false);
                  }),
              Text('|'),
              TextButton(
                child: Text(
                  '회원 탈퇴',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                ),
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            contentPadding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                    child: Image.asset(
                                      'assets/images/repeat/bottom_logo.png',
                                      height: 50,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text('정말로 탈퇴하시겠습니까?',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700)),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            top: BorderSide(
                                                width: 1,
                                                color: Colors.black26))),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            onTap: () async {
                                              try {
                                                final response =
                                                    await pageapi.deleteuser(
                                                        context
                                                            .read<UserStore>()
                                                            .accessToken,
                                                        context
                                                            .read<UserStore>()
                                                            .userId);
                                                await widget.storage
                                                    .delete(key: "login");

                                                // if (response )
                                                if (response == 'success') {
                                                  if (context
                                                          .read<UserStore>()
                                                          .userId
                                                          .substring(0, 3) ==
                                                      '[K]') {
                                                    await UserApi.instance
                                                        .unlink();
                                                    showDialog(
                                                        context: context,
                                                        builder: ((context) {
                                                          return AlertDialog(
                                                            actions: <Widget>[
                                                              TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child: Text(
                                                                      '닫기'))
                                                            ],
                                                            content:
                                                                SingleChildScrollView(
                                                              child: Text(
                                                                  '회원탈퇴 되었습니다.'),
                                                            ),
                                                          );
                                                        }));
                                                  } else if (context
                                                          .read<UserStore>()
                                                          .userId
                                                          .substring(0, 3) ==
                                                      '[N]') {
                                                    showDialog(
                                                        context: context,
                                                        builder: ((context) {
                                                          return AlertDialog(
                                                            actions: <Widget>[
                                                              TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child: Text(
                                                                      '닫기'))
                                                            ],
                                                            content:
                                                                SingleChildScrollView(
                                                              child: Text(
                                                                  '회원탈퇴 되었습니다. 네이버에서 정보 제공 동의를 제거하세요'),
                                                            ),
                                                          );
                                                        }));
                                                  }
                                                  Navigator.pushAndRemoveUntil(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              Main()),
                                                      (route) => false);
                                                } else {
                                                  showDialog(
                                                      context: context,
                                                      builder: ((context) {
                                                        return AlertDialog(
                                                          actions: <Widget>[
                                                            TextButton(
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                child:
                                                                    Text('닫기'))
                                                          ],
                                                          content:
                                                              SingleChildScrollView(
                                                            child: Text(
                                                                '서버 연결을 확인해주세요'),
                                                          ),
                                                        );
                                                      }));
                                                }
                                              } catch (e) {}
                                            },
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 15, 0, 15),
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      right: BorderSide(
                                                          width: 1,
                                                          color:
                                                              Colors.black26))),
                                              child: Text(
                                                '회원탈퇴',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 15, 0, 15),
                                              child: Text(
                                                '취소',
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ]));
                      });
                },
              ),
            ]),
          ],
        ),
      ),
    );
  }
}

void showSnackBar(BuildContext context, Text text) {
  final snackBar = SnackBar(content: text, backgroundColor: Color(0xffA1CBA1));

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
