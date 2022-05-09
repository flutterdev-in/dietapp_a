import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';

class MultiImageViewerScreen extends StatefulWidget {
  final PageController pageController;
  final List<String> listImgUrl;
  final int initialIndex;
  MultiImageViewerScreen({
    Key? key,
    required this.listImgUrl,
    required this.initialIndex,
  }) : pageController = PageController(initialPage: initialIndex);

  @override
  State<MultiImageViewerScreen> createState() => _MultiImageViewerScreenState();

  
}

class _MultiImageViewerScreenState extends State<MultiImageViewerScreen> {
  @override
  void didChangeDependencies() {
    context. dependOnInheritedWidgetOfExactType(); // OK
    super.didChangeDependencies();
  }
  @override
  void dispose() {
    widget.pageController.dispose();
    context. dependOnInheritedWidgetOfExactType();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(),
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
