import 'package:cached_network_image/cached_network_image.dart';
import 'package:dietapp_a/app%20Constants/url/ref_url_metadata_model.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class UrlAvatar extends StatelessWidget {
  final RefUrlMetadataModel? rumm;

  const UrlAvatar(
    this.rumm, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (rumm?.isYoutubeVideo == true) {
      return Stack(
        children: [
          avatar(),
          Positioned(
            child: Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5)),
                ),
                child: Text(
                  rumm!.youtubeVideoLength ?? "",
                  textScaleFactor: 0.85,
                  style: const TextStyle(color: Colors.white),
                )),
            right: 0,
            bottom: 0,
          )
        ],
      );
    } else {
      return avatar();
    }
  }

  Widget avatar() {
    return rumm?.isYoutubeVideo == true
        ? ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: SizedBox(
              width: 70,
              child: CachedNetworkImage(imageUrl: rumm!.img!),
            ),
          )
        : rumm != null
            ? GFAvatar(
                shape: GFAvatarShape.standard,
                maxRadius: 30,
                backgroundImage: rumm!.img != null
                    ? CachedNetworkImageProvider(rumm!.img!)
                    : null,
              )
            : const GFAvatar(
                child: Icon(MdiIcons.noteTextOutline),
                shape: GFAvatarShape.standard,
                backgroundColor: Color.fromARGB(40, 184, 6, 216),
                maxRadius: 25,
              );
  }
}
