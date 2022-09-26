// ignore_for_file: prefer_final_fields, invalid_use_of_protected_member

import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../../data/models/id_images.dart';
import '../../data/providers/local/boxes.dart';
import '../../routers/app_routes.dart';

class HomeController extends GetxController {
  RxList<IdImages> _images = <IdImages>[].obs;
  List<IdImages> get images => _images.value;

  RxList<String> _imagesFiles = <String>[].obs;
  List<String> get imagesFiles => _imagesFiles.value;

  RxBool _loading = true.obs;
  bool get loading => _loading.value;

  void _getImages() {
    final box = Boxes.getIdImages();
    _images.value = box.values.toList();
  }

  Future<void> _giveAllImages() async {
    final rutaImg = await _makeDirectory();
    List<String> tmpList = [];
    //use your folder name insted of resume.
    final file = rutaImg.listSync();
    if (file.isNotEmpty) {
      for (FileSystemEntity row in file) {
        tmpList.add(row.path);
        log(row.path);
      }
    }
    _imagesFiles.value = tmpList;
  }

  List<String> allImagesFromID(String id) {
    List<String> tmpList = [];
    for (String row in imagesFiles) {
      if (row.contains(id)) {
        tmpList.add(row);
        log(row);
      }
    }
    return tmpList;
  }

  Future<Directory> _makeDirectory() async {
    //*** Comprobar directorio imagenes
    final tmpPath = await getApplicationDocumentsDirectory();
    final rutaImg = Directory("${tmpPath.path}/Imagenes");
    if (!await rutaImg.exists()) {
      await rutaImg.create();
    }
    return rutaImg;
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
  void onInit() async {
    _loading.value = true;
    _getImages();
    if (images.isEmpty) {
      _init();
    }
    await _giveAllImages();
    _loading.value = false;
    super.onInit();
  }
}
