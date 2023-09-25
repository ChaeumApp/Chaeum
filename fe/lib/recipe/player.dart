import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Player extends StatefulWidget {
  const Player({super.key, this.link});

  final link;

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.link.substring(widget.link.length - 11),
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: YoutubePlayer(
        key: ObjectKey(_controller),
        controller: _controller,
        showVideoProgressIndicator: true,
        width: double.infinity,
        progressColors: ProgressBarColors(
          playedColor: Color(0xff4C8C4C),
          handleColor: Color(0xff4C8C4C)
        ),
        progressIndicatorColor: Color(0xff164D16),
      ),
    );
  }
}
