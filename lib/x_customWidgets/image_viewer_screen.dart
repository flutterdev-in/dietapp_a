import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageViewerScreen extends StatelessWidget {
  final String imgUrl;
  const ImageViewerScreen({Key? key, required this.imgUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
      ),
      body: Container(
        color: Colors.black87,
        child: Center(
          child: CachedNetworkImage(
            imageUrl: imgUrl,
            errorWidget: (context, url, error) => const Text("data"),
          ),
        ),
      ),
    );
  }
}
