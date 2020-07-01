import 'package:cookie/localData/IngridientsData.dart';
import 'package:cookie/services/services.dart';
import 'package:cookie/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final TextEditingController editingController1 = TextEditingController();
final TextEditingController editingController2 = TextEditingController();
final TextEditingController editingController3 = TextEditingController();

class AddRecipe extends StatelessWidget {
  @override
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
                  InputField(
                      editingController: editingController1, label: 'Title'),
                  InputField(
                      editingController: editingController2, label: 'Cusine'),
                  InputField(
                      editingController: editingController3, label: 'Cook'),
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
                      return showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            // Retrieve the text the user has entered by using the
                            // TextEditingController.
                            content: Text(editingController1.text),
                          );
                        },
                      );

                      /* DatabaseService().addIngredients(gemuese, 'Gemüse', 'g'); */
                    },
                    color: Colors.amber,
                    child: Text('test',
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
