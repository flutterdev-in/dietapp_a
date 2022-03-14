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
      body: ListView(
        children: [
          YoutubePlayer(
            controller: YoutubePlayerController(
              initialVideoId: YoutubePlayer.convertUrlToId(
                      "https://www.youtube.com/watch?v=nf9tq7cNkTQ") ??
                  "kjiSVunIWpU",
              flags: const YoutubePlayerFlags(
                autoPlay: false,
                hideThumbnail: true,
                enableCaption: false,
                startAt: 1,
                useHybridComposition: false,
              ),
            ),
            showVideoProgressIndicator: true,
            bottomActions: [
              CurrentPosition(),
              ProgressBar(isExpanded: true,colors: ProgressBarColors(
              bufferedColor: Colors.green,
              playedColor: Colors.red,
              handleColor: Colors.red,
              backgroundColor: Colors.purple,
            ),),
              RemainingDuration(),
            ],
            progressColors: ProgressBarColors(
              bufferedColor: Colors.transparent,
              playedColor: Colors.red,
              backgroundColor: Colors.purple,
            ),
            onReady: () {},
          ),
          SizedBox(
            height: 300,
          ),
        ],
      ),
    );
  }
}
