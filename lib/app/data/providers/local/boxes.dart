import 'package:hive/hive.dart';

import '../../models/id_images.dart';

class Boxes {
  static Box<IdImages> getIdImages() => Hive.box<IdImages>('id_images');
}
