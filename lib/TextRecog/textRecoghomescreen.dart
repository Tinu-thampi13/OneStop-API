// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'dart:io';
// ignore: library_prefixes
import 'dart:io' as Io;
import 'package:clipboard/clipboard.dart';
import 'package:share_plus/share_plus.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import 'apikey.dart';

// ignore: camel_case_types
class textRecoghomescreen extends StatefulWidget {
  const textRecoghomescreen({super.key});

  @override
  State<textRecoghomescreen> createState() => _textRecoghomescreenState();
}

// ignore: camel_case_types
class _textRecoghomescreenState extends State<textRecoghomescreen> {
  late File pickedimage;
  bool scanning = false;
  String scannedText = '';

  optionsdialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            children: [
              SimpleDialogOption(
                onPressed: () => pickimage(ImageSource.gallery),
                child: const Text('Gallery',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    )),
              ),
              SimpleDialogOption(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    )),
              )
            ],
          );
        });
  }

  dynamic hello = const AssetImage('assets/upload_icon.png');
  pickimage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    setState(() {
      scanning = true;
      pickedimage = File(image!.path);

      hello = pickedimage == null
          ? const AssetImage('assets/upload_icon.png')
          : FileImage(pickedimage);
    });
    // ignore: use_build_context_synchronously
    Navigator.pop(context);

    Uint8List bytes = Io.File(pickedimage.path).readAsBytesSync();
    String img64 = base64Encode(bytes);
    final url = Uri.parse("https://api.ocr.space/parse/image");
    var data = {"base64Image": "data:image/jpg;base64,$img64"};
    var header = {"apikey": Textapikey};
    http.Response response = await http.post(url, body: data, headers: header);
    Map result = jsonDecode(response.body);
    setState(() {
      scanning = false;
      scannedText = result['ParsedResults'][0]['ParsedText'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: Null,
            onPressed: () {
              FlutterClipboard.copy(scannedText).then((value) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Successfully Copied!!'),
                ));
              });
            },
            child: const Icon(
              Icons.copy,
              size: 28,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            heroTag: 'btn1',
            onPressed: () {
              Share.share(
                scannedText,
              );
            },
            child: const Icon(
              Icons.reply,
              size: 28,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            heroTag: 'btn2',
            onPressed: () {
              setState(() {
                hello = const AssetImage('assets/upload_icon.png');
                pickedimage = File("");
                scannedText = "";
              });
            },
            child: const Icon(
              Icons.delete,
              size: 28,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              const SizedBox(
                height: 70,
              ),
              Row(
                children: [
                  const SizedBox(width: 60),
                  const Text(
                    'TEXT EXTRACTOR',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Colors.blue),
                  ),
                  const SizedBox(width: 20),
                  IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text(
                                    'How to use:\n\n1. Upload the image from which you had to extract text.\n\n2. The API will be automatically scan the image and extract the text from it.\n\n3. You can copy the text to the clipboard , share it with your friends and also delete all inputs and outputs.\n\n*NOTE*\n\nThis application uses the OCR.Space API to extract text from the image.'),
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
                      icon: const Icon(Icons.info_outline, color: Colors.black))
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              const Divider(
                thickness: 1,
                color: Colors.black,
                endIndent: 15.0,
                indent: 15.0,
              ),
              Container(
                padding: hello == const AssetImage('assets/upload_icon.png')
                    ? const EdgeInsets.all(0)
                    : const EdgeInsets.all(30),
                child: InkWell(
                  onTap: () => {
                    optionsdialog(context),
                  },
                  child: Image(
                    width: 550,
                    height: 250,
                    image: hello,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 1,
                color: Colors.black,
                endIndent: 15.0,
                indent: 15.0,
              ),
              const SizedBox(
                height: 30,
              ),
              scanning
                  ? const Text('Scanning....')
                  : Text(
                      scannedText,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    )
            ],
          ),
        ),
      ),
    );
  }
}
