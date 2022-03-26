class RefUrlMetadataModel {
  String url;
  String? img;
  String? title;

  RefUrlMetadataModel({
    required this.url,
    required this.img,
    required this.title,
  });

  Map<String, dynamic> toMap() {
    return {
      rummfos.url: url,
      rummfos.img: img,
      rummfos.title: title,
    };
  }

  factory RefUrlMetadataModel.fromMap(Map dayPlanMap) {
    return RefUrlMetadataModel(
      url: dayPlanMap[rummfos.url],
      img: dayPlanMap[rummfos.img],
      title: dayPlanMap[rummfos.title],
    );
  }
}

final RefUrlMetadataModelFinalObjects rummfos =
    RefUrlMetadataModelFinalObjects();

class RefUrlMetadataModelFinalObjects {
  String url = "url";
  String img = "img";
  String title = "title";

  final RefUrlMetadataModel constModel = RefUrlMetadataModel(
      url: "https://m.youtube.com/", img: null, title: null);
}
