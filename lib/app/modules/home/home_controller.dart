// ignore_for_file: prefer_final_fields, invalid_use_of_protected_member

import 'package:get/get.dart';

import '../../data/models/id_images.dart';
import '../../data/providers/local/boxes.dart';
import '../../routers/app_routes.dart';

class HomeController extends GetxController {
  RxList<IdImages> _images = <IdImages>[].obs;
  List<IdImages> get images => _images.value;

  RxBool _loading = true.obs;
  bool get loading => _loading.value;

  void _getImages() {
    final box = Boxes.getIdImages();
    _images.value = box.values.toList();
  }

  void _init() {
    final box = Boxes.getIdImages();

    final id1 = IdImages()
      ..id = '123ABC'
      ..lengthImgs = 0;
    final id2 = IdImages()
      ..id = '456DEF'
      ..lengthImgs = 0;
    final id3 = IdImages()
      ..id = '789GHI'
      ..lengthImgs = 0;

    box.add(id1);
    box.add(id2);
    box.add(id3);

    _getImages();
  }

  void toAddImages(IdImages model) {
    Get.toNamed(
      Routes.ADD_IMAGES,
      arguments: model,
    );
  }

  @override
  void onInit() {
    _loading.value = true;
    _getImages();
    if (images.isEmpty) {
      _init();
    }
    _loading.value = false;
    super.onInit();
  }

  // @override
  // void onClose() {
  //   ///Close connection hive
  //   // Hive.close(); //Close all
  //   // Hive.box('id_images').close(); //Close only one
  //   super.onClose();
  // }
}
