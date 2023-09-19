import 'package:flutter/material.dart';
import 'package:fe/store/userstore.dart';
import 'package:provider/provider.dart';


class SearchList extends StatefulWidget {
  SearchList({super.key});

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  @override
  Widget build(BuildContext context) {
    var searchList = context.read<UserStore>().searchList;

    return Container(
      margin: EdgeInsets.fromLTRB(15, 0, 20, 0),
      height: 30,
      child: ListView.builder(
        itemCount: searchList.length,
        scrollDirection: Axis.horizontal,
          itemBuilder: (context, index){
        return Container(
          margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
          padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black45
            ),
            borderRadius: BorderRadius.circular(20)
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('${searchList[index]}'),
              GestureDetector(
                onTap: (){
                  context.read<UserStore>().deleteSearchList(index);
                  setState(() {});
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: Icon(Icons.close,
                    color: Colors.black45,)),
              ),
            ],
          ),
        );
      }),
    );
  }
}
