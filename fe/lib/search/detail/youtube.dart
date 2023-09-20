import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Recipeyoutube extends StatefulWidget {
  Recipeyoutube({super.key, this.recipeLink});
  final recipeLink;
  @override
  State<Recipeyoutube> createState() => _RecipeyoutubeState();
}

class _RecipeyoutubeState extends State<Recipeyoutube> {
  // static String youtubeId = 'o5uTQF7b9Og';

  final YoutubePlayerController _con = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(
              'https://www.youtube.com/watch?v=uSljGJGSl6w')
          .toString(),
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
