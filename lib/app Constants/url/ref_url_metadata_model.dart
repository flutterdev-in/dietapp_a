import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:metadata_fetch/metadata_fetch.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class RefUrlMetadataModel {
  String url;
  String? img;
  String? title;
  bool isYoutubeVideo;
  String? youtubeVideoLength;

  RefUrlMetadataModel({
    required this.url,
    required this.img,
    required this.title,
    required this.isYoutubeVideo,
    required this.youtubeVideoLength,
  });

  Map<String, dynamic> toMap() {
    return {
      rummfos.url: url,
      rummfos.img: img,
      rummfos.title: title,
      rummfos.isYoutubeVideo: isYoutubeVideo,
      rummfos.youtubeVideoLength: youtubeVideoLength,
    };
  }

  factory RefUrlMetadataModel.fromMap(Map dayPlanMap) {
    return RefUrlMetadataModel(
      url: dayPlanMap[rummfos.url],
      img: dayPlanMap[rummfos.img],
      title: dayPlanMap[rummfos.title],
      isYoutubeVideo: dayPlanMap[rummfos.isYoutubeVideo] ?? false,
      youtubeVideoLength: dayPlanMap[rummfos.youtubeVideoLength],
    );
  }
}

final RefUrlMetadataModelFinalObjects rummfos =
    RefUrlMetadataModelFinalObjects();

class RefUrlMetadataModelFinalObjects {
  final String url = "url";
  final String img = "img";
  final String title = "title";
  final String isYoutubeVideo = "isYoutubeVideo";
  final String youtubeVideoLength = "youtubeVideoLength";
  final String rumm = "rumm"; // refUrlMetadataMap / Model
  final RefUrlMetadataModel constModel = RefUrlMetadataModel(
      url: mYoutubeCom,
      img: null,
      title: null,
      isYoutubeVideo: false,
      youtubeVideoLength: null);

  bool isYtVideo(String? url0) {
    if (url0?.contains(youtubeVideoIndentifyURL) ?? false) {
      return true;
    } else {
      return false;
    }
  }

  String getDuration(Duration? duration) {
    String length = duration.toString().split(".").first;

    bool isHourZero = length.split(":").first == "0";
    if (duration == null) {
      return "";
    } else if (isHourZero) {
      List<String> time = length.split(":");
      return " " + time[1] + ":" + time[2] + " ";
    } else {
      return " " + length + " ";
    }
  }

  Future<String?> ytVideoLength(String? url0) async {
    if (isYtVideo(url0)) {
      Video video = await YoutubeExplode().videos.get(url0);
      return getDuration(video.duration);
    } else {
      return null;
    }
  }

  Future<RefUrlMetadataModel?> rummModel(String? url0,
      {Metadata? metaData}) async {
    if (url0 != null) {
      metaData ??= await MetadataFetch.extract(url0);
      if (metaData != null) {
        return RefUrlMetadataModel(
            url: url0,
            img: metaData.image,
            title: metaData.title,
            isYoutubeVideo: isYtVideo(url0),
            youtubeVideoLength: await ytVideoLength(url0));
      }
    }
    return null;
  }

  RefUrlMetadataModel? rummFromRummMap(var rumm0) {
    if (rumm0 is Map) {
      return RefUrlMetadataModel.fromMap(rumm0);
    } else {
      return null;
    }
  }
}
