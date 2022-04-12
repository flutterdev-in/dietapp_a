import 'package:cached_network_image/cached_network_image.dart';
import 'package:dietapp_a/my%20foods/screens/my%20foods%20collection/models/food_collection_model.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/b_Middle%20widgets/helper%20widgets/youtube_player_middle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googleapis/vision/v1.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YoutubeVideoWidget extends StatelessWidget {
  final FoodsCollectionModel fdcm;

  final String? text;
  const YoutubeVideoWidget({Key? key, required this.fdcm, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        width: MediaQuery.of(context).size.width * 7.5 / 10,
        color: Colors.green.shade200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.black87,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Column(
                          children: [
                            SizedBox(height: 3),
                            InkWell(
                              child: CachedNetworkImage(
                                imageUrl: fdcm.imgURL!,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                              onTap: () {
                                Get.to(() => YoutubePlayerMiddle(fdcm: fdcm));
                              },
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
                            future: YoutubeExplode().videos.get(fdcm.webURL),
                            builder: (context, snapshot) {
                              if (snapshot.hasData && snapshot.data != null) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(3),
                                  child: Text(
                                    getDuration(snapshot.data!.duration),
                                    style: TextStyle(
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
                      child: Text(fdcm.fieldName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                          )),
                    )
                  ],
                ),
              ),
            ),
            if (text != null && text != "")
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(text!),
              ),
          ],
        ),
      ),
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
