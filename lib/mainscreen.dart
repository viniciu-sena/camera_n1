import 'dart:io';

import 'package:camera/camera.dart';
import 'package:camera_n1/preview.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    startCamera(0);
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
      print(error);
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
          backgroundColor: Color.fromARGB(255, 48, 47, 47),
          body: Stack(
            children: [
              CameraPreview(cameraController),
              GestureDetector(
                onTap: () {
                  direction = direction == 0 ? 1 : 0;
                  startCamera(direction);
                },
                child: button(
                    Icons.flip_camera_ios_outlined, Alignment.bottomLeft),
              ),
              GestureDetector(
                onTap: () {
                  cameraController.takePicture().then((XFile? file) {
                    if (mounted) {
                      if (file != null) {
                        lastPicturePath = file.path;
                        startCamera(direction);
                      }
                    }
                  });
                },
                child:
                    button(Icons.camera_alt_outlined, Alignment.bottomCenter),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            PreviewImage(image: File(lastPicturePath))),
                  );
                },
                child: button(Icons.image_outlined, Alignment.bottomRight),
              ),
            ],
          ));
    } else {
      return const SizedBox();
    }
  }

  Widget button(IconData icon, Alignment alignment) {
    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.all(20),
        height: 50,
        width: 50,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black,
                blurRadius: 5,
                spreadRadius: 1,
                offset: Offset(2, 2))
          ],
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
