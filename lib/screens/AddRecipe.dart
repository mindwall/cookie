import 'package:cookie/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddRecipe extends StatelessWidget {
  final TextEditingController editingController = TextEditingController();
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
                      editingController: editingController, label: 'Title'),
                  InputField(
                      editingController: editingController, label: 'Cusine'),
                  InputField(
                      editingController: editingController, label: 'Cook'),
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
