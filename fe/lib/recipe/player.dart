import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
        actionsPadding: const EdgeInsets.only(left: 16.0),
        bufferIndicator: SpinKitPulse(
          itemBuilder: (BuildContext context, int index) {
            return Center(
              child: Image.asset('assets/images/repeat/bottom_logo.png',
                  height: 40),
            );
          },
        ),
        progressIndicatorColor: Color(0xffA1CBA1),
        bottomActions: [
          CurrentPosition(),
          const SizedBox(width: 10.0),
          ProgressBar(isExpanded: true),
          const SizedBox(width: 10.0),
          RemainingDuration(),
          //FullScreenButton(),
        ],
      ),
    );
  }
}
