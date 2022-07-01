import 'package:cached_network_image/cached_network_image.dart';
import 'package:dietapp_a/app%20Constants/colors.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_metadata_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeVideoPlayerScreen extends StatefulWidget {
  final RefUrlMetadataModel rumm;

  final String? title;
  const YoutubeVideoPlayerScreen(
    this.rumm,
    this.title, {
    Key? key,
  }) : super(key: key);

  @override
  State<YoutubeVideoPlayerScreen> createState() =>
      _YoutubeVideoPlayerScreenState();
}

class _YoutubeVideoPlayerScreenState extends State<YoutubeVideoPlayerScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animC;

  @override
  void initState() {
    animC = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    super.initState();

    animC.forward().then((value) async {
      await Future.delayed(const Duration(seconds: 1));
      animC.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    var isFullScreen = false.obs;
    var isPlaying = true.obs;
    var isSound = true.obs;

    YoutubePlayerController ytc = YoutubePlayerController(
      initialVideoId:
          YoutubePlayer.convertUrlToId(widget.rumm.url) ?? "kjiSVunIWpU",
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        hideThumbnail: true,
        enableCaption: false,
        disableDragSeek: false,
        startAt: 1,
        useHybridComposition: false,
      ),
    );

    return Obx(() => YoutubePlayerBuilder(
          onEnterFullScreen: () {
            isFullScreen.value = true;
          },
          onExitFullScreen: () {
            isFullScreen.value = false;
          },
          player: YoutubePlayer(
            controller: ytc,
            actionsPadding: const EdgeInsets.all(0.0),
            thumbnail: widget.rumm.img != null
                ? CachedNetworkImage(imageUrl: widget.rumm.img!)
                : null,
            progressColors: const ProgressBarColors(
              bufferedColor: Colors.transparent,
              playedColor: Colors.red,
              backgroundColor: Colors.white70,
            ),
            // showVideoProgressIndicator: isFullScreen.value,
            bottomActions: isFullScreen.value
                ? [
                    CurrentPosition(controller: ytc),
                    RemainingDuration(controller: ytc),
                    ProgressBar(
                        controller: ytc,
                        isExpanded: true,
                        colors: const ProgressBarColors(
                          bufferedColor: Colors.white,
                          playedColor: primaryColor,
                          handleColor: primaryColor,
                          backgroundColor: Colors.white70,
                        )),
                    FullScreenButton(controller: ytc),
                  ]
                : [],
            onReady: () {},
          ),
          builder: (context, player) {
            return SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.black,
                  actions: [
                    PopupMenuButton(itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          child: Row(
                            children: const [
                              Icon(MdiIcons.share, color: Colors.black),
                              Text(" Share"),
                            ],
                          ),
                          onTap: () async {
                            await Share.share(
                                "${widget.title ?? widget.rumm.title ?? ''}\n${widget.rumm.url}");
                          },
                        ),
                        PopupMenuItem(
                          child: Row(
                            children: const [
                              Icon(MdiIcons.contentCopy, color: Colors.black),
                              Text(" Copy")
                            ],
                          ),
                          onTap: () async {
                            Clipboard.setData(
                                ClipboardData(text: widget.rumm.url));
                            GFToast.showToast(
                              "Copied to clipboard",
                              context,
                              toastPosition: GFToastPosition.CENTER,
                            );
                          },
                        ),
                      ];
                    }),
                  ],
                ),
                body: Container(
                  color: Colors.black,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Expanded(
                          flex: 1,
                          child: SizedBox(),
                        ),
                        Expanded(flex: 3, child: player),
                        Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              const SizedBox(height: 60),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                        onPressed: () async {
                                          if (isSound.value) {
                                            ytc.mute();
                                            await Future.delayed(const Duration(
                                                milliseconds: 300));
                                            isSound.value = false;
                                          } else {
                                            ytc.unMute();
                                            await Future.delayed(const Duration(
                                                milliseconds: 300));
                                            isSound.value = true;
                                          }
                                        },
                                        icon: Obx(() => isSound.value
                                            ? const Icon(
                                                MdiIcons.volumeHigh,
                                                color: Colors.white,
                                              )
                                            : const Icon(
                                                MdiIcons.volumeOff,
                                                color: Colors.white,
                                              ))),
                                    IconButton(
                                        onPressed: () async {
                                          if (isPlaying.value) {
                                            ytc.pause();
                                            await Future.delayed(const Duration(
                                                milliseconds: 300));
                                            isPlaying.value = false;
                                          } else {
                                            ytc.play();
                                            await Future.delayed(const Duration(
                                                milliseconds: 300));
                                            isPlaying.value = true;
                                          }
                                        },
                                        icon: Obx(() => isPlaying.value
                                            ? AnimatedIcon(
                                                size: 30,
                                                color: Colors.white,
                                                icon: AnimatedIcons.pause_play,
                                                progress: animC)
                                            : AnimatedIcon(
                                                size: 30,
                                                color: Colors.white,
                                                icon: AnimatedIcons.play_pause,
                                                progress: animC))),
                                    FullScreenButton(controller: ytc),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const SizedBox(width: 3),
                                  CurrentPosition(controller: ytc),
                                  const SizedBox(width: 3),
                                  ProgressBar(
                                    controller: ytc,
                                    isExpanded: true,
                                    colors: const ProgressBarColors(
                                      bufferedColor: Colors.white,
                                      playedColor: primaryColor,
                                      handleColor: primaryColor,
                                      backgroundColor: Colors.white70,
                                    ),
                                  ),
                                  Text(
                                    widget.rumm.youtubeVideoLength ?? "   ",
                                    textScaleFactor: 0.97,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ]),
                ),
              ),
            );
          },
        ));
  }
}
