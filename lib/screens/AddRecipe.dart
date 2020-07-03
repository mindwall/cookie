import 'package:cookie/localData/IngridientsData.dart';
import 'package:cookie/services/services.dart';
import 'package:cookie/shared/shared.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final TextEditingController title = TextEditingController();
final TextEditingController cusine = TextEditingController();
final TextEditingController cook = TextEditingController();
List<Ingredient> ingredients = testIng;
List<Steps> steps = testSteps;
String imageUrl =
    'https://firebasestorage.googleapis.com/v0/b/cook-ie.appspot.com/o/Omelette.jpg?alt=media&token=b99d02c0-a1c6-4c5e-b558-fbf6930c7bba';
String uid;
String filePath = 'images/${title.text}$uid.png';

class AddRecipe extends StatefulWidget {
  @override
  _AddRecipeState createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  @override
  Recipe createNewRecipe() {
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
      imageDB: NetworkImage(imageUrl),
    );
  }

  void initState() {
    super.initState();
    fetchUser();
  }

  fetchUser() async {
    uid = await AuthService().getUser.then((value) => value.uid);
  }

  /* final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://cook-ie.appspot.com');

  StorageUploadTask _uploadTask;

  /// Starts an upload task
  void _startUpload() {
    /// Unique file name for the file

    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(widget.file);
    });
  }

  Future<String> getImageUrl() async {
    StorageTaskSnapshot snapshot =
        await _storage.ref().child(filePath).putFile(widget.file).onComplete;
    final String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  } */

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
                  AddImage(title: title.text, uid: uid),
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
                    onPressed: () {
                      //Uploader._startUpload;
                      createNewRecipe();
                      DatabaseService().addRecipe(createNewRecipe());
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
