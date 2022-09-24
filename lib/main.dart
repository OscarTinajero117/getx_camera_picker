import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

import 'app/data/models/id_images.dart';
import 'app/modules/home/home_bindings.dart';
import 'app/modules/home/home_page.dart';
import 'app/routers/app_pages.dart';
import 'app/routers/app_routes.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///init Hive
  await Hive.initFlutter();

  ///Register Adapter IdImages
  Hive.registerAdapter(IdImagesAdapter());

  ///Open My Box
  await Hive.openBox<IdImages>('id_images');

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: Routes.HOME,
    theme: ThemeData.light(),
    defaultTransition: Transition.fade,
    initialBinding: HomeBinding(),
    getPages: AppPages.pages,
    home: const HomePage(),
  ));
}
