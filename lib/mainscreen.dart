import 'dart:io';

import 'package:camera/camera.dart';
import 'package:camera_n1/components/button.dart';
import 'package:camera_n1/components/toast.dart';
import 'package:camera_n1/gallery.dart';
import 'package:camera_n1/preview.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late List<CameraDescription> cameras;
  late CameraController cameraController;

  int direction = 0;
  String lastPicturePath = '';
  List<String> pictures = [];

  @override
  void initState() {
    startCamera(direction);
    super.initState();
  }

  void startCamera(int cam) async {
    cameras = await availableCameras();
    cameraController = CameraController(cameras[cam], ResolutionPreset.high,
        enableAudio: false);
    await cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((error) {
      toast('Error while initializing camera', 'error');
    });
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (cameraController.value.isInitialized) {
      return Scaffold(
          body: Stack(
            children: [
              CameraPreview(cameraController),
              GestureDetector(
                onTap: () {
                  switchDirection();
                },
                child: button(
                    Icons.flip_camera_ios_outlined, Alignment.bottomLeft),
              ),
              GestureDetector(
                onTap: () {
                  takePicture();
                },
                child:
                    button(Icons.camera_alt_outlined, Alignment.bottomCenter),
              ),
              GestureDetector(
                onTap: () {
                  print(pictures);
                  previewImage();
                },
                child: button(Icons.image_outlined, Alignment.bottomRight),
              ),
            ],
          ));
    } else {
      return const SizedBox();
    }
  }

  Future<void> takePicture() async {
    await cameraController.takePicture().then((XFile? file) {
      if (file != null) {
        lastPicturePath = file.path;
        pictures.add(file.path);
      } else {
        toast('Error while taking picture', 'error');
      }
    });
  }

  void switchDirection() {
    direction = direction == 0 ? 1 : 0;
    startCamera(direction);
  }

  void previewImage() {
    if (lastPicturePath == '') {
      toast('No image to preview', 'error');
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
          Gallery(pictures: pictures)),
              //PreviewImage(image: File(lastPicturePath))),
    );
  }
}
