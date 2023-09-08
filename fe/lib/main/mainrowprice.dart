import 'package:flutter/material.dart';
import '../detail/detail.dart';



class MainRowPrice extends StatelessWidget {
  const MainRowPrice({super.key});

  @override
  Widget build(BuildContext context) {
    var ranking = [
      {'rank':'1', 'category' : '복숭아', 'image' : 'paper_plane', 'saleprice' : 300, 'saleper' : 10},
      {'rank':'2', 'category' : '사과', 'image' : 'paper_plane', 'saleprice' : 300, 'saleper' : 10},
      {'rank':'3', 'category' : '배', 'image' : 'paper_plane', 'saleprice' : 300, 'saleper' : 10},
      {'rank':'4', 'category' : '양배추', 'image' : 'paper_plane', 'saleprice' : 300, 'saleper' : 10},
      {'rank':'5', 'category' : '양상추', 'image' : 'paper_plane', 'saleprice' : 300, 'saleper' : 10},
      {'rank':'6', 'category' : '우유', 'image' : 'paper_plane', 'saleprice' : 300, 'saleper' : 10},
      {'rank':'7', 'category' : '요거트', 'image' : 'paper_plane', 'saleprice' : 300, 'saleper' : 10},
      {'rank':'8', 'category' : '호두', 'image' : 'paper_plane', 'saleprice' : 300, 'saleper' : 10},
      {'rank':'9', 'category' : '당근', 'image' : 'paper_plane', 'saleprice' : 300, 'saleper' : 10},
      {'rank':'10', 'category' : '오이', 'image' : 'paper_plane', 'saleprice' : 300, 'saleper' : 10},
    ];

    return SliverToBoxAdapter(
      child: Container(
        width: 1500,
        height: 200,
        margin: EdgeInsets.fromLTRB(0, 8, 10, 0),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (c, i){
              return InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder:
                  (context)=> Detail(category : ranking[i]['category'])));
                },
                child: Container(
                  width: 120,
                  height: 150,
                  margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.asset('assets/images/temporary/${ranking[i]['image']}.jpg',
                            width: 120, height: 120,
                            fit: BoxFit.fill,),
                        ),
                        Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(161, 203, 161, 0.8),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(5)
                              )
                          ),
                          child: Center(
                            child: Text('${ranking[i]['rank']}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15
                              ),),
                          ),
                        )
                      ],),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text('${ranking[i]['category']}',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff4C3273)
                        ),),
                      ),
                      Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Text('어제보다 ${ranking[i]['saleprice']}원(${ranking[i]['saleper']}%) 더 싸요!',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),)),],
                  ),
                ),
              );
            }),
      ),
    );
  }
}

