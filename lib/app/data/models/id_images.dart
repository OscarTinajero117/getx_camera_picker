import 'package:hive/hive.dart';
part 'id_images.g.dart';

@HiveType(typeId: 0)
class IdImages extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late int lengthImgs;
}
