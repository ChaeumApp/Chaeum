import 'package:flutter/material.dart';
// import 'package:like_button/like_button.dart';

class MYLikeButton extends StatefulWidget {
  final bool isLiked;
  final void Function(bool)? onTap;

  MYLikeButton({Key? key, required this.isLiked, required this.onTap})
      : super(key: key);

  @override
  State<MYLikeButton> createState() => _MYLikeButtonState();
}

class _MYLikeButtonState extends State<MYLikeButton> {
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.isLiked;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isLiked = !_isLiked;
        });
        widget.onTap?.call(_isLiked);
      },
      child: Icon(
        _isLiked ? Icons.favorite : Icons.favorite_border,
        color: _isLiked ? Colors.red : Colors.grey,
      ),
    );
  }
}
