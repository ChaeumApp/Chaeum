import 'package:flutter/material.dart';

class MainBest extends StatelessWidget {
  const MainBest({super.key});

  @override
  Widget build(BuildContext context) {
    var ranking = [
      {'rank':'1', 'title' : '여기는1위자리의그것입니다', 'image' : 'paper_plane'},
      {'rank':'2', 'title' : '여기는2위자리의제목입니다자를예정이죠', 'image' : 'paper_plane'},
      {'rank':'3', 'title' : '여기는3위자리입니다하하', 'image' : 'paper_plane'},
      {'rank':'4', 'title' : '여기는4위', 'image' : 'paper_plane'},
      {'rank':'5', 'title' : '여기는4위', 'image' : 'paper_plane'},
      {'rank':'6', 'title' : '여기는4위', 'image' : 'paper_plane'},
      {'rank':'7', 'title' : '여기는4위', 'image' : 'paper_plane'},
      {'rank':'8', 'title' : '여기는4위', 'image' : 'paper_plane'},
      {'rank':'9', 'title' : '여기는4위', 'image' : 'paper_plane'},
      {'rank':'10', 'title' : '여기는4위', 'image' : 'paper_plane'},
    ];

    return SliverToBoxAdapter(
      child: Container(
        width: 1500,
        height: 170,
        margin: EdgeInsets.fromLTRB(0, 8, 10, 0),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (c, i){
              return Container(
                width: 120,
                height: 150,
                margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                child: Column(
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
                        child: Center(child: Text('${ranking[i]['rank']}',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 15
                          ),)),
                      )
                    ],),
                    Container(
                        margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text('${ranking[i]['title']!.length > 15 ? ranking[i]['title']?.substring(0, 15) : ranking[i]['title']}'
                            '${ranking[i]['title']!.length > 15 ? "..." : ""}',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),)),
                  ],
                ),
              );
            }),
      ),
    );
  }
}