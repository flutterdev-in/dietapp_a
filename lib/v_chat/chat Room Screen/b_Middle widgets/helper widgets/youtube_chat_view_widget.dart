import 'package:cached_network_image/cached_network_image.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_metadata_model.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/b_Middle%20widgets/helper%20widgets/youtube_player_middle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class YoutubeChatViewWidget extends StatelessWidget {
  final String? title;
  final RefUrlMetadataModel rumm;
  const YoutubeChatViewWidget({
    Key? key,
    required this.rumm,
    required this.title,
  }) : super(key: key);

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
                  const SizedBox(height: 3),
                  CachedNetworkImage(
                    imageUrl: rumm.img ?? "",
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                                value: downloadProgress.progress),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  const SizedBox(height: 3),
                ],
              ),
              const Positioned(
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
                child: Text(
                  rumm.youtubeVideoLength ?? "",
                  style: const TextStyle(
                    backgroundColor: Colors.black87,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(title ?? "",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                )),
          )
        ],
      ),
      onTap: () {
        Get.to(() => YoutubePlayerMiddle(webURL: rumm.url, title: title));
      },
    );
  }
}
