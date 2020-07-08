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
List<Ingredient> ingredients;
List<Steps> steps;
String imageUrl;
String uid;
File image;
final picker = ImagePicker();
String filePath = 'images/${title.text}$uid.png';
bool ready = false;
StorageUploadTask uploadTask;
String times;

class AddRecipe extends StatefulWidget {
  @override
  _AddRecipeState createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  void startUpload() async {
    if (image != null) {
      var imagePath = storage.ref().child(filePath);
      uploadTask = imagePath.putFile(image);
    }
  }

  Future<Recipe> createNewRecipe() async {
    var taskCompleted =
        (uploadTask != null) ? await uploadTask.onComplete : null;
    imageUrl =
        (taskCompleted != null) ? await taskCompleted.ref.getDownloadURL() : '';

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
      time: times,
      imageDB: NetworkImage(imageUrl ?? ''),
    );
  }

  void initState() {
    super.initState();
    fetchUser();
  }

  // ignore: missing_return
  void setTime() {
    var hours = TimePicker.getSelectedHours() ?? 0;
    var minutes = TimePicker.getSelectedMinutes() ?? 0;

    if (hours == 0)
      times = minutes.toString() + 'min';
    else if (hours > 0 && minutes != 60)
      times = hours.toString() + 'Stunde, ' + minutes.toString() + 'min';
    else
      times = (hours + 1).toString() + 'Stunden';
  }

  void setIngredients() {
    ingredients = IngredientSelecter.getRecipeIngredient();
  }

  void setSteps() {
    steps = StepsSelecter.getRecipeSteps();
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
          color: Color(0xFF362E2E),
          boxShadow: [
            BoxShadow(
                color: Colors.black45, blurRadius: 30, offset: Offset(30, 0))
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              child: PageView(scrollDirection: Axis.horizontal, children: [
                Info(),
                /* MaterialButton(
                  onPressed: () {
                    print('added');
                    DatabaseService().addIngredients(
                      pasta,
                      'Pasta',
                      'g',
                    );
                  },
                ), */
                IngredientSelecter(),
                StepsSelecter(),
                Container(height: 300, width: 300, child: AddImage()),
                Center(
                  child: Container(
                    height: 50,
                    child: MaterialButton(
                      onPressed: () async {
                        setTime();
                        setIngredients();
                        setSteps();
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
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class Info extends StatelessWidget {
  const Info({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
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
          TimePicker(),
        ],
      ),
    );
  }
}
