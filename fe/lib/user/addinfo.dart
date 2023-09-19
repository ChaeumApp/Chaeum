import 'package:fe/user/userapi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class AddInfo extends StatefulWidget {
  AddInfo({super.key, this.user});
  final user;

  @override
  State<AddInfo> createState() => _AddInfoState();
  String? birthday;
  String? gender;
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
}

class _AddInfoState extends State<AddInfo> {
  final UserApi userapi = UserApi();
  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  bool algdropdown = false;
  bool birthcheck = false;
  bool gendercheck = false;

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
                '생년월일 및 성별',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                        fit: FlexFit.tight,
                        flex: 4,
                        child: TextField(
                          maxLength: 6,
                          onChanged: (value) {
                            if (!RegExp(
                                    r"^\d{2}(0[1-9]|1[0-2])(0[1-9]|[12]\d|3[01])$")
                                .hasMatch(value)) {
                              setState(() {
                                birthcheck = false;
                                print(birthcheck);
                              });
                            } else {
                              setState(() {
                                birthcheck = true;
                                print(birthcheck);
                              });
                            }
                          },
                          controller: controller,
                          cursorColor: Color(0xffA1CBA1),
                          decoration: InputDecoration(
                              enabledBorder: birthcheck
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
                                    color: birthcheck
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
                        fit: FlexFit.tight,
                        flex: 2,
                        child: Text(
                          'ㅡ',
                          textAlign: TextAlign.center,
                        )),
                    Flexible(
                        fit: FlexFit.tight,
                        flex: 1,
                        child: TextField(
                          onChanged: (value) {
                            if (!RegExp(r"^[1-4]$").hasMatch(value)) {
                              setState(() {
                                gendercheck = false;
                                print(gendercheck);
                              });
                            } else {
                              setState(() {
                                gendercheck = true;
                                print(gendercheck);
                              });
                            }
                          },
                          maxLength: 1,
                          cursorColor: Color(0xffA1CBA1),
                          controller: controller2,
                          decoration: InputDecoration(
                              enabledBorder: gendercheck
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
                                    color: gendercheck
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
                        fit: FlexFit.tight,
                        flex: 3,
                        child: Text(
                          ' * * * * * *',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ))
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
                            value: widget.selectedVegan,
                            items: widget.veganList.map((String item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                            onChanged: (dynamic value) {
                              setState(() {
                                widget.selectedVegan = value;
                              });
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
                            value: widget.havAllergie,
                            items: widget.allergieList.map((String item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                            onChanged: (dynamic value) {
                              setState(() {
                                widget.havAllergie = value;
                              });
                              if (value == '있음') {
                                setState(() {
                                  algdropdown = true;
                                });
                                print(widget.havAllergie);
                                print(widget.havAllergie.runtimeType);
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
                          items: widget.allergieNameList
                              .map((allergie) =>
                                  MultiSelectItem<String>(allergie, allergie))
                              .toList(),
                          onConfirm: (values) {
                            print(values);
                            setState(() {
                              widget.selectedAllergie = values;
                            });
                          },
                          chipDisplay: MultiSelectChipDisplay(
                            chipColor: Color(0xffA1CBA1),
                            textStyle: TextStyle(color: Colors.white),
                            onTap: (value) {
                              setState(() {
                                widget.selectedAllergie.remove(value);
                              });
                            },
                          ),
                        ),
                        widget.selectedAllergie.isEmpty
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
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: TextButton(
                          onPressed: () {
                            if (controller2.text.toString() == '1') {
                              setState(() {
                                widget.birthday =
                                    '19${controller.text.substring(0, 2)}-${controller.text.substring(2, 4)}-${controller.text.substring(4, 6)}';
                                widget.gender = 'm';
                              });
                            } else if (controller2.text.toString() == '2') {
                              setState(() {
                                widget.birthday =
                                    '19${controller.text.substring(0, 2)}-${controller.text.substring(2, 4)}-${controller.text.substring(4, 6)}';
                                widget.gender = 'f';
                              });
                            } else if (controller2.text.toString() == '3') {
                              setState(() {
                                widget.birthday =
                                    '20${controller.text.substring(0, 2)}-${controller.text.substring(2, 4)}-${controller.text.substring(4, 6)}';
                                widget.gender = 'm';
                              });
                            } else if (controller2.text.toString() == '4') {
                              setState(() {
                                widget.birthday =
                                    '20${controller.text.substring(0, 2)}-${controller.text.substring(2, 4)}-${controller.text.substring(4, 6)}';
                                widget.gender = 'f';
                              });
                            }

                            print(widget.birthday);
                            print(widget.user);
                            print(widget.gender);
                            print(widget.selectedVegan);

                            final response = userapi.signup(
                                widget.user[0],
                                widget.user[1],
                                widget.birthday,
                                widget.gender,
                                widget.selectedVegan,
                                widget.selectedVegan);
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Color(0xffA1CBA1))),
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
