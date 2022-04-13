import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/models/food_collection_model.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:dietapp_a/v_chat/chat%20Room%20Screen/b_Middle%20widgets/helper%20widgets/youtube_player_middle.dart';

import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YoutubeChatViewWidget extends StatelessWidget {

  final String webURL;
  final String? imgURL;
  final String? title;
  const YoutubeChatViewWidget({Key? key, required this.webURL,required this.imgURL,required this.title,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Column(
                children: [
                  SizedBox(height: 3),
                  CachedNetworkImage(
                    imageUrl: imgURL!,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                                value: downloadProgress.progress),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  const SizedBox(height: 3),
                ],
              ),
              Positioned(
                left: 10,
                bottom: 7,
                child: Icon(
                  MdiIcons.youtube,
                  color: Colors.red,
                  size: 30,
                ),
              ),
              Positioned(
                right: 10,
                bottom: 10,
                child: FutureBuilder<Video>(
                  future: YoutubeExplode().videos.get(webURL),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: Text(
                          getDuration(snapshot.data!.duration),
                          style: const TextStyle(
                            backgroundColor: Colors.black87,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(title??"",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                )),
          )
        ],
      ),
      onTap: () {
        Get.to(() => YoutubePlayerMiddle(webURL: webURL, title: title));
      },
    );
  }

  String getDuration(Duration? duration) {
    String length = duration.toString().split(".").first;

    bool isHourZero = length.split(":").first == "0";
    if (duration == null) {
      return "";
    } else if (isHourZero) {
      List<String> time = length.split(":");
      return " " + time[1] + ":" + time[2] + " ";
    } else {
      return " " + length + " ";
    }
  }
}
