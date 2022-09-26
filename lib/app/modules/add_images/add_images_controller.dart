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

  RxBool _reloadPhotos = false.obs;
  bool get reloadPhotos => _reloadPhotos.value;

  //ruta del archivo
  late Directory _rutaImg;

  Future<void> deletePhoto(String path) async {
    _reloadPhotos.value = true;

    final file = File(path);
    try {
      await file.delete();
      await _giveList();
    } catch (e) {
      log(e.toString());
    } finally {
      _reloadPhotos.value = false;
    }
  }

  Future<void> takePhoto() async {
    _flagPhoto.value = true;
    try {
      final file = await ImagePicker().pickImage(
        source: ImageSource.camera,
      );
      if (file != null) {
        await _addImage(file);
        await _giveList();
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
    final tmpList = _reviewList();
    _imagesFiles.value = tmpList;
    _image.value.lengthImgs = tmpList.isEmpty ? 0 : tmpList.length;
    await image.save();
  }

  int _giveLastID(List<String> list) {
    /// lista de enteros
    List<int> tmpList = [];

    /// Se recorre la lista de Strings
    for (String row in list) {
      /// Se separá la lista por '-'
      final rowSplit1 = row.split('-');

      /// Se separá la lista por '.'
      final rowSplit2 = (rowSplit1[1].split('.'));

      /// Se obtiene el ID
      final id = int.parse(rowSplit2[0]);

      /// Se agrega a la lista de enteros
      tmpList.add(id);
    }
    log(tmpList.toString());

    /// Se acomoda la lista
    tmpList.sort();
    log(tmpList.toString());

    /// Se retorna el último valor de la lista
    return tmpList[tmpList.length - 1];
  }

  // void _list

  Future<void> _addImage(XFile imageToSave) async {
    int idFile = 1;
    final tmpList = _reviewList();
    if (tmpList.isNotEmpty) {
      //Se obtiene el último id
      final lastId = _giveLastID(tmpList);
      //guardar en idFile
      idFile = lastId + 1;
    }
    //Nombre del archivo
    final nombreImg = "${image.id}-$idFile";
    //ruta en texto del archivo
    final rutaImgTxt = "${_rutaImg.path}/$nombreImg.jpg";
    log(rutaImgTxt);

    await imageToSave.saveTo(rutaImgTxt);
  }

  @override
  void onInit() async {
    _loading.value = true;
    _image.value = Get.arguments;
    final tmpPath = await getApplicationDocumentsDirectory();
    _rutaImg = Directory("${tmpPath.path}/Imagenes");
    await _giveList();
    _loading.value = false;
    super.onInit();
  }
}
