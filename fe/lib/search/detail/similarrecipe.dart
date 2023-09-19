import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Similaryoutube extends StatefulWidget {
  Similaryoutube({super.key});

  @override
  State<Similaryoutube> createState() => _SimilaryoutubeState();
}

class _SimilaryoutubeState extends State<Similaryoutube> {
  static String youtubeId = 'Ft2pL4Qq0xQ';

  final YoutubePlayerController _con = YoutubePlayerController(
      initialVideoId: youtubeId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
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
