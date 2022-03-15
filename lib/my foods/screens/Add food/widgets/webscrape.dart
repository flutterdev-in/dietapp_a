import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_scraper/web_scraper.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlparser;

class WebScrapeForFDlist extends StatelessWidget {
  WebScrapeForFDlist({Key? key}) : super(key: key);
  Rx<String> rxScrape = "".obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(onPressed: () => scrape(), child: Text("Scrape")),
        ],
      ),
      body: Obx(() => SingleChildScrollView(child: Text(rxScrape.value))),
    );
  }

  Future<void> scrape() async {
    final response = await http.get(Uri.parse(
        "https://www.youtube.com/results?search_query=chicken+biryani"));

    var document = htmlparser.parse(response.body);
    var elements = document.getElementsByClassName("style-scope ytd-app");
    // var listt = elements.map((e) => e.getElementsByTagName("a")[0].innerHtml).toList();
    rxScrape.value = document.attributes.toString();
  }

  webscp() async {
    final rawUrl =
        'https://www.youtube.com/results?search_query=chicken+biryani';
    final webScraper = WebScraper('https://www.youtube.com');
    final endpoint = rawUrl.replaceAll('https://www.youtube.com', '');
    if (await webScraper.loadWebPage(endpoint)) {
      String hfhvb = webScraper.getPageContent();
      final titleElements = webScraper.getElement(
          'ytd-video-renderer.style-scope ytd-item-section-renderer > a.yt-simple-endpoint inline-block style-scope ytd-thumbnail',
          ['href']);

      if (hfhvb.contains(
          "yt-simple-endpoint inline-block style-scope ytd-thumbnail")) {
        rxScrape.value = "true".toString();
      } else {
        rxScrape.value = "false".toString();
      }
    }
  }
}
