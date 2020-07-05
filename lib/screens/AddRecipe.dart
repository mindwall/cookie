import 'dart:io';
import 'package:cookie/localData/IngridientsData.dart';
import 'package:cookie/services/services.dart';
import 'package:cookie/shared/shared.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

final TextEditingController title = TextEditingController();
final TextEditingController cusine = TextEditingController();
final TextEditingController cook = TextEditingController();
final FirebaseStorage storage =
    FirebaseStorage(storageBucket: 'gs://cook-ie.appspot.com');
List<Ingredient> ingredients = testIng;
List<Steps> steps = testSteps;
String imageUrl = '';
String uid;
File image;
final picker = ImagePicker();
String filePath = 'images/${title.text}$uid.png';
bool ready = false;
StorageUploadTask uploadTask;

class AddRecipe extends StatefulWidget {
  @override
  _AddRecipeState createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  void startUpload() async {
    var imagePath = storage.ref().child(filePath);
    uploadTask = imagePath.putFile(image);
  }

  Future<Recipe> createNewRecipe() async {
    var taskCompleted = await uploadTask.onComplete;
    imageUrl = await taskCompleted.ref.getDownloadURL();
    return Recipe(
      title: title.text,
      cusine: cusine.text,
      cook: cook.text,
      favorite: false,
      uid: uid,
      cooked: 0,
      notes: '',
      ingredient: ingredients,
      steps: steps,
      time: '',
      imageDB: NetworkImage(imageUrl),
    );
  }

  void initState() {
    super.initState();
    fetchUser();
  }

  void flip() => setState(() {
        ready = true;
      });
  void fetchUser() async {
    uid = await AuthService().getUser.then((value) => value.uid);
  }

  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black45, blurRadius: 30, offset: Offset(30, 0))
          ],
        ),
        child: Scaffold(
          backgroundColor: Color(0xFF362E2E),
          body: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  SizedBox(height: 30),
                  Text(
                    'Add New Recipe',
                    style: GoogleFonts.josefinSlab(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 2.5,
                        height: 0.1),
                  ),
                  SizedBox(height: 10),
                  InputField(editingController: title, label: 'Title'),
                  InputField(editingController: cusine, label: 'Cusine'),
                  InputField(editingController: cook, label: 'Cook'),
                  SizedBox(height: 20),
                  Text('Add Ingredients',
                      style: GoogleFonts.josefinSlab(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 2.5,
                      )),
                  SizedBox(height: 10),
                  //ToDo implement add step and modify ButtonsRow to accomodate
                  ButtonsRow(),
                  SizedBox(height: 10),
                  Text('Add a Step',
                      style: GoogleFonts.josefinSlab(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 2.5,
                      )),
                  SizedBox(height: 10),
                  //ToDo implement add step and modify ButtonsRow to accomodate
                  ButtonsRow(),
                  SizedBox(height: 10),
                  AddImage(),
                  MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: Colors.amber,
                    child: Text('Save',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        )),
                  ),
                  SizedBox(height: 20),
                  MaterialButton(
                    onPressed: () {
                      print('added');
                      DatabaseService().addIngredients(basics, 'Basics', '');
                    },
                    color: Colors.amber,
                    child: Text('test',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        )),
                  ),
                  MaterialButton(
                    onPressed: () async {
                      startUpload();
                      flip();
                      await createNewRecipe();
                      DatabaseService().addRecipe(await createNewRecipe());
                    },
                    color: Colors.amber,
                    child: Text('Add Recipe',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        )),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
