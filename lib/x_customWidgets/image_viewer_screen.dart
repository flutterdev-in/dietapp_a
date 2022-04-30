import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageViewerScreen extends StatefulWidget {
  final PageController pageController;
  final List<String> listImgUrl;
  final int initialIndex;
  ImageViewerScreen({
    Key? key,
    required this.listImgUrl,
    required this.initialIndex,
  }) : pageController = PageController(initialPage: initialIndex);

  @override
  State<ImageViewerScreen> createState() => _ImageViewerScreenState();
}

class _ImageViewerScreenState extends State<ImageViewerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: PhotoViewGallery.builder(
          pageController: widget.pageController,
          itemCount: widget.listImgUrl.length,
          builder: (context, index) {
            var image = widget.listImgUrl[index];
            return PhotoViewGalleryPageOptions(
                imageProvider: CachedNetworkImageProvider(image));
          }),
    );
  }
}
