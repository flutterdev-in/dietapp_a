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
      choiceFMS.choiceIndex: choiceIndex,
      choiceFMS.choiceName: choiceName,

      choiceFMS.notes: notes,
      choiceFMS.refURL: refURL,
    };
  }

  factory FoodsModelForPlan.fromMap(Map dataMap) {
    return FoodsModelForPlan(
      choiceIndex: dataMap[choiceFMS.choiceIndex],
      choiceName: dataMap[choiceFMS.choiceName],
 
      notes: dataMap[choiceFMS.notes],
      refURL: dataMap[choiceFMS.refURL],
    );
  }
}

final ChoiceFoodsModelStrings choiceFMS = ChoiceFoodsModelStrings();

class ChoiceFoodsModelStrings {
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
