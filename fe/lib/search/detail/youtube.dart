import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Recipeyoutube extends StatefulWidget {
  Recipeyoutube({Key? key}) : super(key: key);

  @override
  State<Recipeyoutube> createState() => _RecipeyoutubeState();
}

class _RecipeyoutubeState extends State<Recipeyoutube> {
  static String youtubeId = 'J3OqrOJpPVQ';

  final YoutubePlayerController _con = YoutubePlayerController(
      initialVideoId: youtubeId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ));

  @override
  Widget build(BuildContext context) {
    return Center(
      child: YoutubePlayer(
        controller: _con,
      ),
    );
  }
}
