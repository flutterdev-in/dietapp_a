import 'package:dietapp_a/app%20Constants/constant_objects.dart';
import 'package:get/get.dart';

var userRxProfileName = (currentUser?.displayName ?? "").obs;
var userRxPhotoUrl = (currentUser?.photoURL ?? "").obs;
