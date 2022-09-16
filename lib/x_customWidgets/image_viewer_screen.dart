import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageViewerScreen extends StatelessWidget {
  final String imgUrl;
  const ImageViewerScreen({Key? key, required this.imgUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        color: Colors.black,
        child: Center(
          child: InteractiveViewer(
            clipBehavior: Clip.none,
            child: CachedNetworkImage(
              imageUrl: imgUrl,
              errorWidget: (context, url, error) => const Text("data"),
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
      ),
    );
  }
}
