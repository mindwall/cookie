import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class AddImage extends StatefulWidget {
  createState() => AddImageState();
}

class AddImageState extends State<AddImage> {
  File _image;
  final picker = ImagePicker();

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              onPressed: () => getImage(ImageSource.camera),
              child: Icon(Icons.add_a_photo),
            ),
            MaterialButton(
              onPressed: () => getImage(ImageSource.gallery),
              child: Icon(Icons.image),
            ),
          ],
        ),
        _image != null
            ? Image.file(
                _image,
                width: 300,
              )
            : SizedBox(height: 10),
      ],
    );
  }
}
