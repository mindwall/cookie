import 'dart:io';
import 'package:cookie/screens/AddRecipe.dart';
import 'package:cookie/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';

class AddImage extends StatefulWidget {
  createState() => AddImageState();
}

class AddImageState extends State<AddImage> {
  Future getImage(ImageSource source) async {
    final pickedFile =
        await picker.getImage(source: source, maxHeight: 1000, maxWidth: 1000);

    setState(() {
      image = File(pickedFile.path);
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
              onPressed: () => getImage(
                ImageSource.camera,
              ),
              child: Icon(Icons.add_a_photo),
            ),
            MaterialButton(
              onPressed: () => getImage(ImageSource.gallery),
              child: Icon(Icons.image),
            ),
          ],
        ),
        SizedBox(height: 50),
        image != null && ready ? Uploader() : SizedBox(height: 10),
        image != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image.file(
                  image,
                  width: 300,
                  height: 400,
                  fit: BoxFit.fitHeight,
                ),
              )
            : SizedBox(
                width: 250.0,
                height: 350.0,
                child: Shimmer.fromColors(
                  period: Duration(milliseconds: 1700),
                  baseColor: Color(0xFF4A3E3E),
                  highlightColor: Color(0xFF574D4D),
                  child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xFF4A3E3E),
                          borderRadius: BorderRadius.circular(40))),
                ),
              ),
      ],
    );
  }
}
