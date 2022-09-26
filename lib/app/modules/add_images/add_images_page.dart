import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global_widgets/load_splash.dart';
import '../../global_widgets/rounded_button.dart';
import 'add_images_controller.dart';

class AddImagesPage extends GetView<AddImagesController> {
  const AddImagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.loading
        ? const LoadSplash(mensaje: 'Loading')
        : Scaffold(
            appBar: AppBar(
              title: const Center(
                child: Text('Add Images'),
              ),
            ),
            body: Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(10.0),
              width: double.infinity,
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      Obx(() => Text(
                            'ID ${controller.image.id}',
                          )),
                      const SizedBox(width: 10.0),
                      Obx(() => Text(
                            'Images: ${controller.image.lengthImgs}',
                          )),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Obx(() => controller.flagPhoto
                      ? const CircularProgressIndicator.adaptive()
                      : RoundedButton(
                          text: 'Add Image',
                          onPressed: () async {
                            await controller.takePhoto();
                          },
                        )),
                  const SizedBox(height: 10.0),
                  Obx(
                    () => controller.imagesFiles.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(
                                  Icons.photo_library_rounded,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "Images Empty",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 20,
                                  ),
                                )
                              ],
                            ),
                          )
                        : Expanded(
                            child: Obx(() => controller.reloadPhotos
                                ? const CircularProgressIndicator.adaptive()
                                : GridView.count(
                                    crossAxisCount: 2,
                                    children: List.generate(
                                      controller.imagesFiles.length,
                                      (index) {
                                        String imagePath =
                                            controller.imagesFiles[index];
                                        return Stack(
                                          children: [
                                            Center(
                                              child: Container(
                                                margin:
                                                    const EdgeInsets.all(10),
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: Colors.grey,
                                                  image: DecorationImage(
                                                    image: FileImage(
                                                      File(imagePath),
                                                      scale: 0.5,
                                                    ),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                            _iconImage(
                                              Alignment.topRight,
                                              Icons
                                                  .indeterminate_check_box_rounded,
                                              iconColor: Colors.red,
                                              onPressed: () {
                                                controller
                                                    .deletePhoto(imagePath);
                                              },
                                              size: 30,
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  )),
                          ),
                  ),
                ],
              ),
            ),
          ));
  }

  Widget _iconImage(
    AlignmentGeometry alignment,
    IconData icon, {
    VoidCallback? onPressed,
    Color iconColor = Colors.white,
    double size = 24,
  }) {
    return Align(
      alignment: alignment,
      child: onPressed == null
          ? Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.green.shade300,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: size,
                color: iconColor,
              ),
            )
          : IconButton(
              color: iconColor,
              icon: Icon(
                icon,
                size: size,
              ),
              onPressed: () => onPressed(),
              padding: const EdgeInsets.all(1),
            ),
    );
  }
}
