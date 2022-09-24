import 'package:get/get.dart';

import 'add_images_controller.dart';

class AddImagesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddImagesController>(() => AddImagesController());
  }
}
