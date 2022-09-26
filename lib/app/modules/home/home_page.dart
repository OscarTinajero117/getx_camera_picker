import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global_widgets/load_splash.dart';
import '../../global_widgets/rounded_button.dart';
import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.loading
        ? const LoadSplash(mensaje: 'Loading')
        : Scaffold(
            appBar: AppBar(
              title: const Center(
                child: Text('Home'),
              ),
            ),
            body: Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(10.0),
              width: double.infinity,
              height: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10.0),
                    const Text('Add Images'),
                    const SizedBox(height: 10.0),
                    Obx(() => RoundedButton(
                          text:
                              'ID ${controller.images[0].id} - ${controller.images[0].lengthImgs}',
                          onPressed: () {
                            controller.toAddImages(controller.images[0]);
                          },
                        )),
                    Obx(() => RoundedButton(
                          text:
                              'ID ${controller.images[1].id} - ${controller.images[1].lengthImgs}',
                          onPressed: () {
                            controller.toAddImages(controller.images[1]);
                          },
                        )),
                    Obx(() => RoundedButton(
                          text:
                              'ID ${controller.images[2].id} - ${controller.images[2].lengthImgs}',
                          onPressed: () {
                            controller.toAddImages(controller.images[2]);
                          },
                        )),
                  ],
                ),
              ),
            ),
          ));
  }
}
