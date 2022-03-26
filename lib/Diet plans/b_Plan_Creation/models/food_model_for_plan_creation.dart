class FoodsModelForPlanCreation {
  int? choiceIndex;
  int? optionIndex;
  int? foodIndex;
  String foodName;
  String? imgURL;
  String? notes;
  String? refURL;

  FoodsModelForPlanCreation({
    required this.choiceIndex,
    required this.optionIndex,
    required this.foodIndex,
    required this.foodName,
    required this.notes,
    required this.imgURL,
    required this.refURL,
  });

  Map<String, dynamic> toMap() {
    return {
      fmfpcfos.choiceIndex: choiceIndex,
      fmfpcfos.optionIndex: optionIndex,
      fmfpcfos.foodIndex: foodIndex,
      fmfpcfos.foodName: foodName,
      fmfpcfos.imgURL: imgURL,
      fmfpcfos.notes: notes,
      fmfpcfos.refURL: refURL,
    };
  }

  factory FoodsModelForPlanCreation.fromMap(Map dataMap) {
    return FoodsModelForPlanCreation(
      choiceIndex: dataMap[fmfpcfos.choiceIndex],
      optionIndex: dataMap[fmfpcfos.optionIndex],
      foodIndex: dataMap[fmfpcfos.foodIndex],
      foodName: dataMap[fmfpcfos.foodName],
      imgURL: dataMap[fmfpcfos.imgURL],
      notes: dataMap[fmfpcfos.notes],
      refURL: dataMap[fmfpcfos.refURL],
    );
  }
}

final FoodsModelForPlanCreationFinalObjects fmfpcfos =
    FoodsModelForPlanCreationFinalObjects();

class FoodsModelForPlanCreationFinalObjects {
  final String choiceIndex = "choiceIndex";
  final String optionIndex = "optionIndex";
  final String foodIndex = "foodIndex";
  final String foodName = "foodName";
  final String imgURL = "imgURL";
  final String notes = "notes";
  final String refURL = "refURL";
}
