// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';

import '../modules/add_images/add_images_bindings.dart';
import '../modules/add_images/add_images_page.dart';
import '../modules/home/home_bindings.dart';
import '../modules/home/home_page.dart';
import 'app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.ADD_IMAGES,
      page: () => AddImagesPage(),
      binding: AddImagesBinding(),
    ),
  ];
}
