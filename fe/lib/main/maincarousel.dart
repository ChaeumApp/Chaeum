import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MainCarousel extends StatefulWidget {
  const MainCarousel({super.key});

  @override
  State<MainCarousel> createState() => _MainCarouselState();
}

class _MainCarouselState extends State<MainCarousel> {

  List imageList = [
  {'id': 1, 'image_path':'assets/images/main/main_banner1.png'},
  {'id': 2, 'image_path':'assets/images/main/main_banner2.png'},
  ];
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            InkWell(
              onTap: (){
                print(currentIndex);
              },
              child: CarouselSlider(
                items: imageList.map(
                    (item)=> Image.asset(
                      item['image_path'],
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                ).toList(),
                carouselController: carouselController,
                options: CarouselOptions(
                  scrollPhysics: const BouncingScrollPhysics(),
                  autoPlay: true,
                  aspectRatio: 2,
                  viewportFraction: 1,
                  autoPlayInterval: Duration(seconds: 5),
                  autoPlayAnimationDuration: Duration(seconds: 2),
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIndex = index;
                    });
                  }
                ),
              ),
            ),
            Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                imageList.asMap().entries.map((entry){
                  return GestureDetector(
                    onTap: ()=> carouselController.animateToPage(entry.key),
                    child: Container(
                      width: currentIndex == entry.key ? 17 : 7,
                      height: 7,
                      margin: EdgeInsets.symmetric(
                        horizontal: 3.0,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: currentIndex == entry.key
                              ? Color(0xffA1CBA1)
                              : Color(0xff868E96)
                      ),
                    ),
                  );
                }).toList(),
            ),
            ),
          ],
        )
      ],
    );
  }
}
