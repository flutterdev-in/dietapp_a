import 'package:cached_network_image/cached_network_image.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_metadata_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeVideoPlayerScreen extends StatelessWidget {
  final RefUrlMetadataModel rumm;

  final String? title;
  const YoutubeVideoPlayerScreen(
    this.rumm,
    this.title, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    YoutubePlayerController ytc = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(rumm.url) ?? "kjiSVunIWpU",
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        hideThumbnail: true,
        enableCaption: false,
        disableDragSeek: false,
        startAt: 1,
        useHybridComposition: false,
      ),
    );

    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: ytc,
        actionsPadding: const EdgeInsets.all(0.0),
        thumbnail:
            rumm.img != null ? CachedNetworkImage(imageUrl: rumm.img!) : null,

        // showVideoProgressIndicator: true,
        bottomActions: [
          CurrentPosition(),
          RemainingDuration(),
          ProgressBar(
            isExpanded: true,
            colors: const ProgressBarColors(
              bufferedColor: Colors.transparent,
              playedColor: Colors.red,
              handleColor: Colors.red,
              backgroundColor: Colors.white,
            ),
          ),
          FullScreenButton(),
        ],
        showVideoProgressIndicator: true,
      
        progressColors: const ProgressBarColors(
          bufferedColor: Colors.transparent,
          playedColor: Colors.red,
          backgroundColor: Colors.white70,
        ),
        onReady: () {},
      ),
      builder: (context, player) {
        return SafeArea(
          child: Scaffold(
            body:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              player,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(title ?? ""),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () async {
                        await Share.share(
                            "${title ?? rumm.title ?? ''}\n${rumm.url}");
                      },
                      icon: const Icon(MdiIcons.share)),
                  IconButton(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: rumm.url));
                        GFToast.showToast(
                          "Copied to clipboard",
                          context,
                          toastPosition: GFToastPosition.CENTER,
                        );
                      },
                      icon: const Icon(MdiIcons.contentCopy)),
                  IconButton(
                      onPressed: () async {
                        await Future.delayed(const Duration(milliseconds: 400));
                        Get.back();
                      },
                      icon: const Icon(MdiIcons.arrowLeft)),
                ],
              ),
            ]),
          ),
        );
      },
    );
  }
}
