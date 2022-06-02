import 'package:cached_network_image/cached_network_image.dart';
import 'package:dietapp_a/y_Active%20diet/models/active_food_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class MultiImageViewerScreen extends StatefulWidget {
  final PageController pageController;
  final List<ActiveFoodModel> listAFM;
  final int initialIndex;
  MultiImageViewerScreen({
    Key? key,
    required this.listAFM,
    required this.initialIndex,
  }) : pageController = PageController(initialPage: initialIndex);

  @override
  State<MultiImageViewerScreen> createState() => _MultiImageViewerScreenState();
}

class _MultiImageViewerScreenState extends State<MultiImageViewerScreen> {
  @override
  void didChangeDependencies() {
    context.dependOnInheritedWidgetOfExactType(); // OK
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    widget.pageController.dispose();
    context.dependOnInheritedWidgetOfExactType();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var rxIndex = widget.initialIndex.obs;
    return Scaffold(
      extendBodyBehindAppBar: true,
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Obx(() {
          var afm = widget.listAFM[rxIndex.value];
          var time = DateFormat("dd MMM yyyy (EEE) hh:mm a")
              .format(afm.takenTime ?? DateTime.now());
          return Text(time, textScaleFactor: 0.8);
        }),
      ),
      body: Stack(
        children: [
          PhotoViewGallery.builder(
            pageController: widget.pageController,
            itemCount: widget.listAFM.length,
            builder: (context, index) {
              var afm = widget.listAFM[index];
              return PhotoViewGalleryPageOptions(
                  minScale: PhotoViewComputedScale.contained * 0.2,
                  maxScale: PhotoViewComputedScale.contained * 2,
                  imageProvider: CachedNetworkImageProvider(afm.trud!.img!));
            },
            onPageChanged: (index) {
              rxIndex.value = index;
            },
          ),
        ],
      ),
    );
  }
}
