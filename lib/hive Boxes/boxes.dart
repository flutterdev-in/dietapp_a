import 'package:dietapp_a/hive%20Boxes/box_names.dart';
import 'package:hive/hive.dart';

final Box boxFavWebPages = Hive.box(BoxNames.favWebPages);
final Box boxIndexes = Hive.box(BoxNames.indexes);
final Box boxServices = Hive.box(BoxNames.services);
