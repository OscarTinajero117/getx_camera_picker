import 'dart:io';

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
                    // Images Carrussel
                    SizedBox(
                      height: 200,
                      child: ListView.separated(
                        padding: const EdgeInsets.all(16.0),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final listItems = controller
                              .allImagesFromID(controller.images[0].id);
                          final item = listItems[index];

                          return BuildCardImage(image: item);
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 12),
                        itemCount: controller
                            .allImagesFromID(controller.images[0].id)
                            .length,
                      ),
                    ),
                    Obx(() => RoundedButton(
                          text:
                              'ID ${controller.images[1].id} - ${controller.images[1].lengthImgs}',
                          onPressed: () {
                            controller.toAddImages(controller.images[1]);
                          },
                        )),
                    SizedBox(
                      height: 200,
                      child: ListView.separated(
                        padding: const EdgeInsets.all(16.0),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final listItems = controller
                              .allImagesFromID(controller.images[1].id);
                          final item = listItems[index];

                          return BuildCardImage(image: item);
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 12),
                        itemCount: controller
                            .allImagesFromID(controller.images[1].id)
                            .length,
                      ),
                    ),
                    Obx(() => RoundedButton(
                          text:
                              'ID ${controller.images[2].id} - ${controller.images[2].lengthImgs}',
                          onPressed: () {
                            controller.toAddImages(controller.images[2]);
                          },
                        )),
                    // SizedBox(
                    //   height: 200,
                    //   child: ListView.separated(
                    //     padding: const EdgeInsets.all(16.0),
                    //     scrollDirection: Axis.horizontal,
                    //     itemBuilder: (context, index) {
                    //       final listItems = controller
                    //           .allImagesFromID(controller.images[2].id);
                    //       final item = listItems[index];

                    //       return BuildCardImage(image: item);
                    //     },
                    //     separatorBuilder: (context, index) =>
                    //         const SizedBox(width: 12),
                    //     itemCount: controller
                    //         .allImagesFromID(controller.images[2].id)
                    //         .length,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ));
  }
}

class BuildCardImage extends StatelessWidget {
  final String image;
  const BuildCardImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Expanded(
        child: AspectRatio(
          aspectRatio: 4 / 3,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Image.file(
              File(image),
            ),
          ),
        ),
      ),
    );
  }
}
