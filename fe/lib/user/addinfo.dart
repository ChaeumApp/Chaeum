import 'package:flutter/material.dart';

class AddInfo extends StatefulWidget {
  const AddInfo({super.key});

  @override
  State<AddInfo> createState() => _AddInfoState();
}

class _AddInfoState extends State<AddInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('필수 추가 정보'),
              Text('맞춤 정보 제공을 위해\n필수 추가 정보를 입력해주세요.'),
            ],
          ),
          Text('생년월일'),
          Row(
            children: [
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('비건여부'),
                    Text('선택창'),
                  ],
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('알러지여부'),
                    Text('선택창'),
                  ],
                ),
              ),
            ],
          ),
          Text('제출하기'),
          Text('이전으로')
        ],
      ),
    );
  }
}
