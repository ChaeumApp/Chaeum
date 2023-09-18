import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class AddInfo extends StatefulWidget {
  AddInfo({super.key, this.user});
  final user;

  @override
  State<AddInfo> createState() => _AddInfoState();

  List<String> veganList = ['비건1', '비건2', '비건3'];
  String selectedVegan = '비건1';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('추가 정보')),
      body: Padding(
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
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
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
                      flex: 5,
                      child: TextField(
                        maxLength: 6,
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(width: 1.5),
                            ),
                            isDense: true,
                            counterText: '',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 10.0),
                            focusColor: Color(0xffA1CBA1)),
                      )),
                  Flexible(fit: FlexFit.tight, flex: 2, child: Text('     ㅡ ')),
                  Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: TextField(
                        maxLength: 1,
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(width: 1.5),
                            ),
                            isDense: true,
                            counterText: '',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 10.0),
                            focusColor: Color(0xffA1CBA1)),
                      )),
                  Flexible(
                      fit: FlexFit.tight,
                      flex: 4,
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
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        DropdownButton(
                          alignment: Alignment.bottomRight,
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
                          alignment: Alignment.bottomRight,
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
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  MultiSelectBottomSheetField(
                    backgroundColor: Colors.white,
                    cancelText: Text(
                      'kkk',
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
                ],
              ),
            ),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: TextButton(
                        onPressed: () {},
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
    );
  }
}
