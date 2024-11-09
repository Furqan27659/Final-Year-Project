// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:image_picker/image_picker.dart';

class ScanningScreen extends StatefulWidget {
  const ScanningScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ScanningScreen> createState() => _ScanningScreenState();
}

class _ScanningScreenState extends State<ScanningScreen> {
  int state = 1;

  String pickedImagePath = '';
  String modelOutput = '';
// load cataract model
  loadFruitModel() async {
    try {
      await Tflite.loadModel(
          model: 'assets/models/model_unquant.tflite',
          labels: 'assets/models/labels.txt');
      setState(() {});
      print('Fruit model is loaded');
      detectImageForFruitModel();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  detectImageForFruitModel() async {
    var output = await Tflite.runModelOnImage(
        path: pickedImagePath,
        numResults: 3,
        threshold: 0.6,
        imageMean: 127.5,
        imageStd: 127.5);
    setState(() {
      modelOutput = output![0]['label'].toString();
    });
    debugPrint(
        "detected output of fruit model is:${output![0]['label'].toString()}");
  }

  // loadLumpModel() async {
  //   try {
  //     await Tflite.loadModel(
  //         model: 'assets/model/Lump6May.tflite',
  //         labels: 'assets/labels/lump6MayLabels.txt');
  //     setState(() {});
  //     print('lump model is loaded');
  //     detectForLumpModel();
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  // detectForLumpModel() async {
  //   var output = await Tflite.runModelOnImage(
  //       path: widget.imagePath,
  //       numResults: 3,
  //       threshold: 0.6,
  //       imageMean: 127.5,
  //       imageStd: 127.5);
  //   setState(() {
  //     results.add(
  //       output![0]['label'].toString(),
  //     );
  //     confidence.add(output[0]['confidence'].toString());
  //   });
  //   debugPrint(
  //       "confidence of  lump model:${output![0]['confidence'].toString()}");
  //   debugPrint(
  //       "detected output of lump model is:${output[0]['label'].toString()}");
  // }

  // loadPterygiumModel() async {
  //   try {
  //     await Tflite.loadModel(
  //         model: 'assets/model/25aprpterygium.tflite',
  //         labels: 'assets/labels/25aprpterygium.txt');
  //     setState(() {});
  //     print('Pterygium model is loaded');
  //     detectForPterygiumModel();
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  // detectForPterygiumModel() async {
  //   var output = await Tflite.runModelOnImage(
  //       path: widget.imagePath,
  //       numResults: 3,
  //       threshold: 0.6,
  //       imageMean: 127.5,
  //       imageStd: 127.5);
  //   setState(() {
  //     results.add(
  //       output![0]['label'].toString(),
  //     );
  //     confidence.add(output[0]['confidence'].toString());
  //   });
  //   debugPrint(
  //       "confidence of  Pterygium model:${output![0]['confidence'].toString()}");
  //   debugPrint(
  //       "detected output of Pterygium model is:${output[0]['label'].toString()}");
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // setState(() {
        //   results.clear();
        // });
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 70,
          title: const Text(
            'Scanning Test',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50))),
          ),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (pickedImagePath.isNotEmpty)
                Center(
                  child: Image.file(
                    File(pickedImagePath),
                    height: 300,
                    width: 300,
                    fit: BoxFit.contain,
                  ),
                ),
              //   const SizedBox(height: 20),

              TextButton(
                onPressed: () async {
                  final ImagePicker picker = ImagePicker();
                  final XFile? image =
                      await picker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    setState(() {
                      pickedImagePath = image.path;
                    });
                  }
                },
                child: const Text(
                  'Pick Image',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              InkWell(
                onTap: () async {
                  await loadFruitModel();
                },
                child: Container(
                  height: 50,
                  width: 200,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Text(
                    'Start Scanning',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),

              if (modelOutput.isNotEmpty)
                Text(
                  modelOutput,
                  style: const TextStyle(color: Colors.white),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
