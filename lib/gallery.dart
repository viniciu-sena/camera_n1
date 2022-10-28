import 'dart:io';

import 'package:camera_n1/preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Gallery extends StatelessWidget {
  final List<String> pictures;

  const Gallery({Key? key, required this.pictures}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(255, 65, 85, 1),
          title: const Text('Gallery'),
        ),
        body: Container(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: pictures.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PreviewImage(
                        image: File(pictures[index]),
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(File(pictures[index])),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              );
            },
          ),
        )
    );
  }
}