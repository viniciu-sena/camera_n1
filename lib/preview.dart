import 'dart:io';

import 'package:camera_n1/components/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PreviewImage extends StatelessWidget {
  final File image;

  const PreviewImage({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 65, 85, 1),
        title: const Text('Preview'),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: FileImage(image),
              fit: BoxFit.fill,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: button(Icons.cloud, Alignment.bottomRight)
              ),
            ],
          ),
        ),
      ),
    );
  }
}
