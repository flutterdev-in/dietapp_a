import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/y_Firebase/fire_ref.dart';

ConstantObjectsPlanCreate copc = ConstantObjectsPlanCreate();

class ConstantObjectsPlanCreate {
  String dietPlans = "dietPlans";
  String startPlanEdit = "startPlanEdit";
  String boxPlanCreate = "boxPlanCreate";
  CollectionReference<Map<String, dynamic>> dietPlansCR = userDR.collection(copc.dietPlans);
  String timings = "timings";
}
