import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/y_Firebase/fire_ref.dart';

final ConstantObjectsPlanCreate copc = ConstantObjectsPlanCreate();

class ConstantObjectsPlanCreate {
  final String dietPlans = "dietPlans";
  final String dietPlansBeta = "dietPlansBeta";
  String startPlanEdit = "startPlanEdit";
  String boxPlanCreate = "boxPlanCreate";
  final CollectionReference<Map<String, dynamic>> dietPlansCR =
      userDR.collection(copc.dietPlans);
  String timings = "timings";
}
