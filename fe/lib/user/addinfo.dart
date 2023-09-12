import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddInfo extends StatefulWidget {
  AddInfo({super.key});

  @override
  State<AddInfo> createState() => _AddInfoState();
  List<String> veganList = ['비건1', '비건2', '비건3'];
  String selectedVegan = '비건1';
  List<String> allergieList = ['없음', '있음'];
  String selectedAllergie = '없음';
}

class _AddInfoState extends State<AddInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: VisualDensity.maximumDensity,
      padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
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
                        value: widget.selectedAllergie,
                        items: widget.allergieList.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (dynamic value) {
                          setState(() {
                            widget.selectedAllergie = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
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
    );
  }
}
