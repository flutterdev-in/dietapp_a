import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YtExplode extends StatelessWidget {
  YtExplode({Key? key}) : super(key: key);
  Rx<String> rxScrape = "".obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(onPressed: () => ytsearch(), child: Text("Scrape")),
        ],
      ),
      body: Obx(() => SingleChildScrollView(child: Text(rxScrape.value))),
    );
  }

  ytsearch() async {
    YoutubeExplode yt = YoutubeExplode();
    List searchk = await yt.search.getVideos("DietApp");
    Video v = searchk[0];
    var kk = v;
    // var ll = kk.
    rxScrape.value = kk.toString();
    print(rxScrape.value);
  }
}
