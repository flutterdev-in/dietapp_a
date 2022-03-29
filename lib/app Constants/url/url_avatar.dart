import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class URLavatar extends StatelessWidget {
  final String? imgURL;
  final String? webURL;
  const URLavatar({Key? key, required this.imgURL, required this.webURL})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (webURL?.contains("youtube.com/watch?v=")??false) {
      return Stack(
        children: [
          avatar(),
          Positioned(
            child: Container(
              color: Colors.white70,
              child: Icon(
                MdiIcons.youtube,
                color: Colors.red,
                size: 15,
              ),
            ),
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
    return GFAvatar(
      shape: GFAvatarShape.standard,
      size: GFSize.LARGE,
      maxRadius: 20,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: CachedNetworkImage(
          imageUrl: imgURL??"",
          errorWidget: (context, url, error) => Icon(MdiIcons.cloudAlert),
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
