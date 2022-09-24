// ignore_for_file: prefer_final_fields, invalid_use_of_protected_member

import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../data/models/id_images.dart';

class AddImagesController extends GetxController {
  Rx<IdImages> _image = IdImages().obs;
  IdImages get image => _image.value;

  RxList<String> _imagesFiles = <String>[].obs;
  List<String> get imagesFiles => _imagesFiles.value;

  RxBool _loading = true.obs;
  bool get loading => _loading.value;

  RxBool _flagPhoto = false.obs;
  bool get flagPhoto => _flagPhoto.value;

  //ruta del archivo
  late Directory _rutaImg;

  Future<void> takePhoto() async {
    _flagPhoto.value = true;
    try {
      // final picker = ImagePicker();
      final file = await ImagePicker().pickImage(
        source: ImageSource.camera,
      );
      if (file != null) {
        // TODO: Add Image
        await _addImage(file);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      _flagPhoto.value = false;
    }
  }

  List<String> _reviewList() {
    List<String> tmpList = [];
    //use your folder name insted of resume.
    final file = _rutaImg.listSync();
    if (file.isNotEmpty) {
      for (FileSystemEntity row in file) {
        if (row.toString().contains(image.id)) {
          tmpList.add(row.path);
          log(row.path);
        }
      }
    }
    return tmpList;
  }

  Future<void> _giveList() async {
    int index = 0;
    final tmpList = _reviewList();
    _imagesFiles.value = tmpList;
    _image.value.lengthImgs = tmpList.isEmpty ? 0 : tmpList.length;
    await _image.value.save();
  }

  Future<void> _addImage(XFile imageToSave) async {
    int idFile = 1;
    final tmpList = _reviewList();
    if (tmpList.isNotEmpty) {
      //Obtener el ultimo elemento
      final tmpItem = (tmpList[tmpList.length - 1]).split('-');
      //obtener el nombre
      // final tmpRoute = tmpItem.split('-');
      final tmpName = (tmpItem[1]).split('.');
      //obtener el id de la imagen
      // final tmpID = tmpName.split('.');
      final lastId = int.parse(tmpName[0]);
      //guardar en idFile
      idFile = lastId;
    }

    // _imagesFiles.value.isEmpty
    //     ? idFile = 1
    //     : idFile = _imagesFiles.value.length + 1;

    //Nombre del archivo
    final nombreImg = "${image.id}-$idFile";
    //ruta en texto del archivo
    final rutaImgTxt = "${_rutaImg.path}/$nombreImg.jpg";
    log(rutaImgTxt);

    await imageToSave.saveTo(rutaImgTxt);

    await _giveList();
  }

  Future<void> _makeDirectory() async {
    //*** Comprobar directorio imagenes
    final tmpPath = await getApplicationDocumentsDirectory();
    _rutaImg = Directory("${tmpPath.path}/Imagenes");
    if (!await _rutaImg.exists()) {
      await _rutaImg.create();
    }
  }

  @override
  void onInit() async {
    _loading.value = true;
    _image.value = Get.arguments;
    await _makeDirectory();
    await _giveList();
    _loading.value = false;
    super.onInit();
  }
}
