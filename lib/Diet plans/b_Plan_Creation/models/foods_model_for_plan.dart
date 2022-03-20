class FoodsModelForPlan {
  int choiceIndex;
  String choiceName;
  int? totalFoodsHas;
  String? notes;
  String? refURL;

  FoodsModelForPlan({
    required this.choiceIndex,
    required this.choiceName,
 
    required this.notes,
    required this.refURL,
  });

  Map<String, dynamic> toMap() {
    return {
      fmfpo.choiceIndex: choiceIndex,
      fmfpo.choiceName: choiceName,

      fmfpo.notes: notes,
      fmfpo.refURL: refURL,
    };
  }

  factory FoodsModelForPlan.fromMap(Map dataMap) {
    return FoodsModelForPlan(
      choiceIndex: dataMap[fmfpo.choiceIndex],
      choiceName: dataMap[fmfpo.choiceName],
 
      notes: dataMap[fmfpo.notes],
      refURL: dataMap[fmfpo.refURL],
    );
  }
}

final FoodsModelForPlanObjects fmfpo = FoodsModelForPlanObjects();

class FoodsModelForPlanObjects {
  final String choiceIndex = "choiceIndex";
  final String choiceName = "choiceName";
  final String totalFoodsHas = "totalFoodsHas";
  final String notes = "notes";
  final String refURL = "refURL";

  //
  final String choices = "choices";
  // Choices Map
  final String choiceModel  = "choiceModel";
  
}
