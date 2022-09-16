import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

Widget urlPreviewAvatar({
  required String url,
  required String imgURL,
}) {
  Widget avatar = GFAvatar(
    shape: GFAvatarShape.standard,
    size: GFSize.MEDIUM,
    minRadius: 40,
    backgroundImage: CachedNetworkImageProvider(imgURL),
  );
  if (url.contains("youtube.com/watch?v=")) {
    return Stack(
      children: [
        avatar,
        Positioned(
          child: Container(
            color: Colors.white70,
            child: const Icon(
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
    return avatar;
  }
}
