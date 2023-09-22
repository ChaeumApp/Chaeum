import 'package:flutter/material.dart';
// import 'package:like_button/like_button.dart';

class LikeButton extends StatelessWidget {
  final bool isLiked;
  void Function()? onTap;
  LikeButton({super.key, required this.isLiked, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        isLiked ? Icons.favorite : Icons.favorite_border,
        color: isLiked ? Colors.red : Colors.grey,
      ),
    );
    // LikeButton(
    //   isLiked: isLiked,
    //   onTap: onTap,
    //   circleColor: CircleColor(
    //     start: Color(0xffff0044),
    //     end: Color(0xffff4c7c),
    //   ),
    //   bubblesColor: BubblesColor(
    //     dotPrimaryColor: Color(0xffff3333),
    //     dotSecondaryColor: Color(0xffff9999),
    //   ),
    //   likeBuilder: (bool isLiked) {
    //     return Icon(
    //       isLiked ? Icons.favorite : Icons.favorite_border,
    //       color: isLiked ? Colors.red : Colors.black,
    //     );
    //   },
    // );
  }
}
