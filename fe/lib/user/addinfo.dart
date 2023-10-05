import 'package:fe/main.dart';
import 'package:fe/store/userstore.dart';
import 'package:fe/user/pageapi.dart';
import 'package:fe/user/private_policy.dart';
import 'package:flutter/material.dart';

import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';

class AddInfo extends StatefulWidget {
  AddInfo({super.key, this.user, this.storage});
  final user;
  final storage;

  @override
  State<AddInfo> createState() => _AddInfoState();
}

class _AddInfoState extends State<AddInfo> {
  final PageApi pageapi = PageApi();
  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  String? birthday;
  String? gender;
  List<String> genderList = [
    '남성',
    '여성',
  ];
  String selectedGender = '남성';
  String selectedGenderString = 'm';
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
  List<Object?> selectedAllergie = [];
  List<dynamic> selectedAllergieNumber = [];

  bool algdropdown = false;

  bool yearcheck = false;
  bool monthcheck = false;
  bool daycheck = false;

  @override
  void initState() {
    super.initState();

    if (widget.user['userGender'] == "f") {
      setState(() {
        selectedGender = '여성';
      });
      selectedGenderString = 'f';
    }

    if (widget.user.containsKey('birth')) {
      setState(() {
        controller.text = widget.user['birth'].toString().substring(0, 4);
        if (controller.text != '0000') {
          yearcheck = true;
        } else {
          controller.text = '';
        }

        controller2.text = widget.user['birth'].toString().substring(4, 6);
        if (controller2.text != 'nu') {
          monthcheck = true;
        } else {
          controller2.text = '';
        }

        controller3.text = widget.user['birth'].toString().substring(6, 8);
        if (controller3.text != 'll') {
          daycheck = true;
        } else {
          controller3.text = '';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '',
          style: TextStyle(
              fontSize: 25, color: Colors.black, fontWeight: FontWeight.w700),
        ),
        elevation: 0.0,
        backgroundColor: Colors.grey[50],
        centerTitle: true,
        toolbarHeight: 65,
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.keyboard_backspace_rounded),
          onPressed: () {
            context.read<UserStore>().disposePolicyCheck();
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.values.first,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '필수 추가 정보',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    Text('맞춤 정보 제공을 위해\n필수 추가 정보를 입력해주세요.'),
                  ],
                ),
              ),
              Text(
                '생년월일',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 40),
                child: Row(
                  textBaseline: TextBaseline.ideographic,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    Flexible(
                        flex: 3,
                        child: TextField(
                          maxLength: 4,
                          onChanged: (value) {
                            if (!RegExp(
                                    r"^(19[0-9][0-9]|20[01][0-9]|202[0-3])$")
                                .hasMatch(value)) {
                              setState(() {
                                yearcheck = false;
                              });
                            } else {
                              setState(() {
                                yearcheck = true;
                              });
                            }
                          },
                          controller: controller,
                          cursorColor: Color(0xffA1CBA1),
                          decoration: InputDecoration(
                              enabledBorder: yearcheck
                                  ? UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1.5, color: Colors.black),
                                    )
                                  : OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 2, color: Colors.red)),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.5,
                                    color: yearcheck
                                        ? Color(0xffA1CBA1)
                                        : Colors.red),
                              ),
                              isDense: true,
                              counterText: '',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 10.0),
                              focusColor: Color(0xffA1CBA1)),
                        )),
                    Flexible(
                        child: Text(' 년 ',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                            ))),
                    Flexible(
                        flex: 2,
                        child: TextField(
                          maxLength: 2,
                          onChanged: (value) {
                            if (!RegExp(r"^(0?[1-9]|1[0-2])$")
                                .hasMatch(value)) {
                              setState(() {
                                monthcheck = false;
                              });
                            } else {
                              setState(() {
                                monthcheck = true;
                              });
                            }
                          },
                          controller: controller2,
                          cursorColor: Color(0xffA1CBA1),
                          decoration: InputDecoration(
                              enabledBorder: monthcheck
                                  ? UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1.5, color: Colors.black),
                                    )
                                  : OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 2, color: Colors.red)),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.5,
                                    color: monthcheck
                                        ? Color(0xffA1CBA1)
                                        : Colors.red),
                              ),
                              isDense: true,
                              counterText: '',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 10.0),
                              focusColor: Color(0xffA1CBA1)),
                        )),
                    Flexible(
                        child: Text(' 월 ',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                            ))),
                    Flexible(
                        flex: 2,
                        child: TextField(
                          onChanged: (value) {
                            if (!RegExp(r"^(0?[1-9]|[12][0-9]|3[01])$")
                                .hasMatch(value)) {
                              setState(() {
                                daycheck = false;
                              });
                            } else {
                              setState(() {
                                daycheck = true;
                              });
                            }
                          },
                          maxLength: 2,
                          cursorColor: Color(0xffA1CBA1),
                          controller: controller3,
                          decoration: InputDecoration(
                              enabledBorder: daycheck
                                  ? UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1.5, color: Colors.black),
                                    )
                                  : OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 2, color: Colors.red)),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.5,
                                    color: daycheck
                                        ? Color(0xffA1CBA1)
                                        : Colors.red),
                              ),
                              isDense: true,
                              counterText: '',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 10.0),
                              focusColor: Color(0xffA1CBA1)),
                        )),
                    Flexible(
                        child: Text(' 일 ',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                            ))),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '성별',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    DropdownButton(
                      alignment: Alignment.bottomLeft,
                      value: selectedGender,
                      items: genderList.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: (dynamic value) {
                        setState(() {
                          selectedGender = value;
                        });
                        if (selectedGender == '남자') {
                          selectedGenderString = 'm';
                        } else {
                          selectedGenderString = 'f';
                        }
                      },
                    ),
                  ],
                ),
              ),
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
                                fontSize: 16, fontWeight: FontWeight.w700),
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
                                });
                              } else {
                                setState(() {
                                  algdropdown = false;
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
                          searchable: true,
                          buttonText: Text("Allergy foods"),
                          title: Text(""),
                          items: allergieNameList
                              .map((allergie) =>
                                  MultiSelectItem<String>(allergie, allergie))
                              .toList(),
                          onConfirm: (values) async {
                            setState(() {
                              selectedAllergie = values;
                            });
                            List<int> resultList = [];

                            for (int i = 0; i < selectedAllergie.length; i++) {
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
                          chipDisplay: MultiSelectChipDisplay(
                            chipColor: Color(0xffA1CBA1),
                            textStyle: TextStyle(color: Colors.white),
                            onTap: (value) {
                              setState(() {
                                selectedAllergie.remove(value);
                              });
                              for (int i = 0;
                                  i < allergieNameList.length;
                                  i++) {
                                if (allergieNameList[i] == value) {
                                  selectedAllergieNumber.remove(i);
                                }
                              }
                            },
                          ),
                        ),
                        selectedAllergie.isEmpty
                            ? Container(
                                padding: EdgeInsets.all(10),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "None selected",
                                  style: TextStyle(color: Colors.black54),
                                ))
                            : Container(),
                      ]
                    : [],
              ),
              Padding(
                  padding: EdgeInsets.all(1),
                  child: GestureDetector(
                    onTap: () {
                      if (context.read<UserStore>().policycheck) {
                        context.watch<UserStore>().changePolicyCheck();
                        setState(() {});
                      } else {
                        showDialog(
                          context: context,
                          builder: ((context) {
                            return AlertDialog(
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    context
                                        .watch<UserStore>()
                                        .changePolicyCheck();
                                    setState(() {});

                                    Navigator.of(context).pop();
                                  },
                                  child: Text('동의'),
                                ),
                              ],
                              title: Text('<채움> 개인정보 처리 방안'),
                              content: SizedBox(
                                height: 300,
                                child: SingleChildScrollView(
                                  child: Policycheck(),
                                ),
                              ),
                            );
                          }),
                        );
                      }
                    },
                    child: Row(
                      children: [
                        Checkbox(
                            value: context.watch<UserStore>().policycheck,
                            onChanged: null),
                        Text('개인정보 처리방침에 동의합니다.'),
                      ],
                    ),
                  )),
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: TextButton(
                          onPressed: yearcheck &&
                                  monthcheck &&
                                  daycheck &&
                                  context.watch<UserStore>().policycheck
                              ? () async {
                                  if (controller2.text.length == 1) {
                                    controller2.text = '0${controller2.text}';
                                  }
                                  if (controller3.text.length == 1) {
                                    controller3.text = '0${controller3.text}';
                                  }
                                  birthday =
                                      '${controller.text}-${controller2.text}-${controller3.text}';
                                  final deviceToken =
                                      context.read<UserStore>().deviceToken;

                                  final loginres = await pageapi.signup(
                                      widget.user['userEmail'].toString(),
                                      widget.user['userPwd'].toString(),
                                      birthday,
                                      selectedGenderString,
                                      selectedVeganNumber,
                                      selectedAllergieNumber,
                                      deviceToken.toString());

                                  if (loginres is Map &&
                                      loginres.containsKey('accessToken')) {
                                    final accessToken = loginres['accessToken'];
                                    final refreshToken =
                                        loginres['refreshToken'];
                                    context
                                        .watch<UserStore>()
                                        .disposePolicyCheck();

                                    await widget.storage.write(
                                        key: "login",
                                        value:
                                            "accessToken $accessToken refreshToken $refreshToken");

                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
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
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('닫기'))
                                            ],
                                            content: SingleChildScrollView(
                                              child: Text('나중에 다시 시도해주세요.'),
                                            ),
                                          );
                                        }));
                                  }
                                }
                              : null,
                          style: ButtonStyle(
                              backgroundColor: yearcheck &&
                                      monthcheck &&
                                      daycheck &&
                                      context.watch<UserStore>().policycheck
                                  ? MaterialStatePropertyAll(Color(0xffA1CBA1))
                                  : MaterialStatePropertyAll(Colors.grey)),
                          child: SizedBox(
                            height: 30,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '제출하기',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
