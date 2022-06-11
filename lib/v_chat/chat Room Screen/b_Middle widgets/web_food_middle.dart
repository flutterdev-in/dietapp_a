import 'package:cached_network_image/cached_network_image.dart';
import 'package:dietapp_a/v_chat/chat%20Room%20Screen/b_Middle%20widgets/_common_top_widget_middle.dart';
import 'package:dietapp_a/x_customWidgets/web%20view/web_view_page.dart';
import 'package:dietapp_a/y_Models/food_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebFoodMiddle extends StatelessWidget {
  final FoodModel fdcm;

  final String? text;
  const WebFoodMiddle({Key? key, required this.fdcm, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonTopWidgetMiddle(
      text: text,
      child: InkWell(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (fdcm.rumm?.img != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: CachedNetworkImage(
                  imageUrl: fdcm.rumm!.img!,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            SizedBox(
              width: double.maxFinite,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(fdcm.foodName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                    )),
              ),
            ),
          ],
        ),
        onTap: () {
          if (fdcm.rumm != null) {
            Get.to(() => WebViewPage(fdcm.rumm!.url, fdcm.foodName));
          }
        },
      ),
    );
  }
}
