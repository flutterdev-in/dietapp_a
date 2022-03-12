import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeTestScreen extends StatelessWidget {
  const YoutubeTestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    YoutubePlayerController ytc = YoutubePlayerController(
      initialVideoId: 'kjiSVunIWpU',
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
      ),
    );
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 300,
            child: YoutubePlayerBuilder(
              player: YoutubePlayer(
                controller: YoutubePlayerController(
                  initialVideoId: YoutubePlayer.convertUrlToId("https://www.youtube.com/watch?v=BBAyRBTfsOU")??"kjiSVunIWpU",
                  flags: YoutubePlayerFlags(
                    autoPlay: true,
                    mute: true,
                  ),
                ),
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.amber,
                progressColors: ProgressBarColors(
                  playedColor: Colors.amber,
                  handleColor: Colors.amberAccent,
                ),
                onReady: () {},
              ),
              builder: (p0, p1) {
                return ListTile(
                  title: Text("jdcbhhbchbc"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
