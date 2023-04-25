// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:before_after_image_slider_nullsafty/before_after_image_slider_nullsafty.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'BgRemoverApikey.dart';

class BgRemoverHomeScreen extends StatefulWidget {
  const BgRemoverHomeScreen({super.key});

  @override
  State<BgRemoverHomeScreen> createState() => _BgRemoverHomeScreenState();
}

class _BgRemoverHomeScreenState extends State<BgRemoverHomeScreen> {
  var loaded = false;
  var removedbg = false;
  var isLoading = false;
  Uint8List? image;
  String imagePath = "";

  ScreenshotController screenshotController = ScreenshotController();

  pickImage() async {
    final img = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 100);

    if (img != null) {
      imagePath = img.path;
      loaded = true;

      setState(() {});
    } else {}
  }

  downloadImage() async {
    var perm = await Permission.storage.request();

    if (perm.isGranted) {
      ImageGallerySaver.saveImage(image!);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Downloaded to Gallery")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text(
                            'How to use:\n\n1. Upload the image from which you had to remove the background.\n\n2. Click on the "Remove Background" button.\n\n3. You can download the output directly to your gallery.\n\n*NOTE*\n\nThis application uses removeBG API to remove the background from the image.'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('OK'))
                        ],
                      );
                    });
              },
              icon: const Icon(Icons.info_outline, color: Colors.white)),
          IconButton(
              onPressed: () {
                downloadImage();
              },
              icon: const Icon(Icons.download))
        ],
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'AI Background Remover',
          style: TextStyle(fontSize: 19),
        ),
      ),
      body: Center(
        child: removedbg
            ? BeforeAfter(
                beforeImage: Image.file(File(imagePath)),
                afterImage: Screenshot(
                    controller: screenshotController,
                    child: Image.memory(image!)))
            : loaded
                ? GestureDetector(
                    onTap: () {
                      pickImage();
                    },
                    child: Image.file(
                      File(imagePath),
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.all(40),
                    child: SizedBox(
                      width: 300,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          pickImage();
                        },
                        child: const Text(
                          "Choose Image",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
      ),
      bottomNavigationBar: SizedBox(
        height: 56,
        child: ElevatedButton(
          onPressed: loaded
              ? () async {
                  setState(() {
                    isLoading = true;
                  });
                  image = await Api.removebg(imagePath);
                  if (image != null) {
                    removedbg = true;
                    isLoading = false;

                    setState(() {});
                  }
                }
              : null,
          child: isLoading
              ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                )
              : const Text("Remove Background"),
        ),
      ),
    );
  }
}
