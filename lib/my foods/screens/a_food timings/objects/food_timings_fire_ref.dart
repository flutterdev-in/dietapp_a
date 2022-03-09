import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:dietapp_a/my%20foods/objects/my_foods_strings.dart';
import 'package:dietapp_a/my%20foods/screens/a_food%20timings/objects/food_timing_strings.dart';
import 'package:dietapp_a/userData/models/user_strings.dart';

final CollectionReference foodTimingCR = FirebaseFirestore.instance
    .collection(uss.users)
    .doc(userUID)
    .collection(myfs.userFoods)
    .doc(ftms.foodTimingsFoods)
    .collection(myfs.subCollection);
