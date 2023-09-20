import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Similaryoutube extends StatefulWidget {
  Similaryoutube({super.key, this.recipeLink});
  final recipeLink;

  @override
  State<Similaryoutube> createState() => _SimilaryoutubeState();
}

class _SimilaryoutubeState extends State<Similaryoutube> {
  late final YoutubePlayerController _con;

  @override
  void initState() {
    super.initState();

    _con = YoutubePlayerController(
      initialVideoId:
          YoutubePlayer.convertUrlToId(widget.recipeLink).toString(),
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: YoutubePlayer(
        controller: _con,
      ),
    );
  }
}
